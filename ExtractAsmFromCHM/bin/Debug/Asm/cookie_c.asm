

/*	Cookie Monster															*/
/*  Copyright (C) 1987 by Walker A. Archer									*/
/*						  169 Albertson										*/
/*						  Rochester, MI  48063								*/
/*																			*/
/*	Release 1.0	- 10/20/87 - First production release						*/
/*																			*/
/*	Special thanks to Michael Quinlan from whom much of this				*/
/*	code was borrowed.                                              	    */
/*																			*/
/*	I hereby donate this package to the public domain.  Use it at your		*/
/*	own risk.  I make no claims or guarantees for its fitness for use		*/
/*	on any system, nor will I accept responsibility for lost or damaged		*/
/*	data.  Should anyone make changes to this code, please update the		*/
/*	release information at the top of this source file with comments		*/
/*	regarding the changes or improvements made.	 Please send all comments	*/
/*	to the above address or contact me via Softlaw BBS (313) 474-4217.		*/
/*																			*/
/*	Cookie Monster is based on a mainframe prank program which has			*/
/*	become popular at a number of universities.  Cookie Monster installs	*/
/*	itself into memory and remains there until it decides to wake up.		*/
/*	When it wakes up, a window is displayed in the middle of whatever		*/
/*	the user happens to be in, and a prompt is shown that says				*/
/*	'Gimme a cookie'.  The user must then figure out that he must enter		*/
/*	a type of cookie from the keyboard.  He must also figure out what		*/
/*	kind of cookie the monster is hungry for, because if you get the		*/
/*	wrong kind of cookie the monster will become more and more persistent,	*/
/*	interrupting whatever the user is doing each time it prompts for a 		*/
/*	cookie.																	*/
/*																			*/
/*	Usage is:																*/
/*																			*/
/*				COOKIE <nnnn>												*/
/*																			*/
/*					where nnnn is a number between 10 and 1000.				*/
/*																			*/
/*	The optional parameter sets the frequency that the Cookie Monster is	*/
/*	likely to wake up.  Cookie Monster chooses whether or not to wake up	*/
/*	randomly each time a keystroke is entered.  The default ratio is		*/
/*	1000:1. Therefore, if you enter COOKIE without the optional parameter	*/
/*	there is a 1000 to 1 chance that Cookie Monster will wake up on any 	*/
/*	individual keystroke.  If you enter COOKIE 100 there is a 100:1 chance  */
/*	that the Cookie Monster will wake up.  The ratio is decreased each		*/
/*	time a wrong response is detected, so there is a greater chance that	*/
/*	the Cookie Monster will wake up.  If a correct response is detected		*/
/*	the ratio is set back to the original and a new cookie is randomly		*/
/*	selected.																*/
/*																			*/
/*	Have fun with Cookie Monster, I know I had fun writing him.				*/
/*																			*/
/*	Only one known bug exists at the time of release.  For some reason		*/
/*	the color is occasionally lost on one or two characters on the echoed	*/
/*	text.  This text is sent to the screen via bios calls.  I assume that	*/
/*	an interrupt is catching my program somewhere and changing the 			*/
/*	attribute values.  I'll continue to debug this problem because it 		*/
/*	makes the screen look sloppy, however it shouldn't cause any serious	*/
/*	problems.																*/
/*																			*/
/*	When compiling this source you should use the tiny model, but leave		*/
/*	cookie in its exe form.  It cannot be converted to a com file.  You		*/
/*	should expect 6 warning messages.  These are mostly because I ignored	*/
/*	the most significant bytes returned by biostime(), which I use as my	*/
/*	random number generator.												*/

#include <dos.h>
#include <process.h>
#include <ctype.h>
#include <mem.h>

long biostime(int,long);

#define KeybdVect		0x09
#define KB_Data			0x60

#define NULL 0x00

void interrupt (*old_keyboard)(void);

unsigned int COOKIE_Active	= 0;	/* Non-zero when we are "popped up" */
int Cookie_num = 0;

#define MAX_FREQ 1000
int Frequency = MAX_FREQ;
int SavFreq = MAX_FREQ;

#define SCR_ROW				25
#define SCR_COL				80
#define	WINDOW_ROW			7
#define WINDOW_COL			60
#define WINDOW_UL_ROW		2
#define WINDOW_UL_COL		10

#define W_TO_S_ROW(x)		((x)+WINDOW_UL_ROW)
#define W_TO_S_COL(x)		((x)+WINDOW_UL_COL)
#define RC_TO_OFF(row,col)	(((row)*SCR_COL + (col)) * 2)

#define NORM_ATTR				0x1E

char OldScreen[SCR_COL*SCR_ROW*2];
char far *VideoBuffer;

#define NUM_OF_COOKIES 13

char Cookie_type[NUM_OF_COOKIES][15] = {
	"chocolate chip",
	"oreo",
    "macaroon",      			/*  The baker's dozen  */
    "oatmeal",
    "peanut butter",
    "fig newton",
    "lady fingers",
    "sugar",
    "vanilla wafers",
    "pecan sandies",
    "chips ahoy",
    "ginger snaps",
    "girl scout"
};

#define INCORRECT_NUM 5

char Bad_Resp[INCORRECT_NUM][17] = {
	"Blech!!!",
	"Me no like that.",
	"Yuck!!!",
	"Ugh...",
	"Arghhh!!"
};

#define CORRECT_NUM 5

char Good_Resp[CORRECT_NUM][17] = {
	"Mmmm... me like!",
	"YummmYummm",
	"Oh boy... Tanks",
	"Delicious...",
	"Thank You"
};
	

char NewScreen[WINDOW_COL*WINDOW_ROW+1] =
	"ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ Info-Tech Cookie Monster ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
	"º                                                          º"
	"º         Gimme a cookie!                                  º"
	"º                                                          º"
	"º                                                          º"
	"º                                                          º"
	"ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼";

#define ESC_KEY 			0x1B
#define CR_KEY				0x0D
#define BS_KEY				0x08

/*------------------------------------------------------------------------*/
/*                                                                        */
/*   exit - Reduce code size by replacing the standard exit function.     */
/*          We don't use files, so there is no need to bring in the file  */
/*          system just to close files.                                   */
/*                                                                        */
/*------------------------------------------------------------------------*/
void cdecl exit(int status)
{
	_exit(status);
}

/*------------------------------------------------------------------------*/
/*                                                                        */
/*   _setenvp - Suppress this library function to conserve code space.    */
/*                                                                        */
/*------------------------------------------------------------------------*/
void cdecl _setenvp(void)	{}

/*------------------------------------------------------------------------*/
/*                                                                        */
/*   main - Main Program.  Initialize interrupt vectors, etc.             */
/*                                                                        */
/*------------------------------------------------------------------------*/
cdecl main(int argc, char *argv[])
{
	void interrupt KeybdHandler(void);
	unsigned int prgsize(void);
	int atoi(char *);
	unsigned int biosequip(void);
	static int i;
	static unsigned int j;

	bdosptr(0x09,"COOKIE MONSTER\r\n$",0);
	bdosptr(0x09,"Copyright (c) 1987 by Walker Archer\r\n$",0);
	bdosptr(0x09,"Initiating lurk mode.\r\n$",0);
	j = biosequip();
	if ((j & 48) == 48)								/* Check for mono or	*/
		VideoBuffer = (char far *) 0xB0000000L;		/*   color monitor		*/
	else
		VideoBuffer = (char far *) 0xB8000000L;

	if (argv[1] != NULL) {
		if ((i = atoi(argv[1])) > 9 && (i <1001)) savfreq="Frequency" =="" i;="" else="" {="" bdosptr(0x09,"\r\nerror="" -="" argument="" must="" be="" between="" 10="" and="" 1000\r\n$",0);="" bdosptr(0x09,"\r\ncontinuing="" installation="" with="" a="" default="" of="" 1000\r\n$",0);="" }="" }="" old_keyboard="getvect(KeybdVect);" setvect(keybdvect,="" keybdhandler);="" cookie_num="biostime(0,0)%NUM_OF_COOKIES;" keep(0,="" prgsize());="" }="" ------------------------------------------------------------------------*/="" */="" prgsize="" -="" calculate="" program="" size.="" */="" */="" __brklvl="" has="" the="" end="" of="" initialized="" and="" uninitialized="" data="" within="" */="" the="" data="" segment="" at="" program="" startup.="" it="" is="" then="" incremented="" and="" */="" decremented="" as="" memory="" is="" malloc'd="" and="" free'd.="" */="" */="" this="" function="" works="" in="" tiny,="" small,="" and="" medium="" models.="" */="" */="" ------------------------------------------------------------------------*/="" unsigned="" int="" prgsize(void)="" {="" extern="" unsigned="" __brklvl;="" extern="" unsigned="" _psp;="" return="" (_ds="" +="" (__brklvl="" +="" 15)="" 16="" -="" _psp);="" }="" ------------------------------------------------------------------------*/="" */="" keybdhandler="" -="" handle="" keyboard="" interrupts.="" check="" for="" our="" popup="" code.="" */="" if="" so,="" and="" if="" we="" are="" not="" already="" active,="" then="" invoke="" */="" the="" popup="" program.="" otherwise="" pass="" the="" stuff="" on="" to="" the="" */="" original="" handler.="" */="" */="" static="" and="" global="" variables="" are="" used="" to="" keep="" the="" stack="" size="" to="" a="" */="" minimum.="" */="" */="" ------------------------------------------------------------------------*/="" void="" interrupt="" keybdhandler()="" {="" void="" cookie(void);="" unsigned="" int="" getkey(void);="" long="" biostime(int,long);="" static="" char="" c;="" c="inportb(KB_Data);" (*old_keyboard)();="" if="" (((biostime(0,0)%frequency)="=" 0)="" &&="" (cookie_active="" !="1))" {="" ++cookie_active;="" getkey();="" cookie();="" --cookie_active;="" }="" }="" void="" cookie(void)="" {="" void="" set_curs_pos(unsigned="" int,unsigned="" int,unsigned="" int);="" void="" get_curs_pos(unsigned="" int="" *,unsigned="" int="" *,unsigned="" int);="" void="" savewindow(void);="" void="" restorewindow(void);="" void="" displaywindow(void);="" void="" print_str(char="" *,int,int);="" void="" print_char(char,int,int);="" void="" get_str(char="" *,int,int,int);="" unsigned="" int="" getkey(void);="" int="" stricmp(char="" *,char="" *);="" unsigned="" strlen(char="" *);="" static="" unsigned="" int="" savrow,savcol;="" static="" char="" got_cookie[16];="" static="" int="" l;="" savewindow();="" save="" the="" screen="" */="" displaywindow();="" and="" pop="" up="" the="" window="" */="" get_curs_pos(&savrow,&savcol,0);="" save="" current="" cursor="" position="" */="" set_curs_pos(4,36,0);="" then="" move="" cursor="" to="" the="" window="" */="" get_str(got_cookie,18,15,0);="" accept="" input="" */="" if="" (stricmp(got_cookie,cookie_type[cookie_num]))="" {="" wrong="" response="" */="" l="biostime(0,0)%INCORRECT_NUM;" set_curs_pos(6,(40="" -="" (strlen(bad_resp[l])="" 2)),0);="" print_str(bad_resp[l],15,0);="" if="" (frequency=""> 10)				/* Adjust the frequency ratio		*/
			Frequency /= 2;

	}
	else {								/* Correct response					*/
		l = biostime(0,0)%CORRECT_NUM;
		Set_curs_pos(6,(40 - (strlen(Good_Resp[l]) / 2)),0);
		Print_Str(Good_Resp[l],15,0);
		Frequency = SavFreq;
		Cookie_num = biostime(0,0)%NUM_OF_COOKIES;		
	}
	for (l=0;l<32000;l++); for="" (l=""></32000;l++);><32000;l++); set_curs_pos(savrow,savcol,0);="" then="" restore="" old="" curs="" pos="" */="" restorewindow();="" restore,="" makes="" window="" disapear="" */="" }="" void="" savewindow(void)="" {="" movedata(fp_seg(videobuffer),="" 0,="" _ds,="" (int)="" oldscreen,="" scr_col*scr_row*2);="" }="" void="" restorewindow(void)="" {="" movedata(_ds,="" (int)="" oldscreen,="" fp_seg(videobuffer),="" 0,="" scr_col*scr_row*2);="" }="" void="" displaywindow(void)="" {="" static="" int="" row,="" col;="" static="" char="" *sp,="" far="" *dp;="" dp="VideoBuffer" +="" (window_ul_row*scr_col="" +="" window_ul_col)*2;="" sp="NewScreen;" for="" (row="0;"></32000;l++);><window_row; row++)="" {="" for="" (col="0;"></window_row;><window_col; col++)="" {="" *dp++="*sp++;" *dp++="NORM_ATTR;" }="" dp="" +="(SCR_COL-WINDOW_COL)*2;" }="" }="" ------------------------------------------------------------------------*/="" */="" getkey="" -="" get="" a="" key="" from="" the="" keyboard="" via="" bios="" calls.="" */="" */="" ------------------------------------------------------------------------*/="" unsigned="" int="" getkey(void)="" {="" int="" bioskey(int);="" static="" unsigned="" int="" c;="" c="bioskey(0);" if="" ((c="" &="" 0x00ff)="" !="0)" return="" (c="" &="" 0x00ff);="" else="" return="" c;="" }="" ------------------------------------------------------------------------*/="" */="" set_curs_pos="" -="" set="" the="" cursor="" position="" via="" bios="" calls.="" the="" */="" caller="" must="" send="" the="" page="" number="" (usually="" 0)="" */="" in="" addition="" to="" the="" row="" and="" column="" to="" maintain="" */="" flexibility="" for="" use="" in="" other="" programs.="" */="" */="" ------------------------------------------------------------------------*/="" void="" set_curs_pos(unsigned="" int="" row,unsigned="" int="" col,unsigned="" int="" page)="" {="" _ax="0x0200;" _dl="col;" _dh="row;" _bh="page;" geninterrupt(0x10);="" }="" ------------------------------------------------------------------------*/="" */="" get_curs_pos="" -="" get="" the="" cursor="" position="" via="" bios="" calls.="" the="" */="" caller="" must="" send="" the="" page="" number="" (usually="" 0)="" */="" in="" addition="" to="" the="" row="" and="" column="" to="" maintain="" */="" flexibility="" for="" use="" in="" other="" programs.="" */="" */="" ------------------------------------------------------------------------*/="" void="" get_curs_pos(unsigned="" int="" *row,unsigned="" int="" *col,unsigned="" int="" page)="" {="" _ax="0x0300;" _bh="page;" geninterrupt(0x10);="" *col="_DL;" *row="_DH;" }="" ------------------------------------------------------------------------*/="" */="" print_char="" -="" print="" a="" character="" to="" the="" screen="" via="" bios="" calls.="" */="" caller="" must="" send="" the="" page="" number="" (usually="" 0)="" */="" in="" addition="" to="" the="" character="" and="" attribute="" in="" */="" order="" to="" maintain="" flexibility.="" */="" */="" ------------------------------------------------------------------------*/="" void="" print_char(char="" c,="" int="" attr,="" int="" page)="" {="" _ah="14;" _al="c;" _bl="attr;" _bh="page;" geninterrupt(0x10);="" }="" void="" print_str(char="" *s,="" int="" attr,="" int="" page)="" {="" static="" char="" c;="" while="" ((c="*s++)" !="0)" print_char(c,="" attr,="" page);="" }="" ------------------------------------------------------------------------*/="" */="" get_str="" -="" print="" a="" string="" to="" the="" screen="" via="" bios="" calls.="" the="" */="" caller="" must="" send="" the="" page="" number="" (usually="" 0)="" */="" in="" addition="" to="" the="" string="" and="" attribute="" in="" */="" order="" to="" maintain="" flexibility.="" */="" */="" ------------------------------------------------------------------------*/="" void="" get_str(char="" *s,="" int="" len,="" int="" attr,="" int="" page)="" {="" static="" char="" c;="" static="" int="" i="0;" while="" ((c="bioskey(0))" !="CR_KEY)" {="" switch="" (c)="" {="" case="" bs_key:="" if="" (i=""> 0) {
					*s--;
					i--;
					Print_Char(c, attr, page);
					Print_Char(' ', attr, page);
					Print_Char(c, attr, page);
				}
				break;
			case ESC_KEY:
				break;
			default:
				if (i < len)="" {="" *s++="c;" i++;="" print_char(c,="" attr,="" page);="" }="" break;="" }="" }="" *s='\0' ;="" i="0;" }=""></window_col;></1001))></mem.h></ctype.h></process.h></dos.h></nnnn>