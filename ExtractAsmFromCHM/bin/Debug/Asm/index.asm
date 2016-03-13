﻿


            Are "Good" Computer Viruses Still a Bad Idea?

                Vesselin Bontchev, research associate
               Virus Test Center, University of Hamburg
             Vogt-Koelln-Str. 30, 22527 Hamburg, Germany
               bontchev@fbihh.informatik.uni-hamburg.de


    During the past six years, computer viruses have caused
    unaccountable amount of damage - mostly due to loss of time
    and resources.  For most users, the term "computer virus" is
    a synonym of the worst nightmares that can happen on their
    system.  Yet some well-known researchers keep insisting that
    it is possible to use the replication mechanism of the viral
    programs for some useful and beneficial purposes.

    This paper is an attempt to summarize why exactly the general
    public appreciates computer viruses as something inherently
    bad.  It is also considering several of the proposed models
    of "beneficial" viruses and points out the problems in them.
    A set of conditions is listed, which every virus that claims
    to be beneficial must conform to.  At last, a realistic model
    using replication techniques for beneficial purposes is
    proposed and directions are given in which this technique can
    be improved further.

    The paper also demonstrates that the main reason for the
    conflict between those supporting the idea of a "beneficial
    virus" and those opposing it, is that the two sides are
    assuming a different definition of what a computer virus is.

1. What Is a Computer Virus?

The general public usually associates the term "computer virus" with a
small, nasty program, which aims to destroy the information on their
machines.  As usual, the general public's understanding of the term is
incorrect.  There are many kinds of destructive or otherwise malicious
computer programs and computer viruses are only one of them.  Such
programs include backdoors, logic bombs, trojan horses and so on
[Bontchev94].  Furthermore, many computer viruses are not
intentionally destructive - they simply display a message, play a
tune, or even do nothing noticeable at all.  The important thing,
however, is that even those not intentionally destructive viruses are
not harmless - they are causing a lot of damage in the sense of time,
money and resources spent to remove them - because they are generally
unwanted and the user wishes to get rid of them.

A much more precise and scientific definition of the term "computer
virus" has been proposed by Dr. Fred Cohen in his paper [Cohen84].
This definition is mathematical - it defines the computer virus as a
sequence of symbols on the tape of a Turing Machine. The definition is
rather difficult to express exactly in a human language, but an
approximate interpretation is that a computer virus is a "program that
is able to infect other programs by modifying them to include a
possibly evolved copy of itself".

Unfortunately, there are several problems with this definition. One of
them is that it does not mention the possibility of a virus to infect
a program without modifying it - by inserting itself in the execution
path. Some typical examples are the boot sector viruses and the
companion viruses [Bontchev94]. However, this is a flaw only of the
human-language expression of the definition - the mathematical
expression defines the terms "program" and "modify" in a way that
clearly includes the kinds of viruses mentioned above.

A second problem with the above definition is its lack of
recursiveness. That is, it does not specify that after infecting a
program, a virus should be able to replicate further, using the
infected program as a host.

Another, much more serious problem with Dr. Cohen's definition is that
it is too broad to be useful for practical purposes. In fact, his
definition classifies as "computer viruses" even such cases as a
compiler which is compiling its own source, a file manager which is
used to copy itself, and even the program DISKCOPY when it is on
diskette containing the operating system - because it can be used to
produce an exact copy of the programs on this diskette.

In order to understand the reason of the above problem, we should pay
attention to the goal for which Dr. Cohen's definition has been
developed.  His goal has been to prove several interesting theorems
about the computational aspects of computer viruses [Cohen89].  In
order to do this, he had to develop a mathematical (formal) model of
the computer virus.  For this purpose, one needs a mathematical model
of the computer.  One of the most commonly used models is the Turing
Machine (TM).  Indeed, there are a few others (e.g., the Markoff
chains, the Post Machine, etc.), but they are not as convenient as the
TM and all of them are proven to be equivalent to it.

Unfortunately, in the environment of the TM model, we cannot speak
about "programs" which modify "other programs" - simply because a TM
has only one, single program - the contents of the tape of that TM.
That's why Cohen's model of a computer virus considers the history of
the states of the tape of the TM. If a sequence of symbols on this
tape appears at a later moment somewhere else on the tape, then this
sequence of symbols is said to be a computer virus for this particular
TM. It is important to note that a computer virus should be always
considered as related to some given computing environment - a
particular TM. It can be proven ([Cohen89]) that for any particular TM
there exists a sequences of symbols which is a virus for that
particular TM.

Finally, the technical computer experts usually use definitions for
the term "computer virus", which are less precise than Dr. Cohen's
model, while in the same time being much more useful for practical
reasons and still being much more correct than the general public's
vague understanding of the term. One of the best such definitions is
([Seborg]):

    "We define a computer 'virus' as a self-replicating program
    that can 'infect' other programs by modifying them or their
    environment such that a call to an 'infected' program implies
    a call to a possibly evolved, and in most cases, functionally
    similar copy of the 'virus'."

The important thing to note is that a computer virus is a program that
is able to replicate by itself. The definition does not specify
explicitly that it is a malicious program. Also, a program that does
not replicate is not a virus, regardless of whether it is malicious or
not. Therefore the maliciousness is neither a necessary, nor a
sufficient property for a program to be a computer virus.

Nevertheless, in the past ten years a huge number of intentionally or
non intentionally destructive computer viruses have caused an
unaccountable amount of damage - mostly due to loss of time, money,
and resources to eradicate them - because in all cases they have been
unwanted. Some damage has also been caused by a direct loss of
valuable information due to an intentionally destructive payload of
some viruses, but this loss is relatively minor when compared to the
main one.  Lastly, a third, indirect kind of damage is caused to the
society - many users are forced to spend money on buying and time on
installing and using several kinds of anti-virus protection.

Does all this mean that computer viruses can be only harmful?
Intuitively, computer viruses are just a kind of technology.  As with
any other kind of technology, they are ethically neutral - they are
neither "bad" nor "good" - it is the purposes that people use them
for that can be "bad" or "good".  So far they have been used mostly
for bad purposes.  It is therefore natural to ask the question whether
it is possible to use this kind of technology for good purposes.

Indeed, several people have asked this question - with Dr. Cohen being
one of the most active proponents of the idea [Cohen91]. Some less
qualified people have attempted even to implement the idea, but have
failed miserably (see section 3). It is natural to ask - why? Let's
consider the reasons why the idea of a "good" virus is usually
rejected by the general public. In order to do this, we shall consider
why people think that a computer virus is always harmful and cannot be
used for beneficial purposes.

2. Why Are Computer Viruses Perceived as Harmful?

About a year ago, we asked the participants of the electronic forum
Virus-L/comp.virus, which is dedicated to discussions about computer
viruses, to list all reasons they could think about why do they
perceive the idea of a "beneficial" virus as a bad one. What follows
is a systematized and generalized list of those reasons.

2.1. Technical Reasons.

This section lists the arguments against the "beneficial virus" idea,
which have a technical character. They are usually the most objective
ones.

2.1.1. Lack of Control.

Once released, the person who has released a computer virus has no
control on how this virus will spread.  It jumps from machine to
machine, using the unpredictable patterns of software sharing among
the users.  Clearly, it can easily reach systems on which it is not
wanted or on which it would be incompatible with the environment and
would cause unintentional damage.  It is not possible for the virus
writer to predict on which systems the virus will run and therefore it
is impossible to test the virus on all those systems for
compatibility.  Furthermore, during its spread, a computer virus could
reach even a system that had not existed when that virus has been
created - and therefore it had been impossible to test the virus for
compatibility with this system.

The above is not always true - that is, it is possible to test the
virus for compatibility on a reasonably large number of systems that
are supposed to run it. However, it is the damaging potential of a
program that is spreading out of control which is scaring the users.

2.1.2. Recognition Difficulty.

Currently a lot of computer viruses already exist, which are either
intentionally destructive or otherwise harmful. There are a lot of
anti-virus programs designed to detect and stop them. All those
harmful viruses are not going to disappear overnight. Therefore, if
one develops a class of beneficial viruses and people actually begin
to use them, then the anti-virus programs will have to be able to make
the difference between the "good" and the "bad" viruses - in order to
let the former in and keep the latter out.

Unfortunately, in general it is theoretically impossible even to
distinguish between a virus and a non-viral program ([Cohen89]). There
is no reason to think that distinguishing between "good" and "bad"
viruses will be much easier. While it might be possible to distinguish
between them using virus-specific anti-virus software (e.g.,
scanners), we should not forget that many people are relying on
generic anti-virus defenses, for instance based on integrity checking.
Such systems are designed to detect modifications, not specific
viruses, and therefore will be triggered by the "beneficial" virus
too, thus causing an unwanted alert. Experience shows that the cost of
such false positives is the same as of a real infection with a
malicious virus - because the users waste a lot of time and resources
looking for a non-existing problem.

2.1.3. Resource Wasting.

A computer virus would eat up disk space, CPU time, and memory
resources during its replication. A computer virus is a
self-replicating resource eater. One typical example is the Internet
Worm, accidentally released by a Carnegie-Mellon student. It was not
designed to be intentionally destructive, but in the process of its
replication, the multiple copies of it used so much resources, that
they practically brought down a large portion of the Internet.

Even when the computer virus uses a limited amount of resources, it is
considered as a bad thing by the owner of the machine on which the
virus is doing it, if it happens without authorization.

2.1.4. Bug Containment.

A computer virus can easily escape the controlled environment and this
makes it very difficult to test such programs properly. And indeed -
experience shows that almost all computer viruses released so far
suffer from significant bugs, which would either prevent them from
working in some environments, or even cause unintentional damage in
those environments.

Of course, any program can (and usually does) contain bugs. This is
especially true for the large and complex software systems. However,
a computer virus is not just a normal buggy program. It is a
self-spreading buggy program, which is out of control. Even if the
author of the virus discovers the bug at a later time, there is the
almost untreatable problem of revoking all existing copies of the
virus and replacing them with fixed new versions.

2.1.5. Compatibility Problems.

A computer virus that can attach itself to any of the user's programs
would disable the several programs on the market that perform a
checksum on themselves at runtime and refuse to run if modified. In a
sense, the virus will perform a denial-of-service attack and thus
cause damage.

Another problem arises from some attempts to solve the "lack of
control" problem by creating a virus that asks for permission before
infecting. Unfortunately, this causes an interruption of the task
being currently executed until the user provides the proper response.
Besides of being annoying for the user, it could be sometimes even
dangerous. Consider the following example.

It is possible that a computer is used to control some kind of
life-critical equipment in a hospital. Suppose that such a computer
gets infected by a "beneficial" computer virus, which asks for
permission before infecting any particular program. Then it is
perfectly possible that a situation arises, when a particular program
has to be executed for the first time after the virus has appeared on
the computer, and that this program has to urgently perform some task
which is critical for the life of a patient. If at that time the virus
interrupts the process with the request for permission to infect this
program, then the caused delay (especially if there is no operator
around to authorize or deny the request) could easily result in the
death of the patient.

2.1.6. Effectiveness.

It is argued that any task that could be performed by a "beneficial"
virus could also be performed by a non-replicating program. Since
there are some risks following from the capability of
self-replication, it would be therefore much better if a
non-replicating program is used, instead of a computer virus.

2.2. Ethical and Legal Reasons.

The following section lists the arguments against the "beneficial
virus" idea, which are of ethical or legal kind. Since neither ethics,
nor the legal systems are universal among the human society, it is
likely that those arguments will have different strength in the
different countries. Nevertheless, they have to be taken into account.

2.2.1. Unauthorized Data Modification.

It is usually considered unethical to modify other people's data
without their authorization. In many countries this is also illegal.
Therefore, a virus which performs such actions will be considered
unethical and/or illegal, regardless of any positive outcome it could
bring to the infected machines. Sometimes this problem is perceived by
the users as "the virus writer claims to know better than me what
software should I run on my machine".

2.2.2. Copyright and Ownership Problems.

In many cases, modifying a particular program could mean that
copyright, ownership, or at least technical support rights for this
program are voided.

We have witnessed such an example at the VTC-Hamburg. One of the users
who called us for help with a computer virus was a sight-impaired
lawyer, who was using special Windows software to display the
documents he was working on with a large font on the screen - so that
he could read them. His system was infected by a relatively
non-damaging virus. However, when the producer of the software learned
that the machine was infected, they refused any technical support
to the user, until the infection was removed and their software -
installed from clean originals.

2.2.3. Possible Misuse.

An attacker could use a "good" virus as a means of transportation to
penetrate a system. For instance, a person with malicious intent
could get a copy of a "good" virus and modify it to include something
malicious. Admittedly, an attacker could trojanize any program, but a
"good" virus will provide the attacker with means to transport his
malicious code to a virtually unlimited population of computer
systems. The potential to be easily modified to carry malicious code
is one of the things that makes a virus "bad".

2.2.4. Responsibility.

Declaring some viruses as "good" and "beneficial" would just provide
an excuse to the crowd of irresponsible virus writers to condone their
activities and to claim that they are actually doing some kind of
"research". In fact, this is already happening - the people mentioned
above are often quoting Dr. Fred Cohen's ideas for beneficial viruses
as an excuse of what they are doing - often without even bothering to
understand what Dr. Cohen is talking about.

2.3. Psychological Reasons.

The arguments listed in this section are of psychological kind.  They
are usually a result of some kind of misunderstanding and should be
considered an obstacle that has to be "worked around".

2.3.1. Trust Problems.

The users like to think that they have full control on what is
happening in their machine. The computer is a very sophisticated
device. Most computer users do not understand very well how it works
and what is happening inside. The lack of knowledge and uncertainty
creates fear. Only the feeling that the reactions of the machine will
be always known, controlled, and predictable could help the users to
overcome this fear.

However, a computer virus steals the control of the computer from the
user. The virus activity ruins the trust that the user has in his/her
machine, because it causes the user to lose his/her belief that s/he
can control this machine. This may be a source of permanent
frustrations.

2.3.2. Negative Common Meaning.

For most people, the word "computer virus" is already loaded with
negative meaning. The media has already widely established the belief
that a computer virus is a synonym for a malicious program. In fact,
many people call "viruses" many malicious programs that are unable to
replicate - like trojan horses, or even bugs in perfectly legitimate
software. People will never accept a program that is labelled as a
computer virus, even if it claims to do something useful.

3. Some Bad Examples of "Beneficial" Viruses.

Regardless of all the objections listed in the previous section,
several people have asked themselves the question whether a computer
virus could be used for something useful, instead of only for
destructive purposes.

And several people have tried to positively answer this question.
Some of them have even implemented their ideas in practice and have
been experimenting with them in the real world - unfortunately,
without success.  In this section we shall present some of the
unsuccessful attempts to create a beneficial virus so far, and explain
why they have been unsuccessful.

3.1. The "Anti-Virus" Virus.

Some computer viruses are designed to work not only in a "virgin"
environment of infectable programs, but also on systems that include
anti-virus software and even other computer viruses. In order to
survive successfully in such environments, those viruses contain
mechanisms to disable and/or remove the said anti-virus programs and
"competitor" viruses. Examples for such viruses in the IBM PC
environment are Den_Zuko (removes the Brain virus and replaces it with
itself), Yankee_Doodle (the newer versions are able to locate the
older ones and "upgrade" the infected files by removing the older
version of the virus and replacing it with the newer one), Neuroquila
(disables several anti-virus programs), and several other viruses.

Several people have had the idea to develop the above behaviour
further and to create an "anti-virus" virus - a virus which would be
able to locate other (presumably malicious) computer viruses and
remove them. Such a self-replicating anti-virus program would have the
benefits to spread very fast and update itself automatically.

Several viruses have been created as an implementation of the above
idea. Some of them locate a few known viruses and remove them from the
infected files, others attach themselves to the clean files and issue
an error message if another piece of code becomes attached after the
virus (assuming that it has to be an unwanted virus), and so on.
However, all such pieces of "self-replicating anti-virus
software" have been rejected by the users, who have considered the
"anti-virus" viruses just as malicious and unwanted as any other
real computer virus. In order to understand why, it is enough to
realize that the "anti-virus viruses" matches several of the rules
that state why a replicating program is considered malicious and/or
unwanted. Here is a list of them for this particular idea.

First, this idea violates the Control condition. Once the "anti-virus"
virus is released, its author has no means to control it.

Second, it violates the Recognition condition. A virus that attaches
itself to executable files will definitely trigger the anti-virus
programs based on monitoring or integrity checking. There is no way
for those programs to decide whether they have been triggered by a
"beneficial" virus or not.

Third, it violates the Resource Wasting condition. Adding an almost
identical piece of code to every executable file on the system is
definitely a waste - the same purpose can be achieved with a single
copy of the code and a single file, containing the necessary data.

Fourth, it violates the Bug Containment condition. There is no easy
way to locate and update or remove all instances of the virus.

Fifth, it causes several compatibility problems, especially to the
selfchecking programs, thus violating the Compatibility condition.

Sixth, it is not as effective as a non-viral program, thus violating
the Effectiveness condition. A virus-specific anti-virus program has
to carry thousands of scan strings for the existing malicious viruses
- it would be very ineffective to attach a copy of it to every
executable file. Even a generic anti-virus (i.e., based on monitoring
or integrity checking) would be more effective if it exists only in
one example and is executed under the control of the user.

Seventh, such a virus modifies other people's programs without their
authorization, thus violating the Unauthorized Modification
condition. In some cases such viruses ask the user for permission
before "protecting" a file by infecting it. However, even in those
cases they cause unwanted interruptions, which, as we already
demonstrated, in some situations can be fatal.

Eight, by modifying other programs such viruses violate the Copyright
condition.

Ninth, at least with the current implementations of "anti-virus"
viruses, it is trivial to modify them to carry destructive code - thus
violating the Misuse condition.

Tenth, such viruses are already widely being used as examples by
the virus writers when they are trying to defend their irresponsible
actions and to disguise them as legitimate research - thus the idea
violates the responsibility condition too.

As we can see from the above, the idea of a beneficial anti-virus
virus is "bad" according to almost any of the criteria listed by the
users.

3.2. The "File Compressor" Virus.

This is one of the oldest ideas for "beneficial" viruses. It is first
mentioned in Dr. Cohen's original work [Cohen84]. The idea consists
of creating a self-replicating program, which will compress the files
it infects, before attaching itself to them. Such a program is
particularly easy to implement as a shell script for Unix, but it is
perfectly doable for the PC too.  And it has already been done - there
is a family of MS-DOS viruses, called Cruncher, which appends itself
to the executable files, then compresses the infected file using
Lempel-Zev-Huffman compression, and then prepends a small decompressor
which would decompress the file in memory at runtime.

Regardless of the supposed benefits, this idea also fails the test of
the criteria listed in the previous section. Here is why.

First, the idea violates the Control condition. Once released, the
author of the virus has no means to controls its spread. In the
particular implementation of Cruncher, the virus writer has attempted
to introduce some kind of control. The virus asks the user for
permission before installing itself in memory, causing unwanted
interruptions.  It is also possible to tell the virus to install
itself without asking any questions - by the means of setting an
environment variable.  However, there are no means to tell the virus
not to install itself and not to ask any questions - which should be
the default action.

Second, the idea violates the Recognition condition. Several virus
scanners detect and recognize Cruncher by name, the process of
infecting an executable triggers most monitoring programs, and the
infected files are, of course, modified, which triggers most integrity
checkers.

Third, the idea violates the Resource condition. A copy of the
decompressor is present in every infected file, which is obviously
unnecessary.

Fourth, the idea violates the Bug Containment condition. If bugs are
found in the virus, the author has no simple means to distribute the
fix and to upgrade all existing copies of the virus.

Fifth, the idea violates the Compatibility condition. There are many
files which stop working after being compressed. Examples include
programs that perform a self-check at runtime, self-modifying
programs, programs with internal overlay structure, Windows
executables, and so on. Admitedly, those programs stop working even
after being compressed with a stand-alone (i.e., non-viral)
compression program. However, it is much more difficult to compress
them by accident when using such a program - quite unlike the case
when the user is running a compression virus.

Sixth, the idea violates the Effectiveness condition. It is perfectly
possible to use a stand-alone, non-viral program to compress the
executable files and prepend a short decompressor to them. This has
the added advantage that the code for the compressor does not have to
reside in every compressed file, and thus we don't have to worry about
its size or speed - because it has to be executed only once. True, the
decompressor code still has to be present in each compressed file and
many programs will still refuse to work after being compressed. The
solution is to use not compression at a file level, but at a disk
level. And indeed, compressed file systems are available for many
operating environments (DOS, Novell, OS/2, Unix) and they are much
more effective than a file-level compressor that spreads like a virus.

Seventh, the idea still violates the Copyright condition. It could be
argued that it doesn't violate the Data Modification condition,
because the user is asked to authorize the infection. We shall accept
this, with the remark mentioned above - that it still causes unwanted
interruptions. It is also not very trivial to modify the virus in
order to make it malicious, so we'll assume that the Misuse condition
is not violated too - although no serious attempts are made to ensure
that the integrity of the virus has not been compromised.

Eighth, the idea violates the responsibility condition.  This
particular virus - Cruncher - has been written by the same person who
has released many other viruses - far from "beneficial" ones - and
Cruncher is clearly used as an attempt to condone virus writing and to
masquerade it as legitimate "research".

3.3. The "Disk Encryptor" Virus.

This virus has been published by Mark Ludwig - author of two books and
a newsletter on virus writing, and of several real viruses, variants
of many of which are spreading in the real world, causing real damage.

The idea is to write a boot sector virus, which encrypts the disks it
infects with a strong encryption algorithm (IDEA in this particular
case) and a user-supplied password, thus ensuring the privacy of the
user's data. Unfortunately, this idea is just as flawed as the
previous ones.

First, it violates the Control condition. True, the virus author has
attempted to introduce some means of control. The virus is supposed to
ask the user for permission before installing itself in memory and
before infecting a disk. However, this still causes unwanted
interruptions and reportedly in some cases doesn't work properly -
that is, the virus installs itself even if the user has told it not
to.

Second, it violates the Recognition condition.  Several virus-specific
scanners recognize this virus either by name or as a variant of
Stealth_Boot, which it actually is.  Due to the fact that it is a boot
sector infector, it is unlikely to trigger the monitoring programs.
However, the modification that it causes to the hard disk when
infecting it, will trigger most integrity checkers.  Those that have
the capability to automatically restore the boot sector, thus removing
any possibly present virus, will cause the encrypted disk to become
inaccessible and therefore cause serious damage.

Third, the idea violates the Compatibility condition. A boot sector
virus that is permanently resident in memory usually causes problems
to Windows when the latter is configured in 32BitDiskAccess mode.
Also, the permanent swap file of Windows must not be put on an
encrypted (or compressed, or otherwise accessible via a device driver)
volume, because during its access Windows controls the hard disk
directly, via the ports, thus bypassing any memory resident program
used to access the disk and almost certainly causing damage.  This
problem is usually solved by putting the permanent swap file on an
unencrypted (or uncompressed) partition, but the virus in question
encrypts the whole disk.  Lastly, the way the virus installs itself on
the hard disk (overwriting a few sectors on track zero) would damage
some (admitedly obsolete) DOS configurations which include this track
in the first partition.

Fourth, the idea violates the Effectiveness condition.  It is
perfectly possible to achieve exactly the same goal (i.e., hard disk
encryption) with a stand-alone (i.e., non-viral) program.  Actually,
several such programs already exist.  Many of them are available in
source - something which is critical for any encryption software,
because it allows the users to check for themselves the security of
the implementation (for instance, that it doesn't contain any
backdoors or security holes).  Most of them are also much faster than
this particular virus.  The disk infection is very slow (because the
virus encrypts the disk at infection time) and the only practical way
to use the virus is to turn the so-called "auto-migration" (i.e.,
infection on disk access) feature off - thus proving that the only
practical way to use this program is without its viral capabilities.
Lastly, the stand-alone disk encryption programs usually come with the
necessary documentation.  Only the original copy of the virus (i.e.,
the Germ) contains the documentation for it; any copy acquired by
infection does not carry it.  And the documentation is quite vital for
the proper usage of this particular program, as the author himself
admits there.

Fifth, the idea violates the responsibility condition - the virus has
been used multiple times by its author and by other virus writers as
an argument to claim that their actions are legitimate.  As
demonstrated above, the only thing that differentiates this particular
virus from a useful disk encryption program is its viral capabilities
- and it is exactly those viral capabilities that make the product
unsuitable for practical use.  Once they are turned off, the product
is usable, thus proving that the viral capabilities are completely
unnecessary.

Sixth, the idea violates Negative Common Meaning condition and causes
several trust problems.  Even the proponents of the idea for
"beneficial" virus writing who are often uploading this virus to the
BBSes are never using it themselves, "because it is a virus".

We are ready to accept that this virus does not contradict the
Resource Wasting condition (because only one copy of it is present per
infected disk and the system slowdown during normal operation - except
replication - is comparable to those of other disk encryption
programs); that it doesn't contradict the Unauthorized Modification
condition (because a user confirmation is required - although this
doesn't seem to always work); that it doesn't contradict the Copyright
condition (because no user programs are modified by it) and even that
it doesn't contradict the Possible Misuse condition - although the
virus does not take any steps to ensure its own integrity and a
relatively knowledgeable hacker could implement some kind of malicious
routine in it.  However, the other conditions that it violates clearly
demonstrate that this program cannot be classified as a beneficial
virus.

3.4. The "Maintenance" Virus.

This virus was first described by Dr.  Fred Cohen in [Cohen91].  The
idea consists of a self-contained program, which spawns copies of
itself across the different machines in a network (thus acting more
like a worm) and performing some maintenance tasks on those machines -
like deleting temporary files and so on.  A similar idea can be
implemented in memory as multiple concurrent processes, instead of
programs in files spreading across the network.

In his description, Dr. Cohen has introduced several techniques that
make the virus conform to some of the conditions listed in the
previous section. Unfortunately, it still fails to conform to all of
them and therefore is yet another failed attempt to create a
beneficial virus.

In order to solve the Control problem, each maintenance virus contains
a check for a special file to be present on the machine. This file is
supposed to be created by the user who wants to use the virus on their
machine and is some form of an invitation. However, no steps are taken
to authenticate this file by some mathematical (e.g., cryptographical)
means - only its name is used as sufficient indication that the virus
is wanted on this particular machine. Also, each virus maintains some
kind of statistic about how effective it is (i.e., how much work it
has done) and a built-in mechanism that automatically kills the
offsprings that are not effective enough. This is supposed to have the
effect of limiting the growth of the number of viruses on the network
to some useful limits.

Because of the way it spreads (as a self-contained executable program,
without modifying other programs), the virus is less likely to trigger
any anti-virus defenses already in place - especially having in mind
that the invitation is supposed to be created by the system
administrator, who should know how to configure the possibly present
integrity checkers in a way that they are not triggered by the
appearance of new executable files (although this would weaken them
and make the system more vulnerable to real viruses).

The Bug Containment condition is also satisfied to some extent. Since
the virus spreads in a relatively limited network, and since the
different instances of it are self-contained, it is relatively easy to
use that same network to automatically distribute updates of the
virus. It would be also easy to shut down all active copies by simply
removing the "invitation" file from the machines connected to the net.

The possible Compatibility problems are solved by putting the burden
of inviting the virus on the system administrators - it is supposed
that before installing the invitation, they should have checked
whether the virus would cause any compatibility problems on their
machines.

Since the virus doesn't modify other programs and removes only
temporary files that the system administrator would have removed
anyway, this neatly solves the Copyright and the Unauthorized
Modification problems too.

Unfortunately, there are still some unsolved problems.  The most
important objection is that the virus violates the Resource Wasting
and Effectiveness conditions.  It performs tasks which are normally
performed by stand-alone regularly scheduled programs at each machine.
Since the task performed by the virus (deletion of temporary files)
has to be done anyway, using a virus does not gain any effectiveness.
It only distributes the task among the different machines on the
network - so it would be faster than if performed by a single machine
across the network.  However, such tasks are normally already
performed locally, by each machine on the network, so they are already
distributed.  Using a virus to achieve the same goal only adds
unnecessary load for copying, executing, and deleting the different
copies of the virus, without any particular gain.  It also introduces
some serious security risks, so it is obviously not worth it to be
used.

Second, the viruses that Dr. Cohen describes do not take any sensible
precautions to authenticate themselves to the systems they infect.
They are implemented as shell scripts and it would be trivial for a
malicious attacker to modify them, remove the safety check, and/or
include some malicious routines.

At last, many system administrators would refuse to use them just
because they are viruses (the Negative Common Meaning problem).
Indeed, Dr. Cohen attempts to solve this problem by calling them LPs
(Live Programs, [Cohen94]), but it is too obvious that they replicate
worm-like, so a name change does not really change anything.

4. How to Construct a Beneficial Virus?

All the unsuccessful attempts to create a beneficial virus that were
listed above suffer from one and the same flaw in their design. Their
authors (maybe with the only exception of Dr. Cohen) are taking a real
virus (which is definitely not beneficial or even not harmless), and
attempt to make it beneficial by adding some useful capabilities to
it. Of course, this approach must fail. A better approach is to
design a beneficial program that does not violate any criteria for
non-maliciousness and only then try to see whether the program could
be made even more useful by adding self-replicating capabilities to
it, without violating the criteria mentioned above.

We shall not discuss here whether the reasons listed in section 2 are
good, appropriate, or necessary. All of them have been expressed in
one way or another by computer users we have discussed this problem
with, so we shall assume that all of them are considered important by
the users. Therefore, in order to be perceived as a "beneficial
virus", a self-replicating program must not contradict any of those
conditions. Let's see whether the problems could be solved and if yes
- how.

4.1. Solving the Technical Problems.

As it turns out, the technical problems are the easiest ones to solve
and, while requiring significant work and research, it is perfectly
possible to solve them.

4.1.1. Solving the Control Problem.

The easiest way to solve the Control problem is not to allow the virus
to spread out of control in the first place. A first step is to make
it ask for permission before infecting, but, as we saw, this could
cause unwanted interruptions. A better solution is for the virus to
check whether some form of invitation is already installed on the
machine, and infect it only if the invitation is present.
Unfortunately, in an environment of a large network (e.g., the
Internet) and a lot of different beneficial viruses available, the
constant polling for invitations performed by those viruses could
cause a serious network overload. Therefore, we should go even further
- instead of passively installing the permission/invitation and
waiting for the virus to infect, a user who wants to use a particular
computer virus must actively send the invitation.

In an environment such as the Internet with mostly Unix-based machines
using TCP/IP for communication, this could be implemented by a set of
interconnected repositories of beneficial viruses, to which the user's
machine connects or sends an invitation message. This could be
implemented much in the same way as e-mail and ftp is implemented
nowadays - only the security requirements have to be significantly
more strident, due to the potential security problem created by
self-replicating code.

In particular, in order to prevent the danger of message forgeries, of
malicious programs impersonating beneficial viruses, to implement some
form of accounting, and to prevent mistakes, a beneficial virus must
be able to authenticate itself to the system it wants to infect.
Furthermore, the system must authenticate itself to the virus. The
natural way to implement this is by using some form of public-key
cryptography.

Imagine the following scenario.  A company that specializes in the
production of beneficial viruses creates one and makes it available at
some well-known virus repository site.  The file distribution software
of that site (possibly also virus-based) automatically distributes the
new virus to all the other virus repositories that do not have it yet.
The company also makes a formal announcement, containing the public
key of the virus, in another standard place - say, a dedicated
newsgroup.  The announcement itself is signed with the public key of
the company-producer.

The system administrator of a site that wants to use the virus (i.e.,
considers the task that the virus performs useful) sees the
announcement, checks the digital signature to make sure that it
indeed comes from the company it claims to come from, and posts a
formal invitation. The invitation specifies which particular virus
is needed, which site wants it, the way for the virus to enter the
system (e.g., a dedicated port) and some other similar useful
information. Of course, this invitation is also signed with the public
key of the owner of the machine that wants to be infected. This
invitation message does not have to be sent directly to the
company-producer or even to the virus repository. Instead, it could be
posted to some public place (e.g., another newsgroup). The virus
repositories around the world will watch this newsgroup for such
messages, and those of them that is nearest to the requesting site
will send the virus to that site (in order to minimize the traffic
costs).

The virus will contact the site that is requesting it through the
specified entry point and will authenticate itself to the system with
the means of a public-key digital signature created with the private
key of the virus. At this point the system that has requested the
virus will be able to prove that what it has received is indeed the
viral program that has been requested. This will exclude not only the
danger of an intruder masquerading as a beneficial virus - it will
also detect random corruptions that might have taken place. It won't
completely exclude the danger of malicious code, but in case that
malicious code is found, the user will have a proof that it comes from
the company that has provided the virus.  The chances of this actually
happening are no bigger than those of Microsoft distributing a trojan
horse with their word processor.

Once the virus has installed itself at the requesting site, it could
(optionally, with the agreement of the local system administrator) use
that site for further distribution - for instance, watch the same
newsgroup for requests for the same virus coming from nearby sites.

Lastly, all messages that do not have to be public (e.g., virus
invitations, service messages, etc.) could be encrypted with the
public key of the virus, for privacy reasons.

It is important to note that in the above scenario the default action
for the virus is not to infect. Only if a verified, active invitation
is present, it is allowed to install itself on a particular system.

4.1.2. Solving the Recognition Problem.

The anti-virus programs are either virus-specific (i.e., they look for
particular code known to be present in viruses), or generic (i.e.,
they watch for modifications of the existing executable programs). A
beneficial virus using the cryptographically strong authentication
methods mentioned above could easily be made not to trigger the
virus-specific anti-virus programs. In fact, it will be able to
authenticate itself to them as a known beneficial virus and ensure
that no false positives occur - therefore, it will be safer than a
normal executable program.

In order to avoid triggering the modification detectors, the virus
must not modify other executable programs. This requirement is also
necessary to solve other problems, as we shall see below. Therefore,
a beneficial virus must be a worm - it must be self-contained and
spread as a whole and not depend on attaching itself to a host
executable file ([Cohen92]).

4.1.3. Solving the Resource Wasting Problem.

In order to solve this problem, a beneficial virus must consume a
negligible amount of time, memory, disk space, and other system
resources. At least the cost of the system resources used by the virus
must be negligible, when compared with the benefit it brings to the
user. This again supports the argument that only a single instance of
the virus must be present on an infected machine.

4.1.4. Solving the Bug Containment Problem.

Updates for a virus that uses public-key cryptography for
authentication means should be distributed in a similarly secure way -
the new version should use digital signatures in order to make sure
that it is updating the right file at the right site.  If the global
network is used both for virus distribution and virus update, and the
viruses do not spread by any other means, this will ensure that
important messages (like "update" or "terminate yourself") are quickly
and reliably passed to all instances of the virus.

Additionally, it should be easy for the system administrator of any
particular site to send a "terminate yourself" message to any
particular virus running at this site.  This still has the danger of a
denial-of-service attack - if some site is heavily dependent on the
operation of some beneficial virus, then an attacker could send a
message to this virus to stop working, therefore causing damage.
Again, the right way to solve this problem is by means of public-key
cryptography - the messages to the virus should be signed with the
private key of the system it runs on.

4.1.5. Solving the Compatibility Problems.

By making the virus self-contained and not modifying any other
programs, we ensure that it does not cause any problems to programs
that do not tolerate modification.  Since the virus does not even
bother the user with requests for permission to infect (it passively
waits for an active invitation from the part of the user instead), it
will not cause unwanted interruptions.  Lastly, the user who is
requesting the virus will be able to examine in advance the technical
specifications of the latter and decide whether it is suitable for the
user's system.  Of course, the risk of introducing an incompatible
program still exists, but it is not greater than the risk of
introducing any normal (i.e., non-viral) program - except that a
beneficial virus comes with a cryptographic proof of its integrity.

4.1.6. Solving the Effectiveness Problem.

In order to make computer virus based solutions attractive to the
users, we have to design them for tasks that are more effectively
performed by self-replicating code than by normal, non-viral programs.
There are not many tasks of this kind, but they do exist, as we shall
see from some examples below.

4.2. Solving the Ethical and the Legal Problems.

The problems of this kind are traditionally more difficult to solve
than the technical ones. However, as we shall see, the model for virus
distribution described above helps greatly to solve those problems
too.

4.2.1. Solving the Unauthorized Data Modification Problem.

Since the unauthorized modification of other people's data is
considered harmful, a virus that claims to be beneficial must not do
any such thing. The scheme described above neatly fits into these
limits - the virus waits for the user to actively invite it to the
system, and uses cryptographic means to make sure that it infects,
updates, or modifies the right thing.

4.2.2. Solving the Copyright and Ownership Problems.

Those problems are easily solved by requiring the virus to be a
self-contained program (i.e., a worm) and not to infect or otherwise
modify any programs it is not explicitely authorized to. Even then,
the virus has to use cryptographic authentication, in order to exclude
the possibility for misrecognition errors.

4.2.3. Solving the Possible Misuse Problem.

Since the virus described in the model above uses cryptographically
strong techniques to authenticate itself to the system it wants to
infect, and since the system authenticates itself to the virus too,
this excludes the possibility of a malicous attacker to modify a
beneficial virus and make it include some damaging code. Actually, it
also excludes the possibility for a system to "cheat" by using a
beneficial viral program without accounting for it. This could raise
some privacy problems, but, as demonstrated by [Chaum], the means of
public-key cryptography are able to provide simultaneously both
authentication and anonymity, if so desired.

An attacker could, of course, examine the source of some beneficial
virus and in particular its replication mechanism, and try to use this
mechanism for a malicious program of his. However, since the virus
described above does not penetrate the systems but waits for an active
invitation instead, the attacker will have to convince the users that
his program is beneficial. However, this case is not much different
from an attacker uploading a Trojan Horse to a popular anonymous ftp
site or a BBS, claiming that it does something useful. The technique
for distribution of beneficial viruses described above has this
additional benefit, that by using public key authentication it allows
the malicious program to be provably traced to the attacker.

Of course, all this assumes that a reliable scheme for secure public
key distribution is in place and that programs implementing public key
authentication methods are already in wide use. Currently this is not
the case, so the described scheme for secure distribution of
beneficial viruses is not immediately realizable. However, there are
active developments in this area, so it should be very real in the
near future.

4.2.4. Solving the responsibility Problem.

This is one of the most difficult problems to solve. Regardless of how
much efforts are put by the legitimate researchers to implement a
beneficial virus in a secure way, the malicious virus writers will
always try to use their achievements as an excuse and attempt to
masquerade the malicious virus writing as legitimate "research".

There is really no easy solution to this problem. It should be
approached by a complex of measures. The legitimate proponents of
research into the area of beneficial self-replicating programs must
always stress the responsibility that any developer of such programs
should have to prevent the uncontrolled spread of his or her
creations. They must always condemn the malicious virus writing and
the release to the general public of real viruses that do not provide
the necessary means to control their spread. Since the implementation
of the proper authentication protocols is usually beyond the
capabilities of the teenagers who enjoy creating and releasing
malicious virus code, this should easily differentiate between the
legitimate researchers and the "wannabes". It must be always stressed
that the author of a virus bears part of the responsibility when this
virus is found on a system where it is unwanted and that the person
who has introduced virus into that particular system is not the only
one responsible for the damage caused.

Simultaneously, this should be combined with the proper legislative
measures against malicious virus writing and distribution. This, if
properly enforced, should serve as a deterrent against at least some
of the people who would otherwise spend their time creating malicious
viral code - if they have no penalties to fear.

4.3. Solving the Psychological problems.

Those problems are not easy to solve, but some improvements could be
made, using psychologically-oriented solutions.

4.3.1. Solving the Trust Problems.

The contemporary computing environments are so sophisticated, that
probably none of their users understands completely how exactly they
work. Therefore, the feeling to have a full control over them is, more
or less, an illusion. Nevertheless, it is an important illusion,
because it helps maintaining the internal comfort of the users and
helps them circumvent the instinctive fear from a system that they do
not understand.

Therefore, the distribution and the replication of a beneficial
computer virus should be implemented in a way that preserves this
illusion. The proposed cryptographic means for authentication help a
lot in this aspect. It should be easily possible for the user to
obtain complete accounting of the spread of the virus and of the
actions that the latter has performed on the user's system. The
ability to easily deactivate the virus (by removing the invitation)
should also help in this aspect.

4.3.2. Solving the Negative Common Meaning Problem.

The media seems to have already created a widely established public
opinion that computer viruses are something inherently bad. In fact,
many users suspect a virus whenever any computer problem occurs - even
ones that are obviously hardware-related.

Past experience with the term "hacker" demonstrates that no amount of
public education is going to change the opinion of the general public
on this matter. The general public does not read the specialized
scientific papers and newsgroups where such explanations of the
correct meaning of the term are provided. The general public gets its
information mostly from the media - and the media describes computer
viruses are something that is necessarily bad. This will inevitably
cause most people to oppose to any kind of software that calls itself
a computer virus - even if it claims to be beneficial and even if it
demonstrates that it is so.

Therefore, a beneficial self-replicating program must not be called a
virus, if it wants to have any hopes to achieve recognition by the
general public. As it turns out, this is not so difficult. As we shall
see in the next section, most useful self-replicating programs that
satisfy all conditions for non-maliciousness are far from what most
people consider a real computer virus.

4.4. Summary.

As we could see from the above sections, all conditions for
non-maliciousness in self-replicating programs can be easily
satisfied by creating a program that:

    o Waits for active invitation before installing itself on a
      system;

    o Uses cryptographically strong means to authenticate itself to
      the system;

    o Is self-contained and does not modify other programs (i.e., is a
      worm);

    o Is not called a "virus".

5. Some Good Examples of Beneficial Self-Replicating Programs.

In this section we shall present several more or less successful
applications of self-replicating code. They all fit into Dr. Cohen's
definition of the term "computer virus", although most of them
wouldn't be considered viruses by most people.

5.1. The Automatic OS Update.

In the early days of personal computers, the operating systems were
small and it was common to put a copy of the OS on every formatted
floppy. It usually occupied the first 2-3 tracks. The idea was
proposed to introduce a small modification in the OS and to make it
check on every floppy disk access whether that floppy contains an
up-to-date version of that particular OS. In the case that an older
version was found, it would be replaced with the newer version. This
automatic update could be easily controlled by the user. For instance,
the user could set the default behaviour to be the update to always
occur automatically, to never occur, or the user to be asked
interactively each time for confirmation. No cryptographic
authentication means were used, but it was assumed that the producer
of the operating system will know their product well enough to be able
to reliably recognize old versions of it.

This idea still violates some of the conditions listed in section 2,
which is probably why it never received wide acceptance.  Besides, the
size of operating systems has increased enormously.  Nowadays, they
occupy multiple high-density floppies and consist of hundreds of files
containing different utilities.  It is no longer practical to keep a
copy of the OS on each floppy disk.

5.2. The Xerox PARC Worm.

In 1982, two researchers from the Xerox Palo Alto Research Center
created a "distributed computation" [Shoch].  This was a program
written in BCPL for Xerox workstations, which consisted of several
segments, each segment running on a workstation connected to a
local-area network.  The program was able to determine which machines
are idle and to transfer a segment to them, thus expanding itself.
Additionally, each segment could use the workstation it was running on
for some useful task.  In particular, during the experiments mentioned
above, the segments were performing partial computations for animation
purposes, using the idle machines on the network.

Unfortunately, the self-replicating programs used during those
experiments didn't have the necessary mechanisms to verify their own
integrity during the replication process.  Random corruptions could
easily occur, and it was discovered that the worms left running
overnight often got out of control and corrupted copies crashed the
machines in the entire network.  This behaviour forced the two
researchers to stop the experiments.

5.3. The Centralized Anti-Virus Update.

This last example of beneficial self-replicating is the most
successful one.  Implementations of it are widely used by several
anti-virus companies in their products.

Consider a company that has several hundreds, even thousands of PCs,
all networked together in a LAN. The company also takes the virus
problem seriously, and insists that each and every of those PCs must
be running the latest version of some particular virus scanner, before
it is allowed to access the network. Let's ignore for a moment whether
the decision to rely on a scanner for virus protection is wise or not.
Even if the company uses some other kinds of defense (integrity
checking, monitoring, access control, and so on), a well thought out
scheme for anti-virus defense should contain a scanner as one of the
lines of protection, although possibly not the most important one.

Insisting that all PCs are running the latest version of the scanner
is a very reasonable requirement, because scanners tend to get old
faster than normal programs, and a new virus could sneak in undetected
by an obsolete scanner and wreak havoc on the network, before any
other kind of defense has had the opportunity to react.

So, the person responsible for the network has imposed a requirement:
a PC that does not run the latest version of the scanner is not
allowed to log in.  That's fine, but how to achieve it?  The simple
answer is - by keeping a copy of the (presumably resident) scanner on
each of the PCs and regularly updating them.

The only problem is - how to keep thousands of PCs up-to-date?  And on
the top of that - to keep them up-to-date with a product, a new
version of which is released on average every month?  Trying to
achieve this by going to each PC and updating it manually from a
floppy is a hopeless task.  A month will not be sufficient to update
them all - before you have finished, you'll have to start all over
again - updating them with the next version of the scanner.  The PCs
will be probably in different buildings, some of them - in obscure
places, used rarely - all this will definitely not make the task
easier.  In fact, it is a real nightmare for the PC technical support
team.

The obvious alternative is to keep one copy of the anti-virus package
on the server and update the PCs from there. However, if the person
responsible for maintaining the virus protection has to go personally
to each computer and download the new version of the package manually
from the server, the situation has not improved very much. One option
is to tell the users to do it themselves regularly, and even set up
some sort of automatic system that sends them automatic reminders each
time the copy of the software on the server has been updated.
Unfortunately, this still leaves two problems. First, the users tend
to be lazy and "automatically" ignore the automatic reminders. Second,
they - or at least some of them - lack the necessary qualification for
installing anti-virus packages, and could easily mess up something
while installing the update.

A much, much better solution is to design the anti-virus package as a
network virus (a worm, actually), making it able to copy itself
across the network to the workstations. One segment of the worm will
constantly monitor the logins. Each time a workstations attempts to
login, that segment automatically queries that workstation whether
it is running the anti-virus product and which version of it. If it
turns out that a newer version is available, the segment will inform
the user about this and will propose to update the local version on
the workstation. If the user refuses the update, then access to the
network is denied for that workstation. If the user accepts the
update, another segment of the worm will fetch the relevant (updated)
parts of the anti-virus package from the server, will copy them to the
workstation, and will reboot the latter, in order to make sure that
the changes will take effect. Of course, the user is always kept
informed about what is going to happen, and user permission is
requested each time.

The software that performs the automatic update, is actually part of
the anti-virus package. Since it copies (parts of) itself across the
network to other computers, it is a virus, according to Dr. Cohen's
definition of the term - although probably most people will not see it
as such.  Such a virus is very easy to implement - even by using
trivial modifications to the login scripts.  It could be used for the
initial installation of the anti-virus package too - not only for the
updates.  If the network consists of more than one server, then the
whole virus - the anti-virus programs, together with the code that
implements the replication - could transfer themselves from server to
server and begin to distribute the updates from there.

Does the beneficial "virus" described above conform to all conditions
listed in section 2? It seems so.

It does conform to the Control requirement. The virus attempts to
spread only on the computers attempting to access the network on which
it is running. This is perfectly acceptable, because, as we stated,
the company's policy is that all computers attempting to access the
network must run the latest version of the anti-virus product.
Simultaneously, the user is always given the option to refuse the
programs that insist to run on the user's computer - but then access
to the network is denied for that computer.

It does conform to the Recognition requirement. Since the "virus" is
actually part of the anti-virus defense, it will be easy for it to
recognize itself and allow itself to run. Currently, the products
implementing this approach do not use cryptographic means for
authentication - they rely on file names, directory paths, and so on.
However, it is very easy to add any additional authentication as the
need for it arises.

It does conform to the Resource Wasting requirement. Since the virus
is of the worm type and therefore self-contained, only a single copy
of it will be running on each workstation - therefore, no resource
wasting will occur. In fact, the unnecessary parts of it (e.g., the
replication code) will not be copied, if they are not needed.

The fact that it is a worm and spreads as a whole on the network makes
it relatively easy to fulfil the Bug Containment requirement too. If
a bug is discovered in any piece of the software, the same viral
replication means can be easily used to distribute the fix to each
workstation as it logs in.

Since the "virus" modifies only old copies of itself and does not
touch other programs, no compatibility problems due to its virus-like
behaviour will occur.  Of course, it is still possible that the
anti-virus software running on the workstation is having compatibility
problems with any of the hardware or software components of this
workstation.  However, those problems are independent on the viral way
for distribution of the package and can be usually solved by
contacting the company that provides technical support for the
package.  If a fix in the anti-virus software is necessary, in order
to solve the problems, then the viral distribution mechanism can be
used to send it to the workstation that needs it.

The kind of job that such a "virus" performs, clearly demonstrates
that it fulfils the requirement for Effectiveness too. Actually, any
other way to regularly distribute updates of the package to a large
number of PCs would be horribly ineffective.

Since the package updates/modifies only older copies of itself, there
are no legal and/or ethical problems related to unauthorized data
modification or copyright - therefore, the package described above
fulfils those requirements too. Since the company that installs the
"virus" owns the network on which it runs, it has the right to decide
what is the exact policy to allow machines to connect to that network.
Therefore, if the policy is "either run the latest version of the
anti-virus software or be denied access", it is their right to enforce
it. The user has always the option to refuse and not to use the
network.

The way currently such packages are implemented makes their misuse by
an attacker relatively difficult, but still possible. However, as
mentioned above, as the need arizes, cryptographically strong means
for authentication could be easily introduced to take care of this
problem.

The responsibility requirement is fulfilled too - in fact, the whole
"viral" package is designed mainly as a means to fight real, malicious
viruses.

At last, the psychological problems are easily resolved by using the
fact that most people would consider such a package as a real computer
virus in the first place. The companies using this approach usually
call it "centralized software update" or some other nicely-looking
name - a name that doesn't even remotely suggest that the package is a
virus.

Actually, this approach could be used for any kind of software - not
just for distribution of anti-virus packages. However, the need to
update the anti-virus packages often allows us to demonstrate the best
how useful and beneficial the approach is. Similar tools for general
software distribution exist too - for instance, the program rdist,
used on many Unix machines. However, it acts like a virus only when
distributing new versions of itself, which doesn't happen that often.

6. Conclusion.

In this paper we listed the set of reasons why computer viruses are
usually considered bad and emphasized that any self-replicating
program that claims to be beneficial and non-malicious must not
contradict the conditions expressed by those reasons. We also
demonstrated that it is possible to design such programs, although
most people probably wouldn't consider them to be viruses.

7. References.

[Bontchev92] Vesselin Bontchev, "Possible Virus Attacks Against
             Integrity Programs And How To Prevent Them", Proc.  2nd
             Int.  Virus Bulletin Conf., September 1992, pp. 131-141.

[Bontchev94] Vesselin Bontchev, "Methodology of Computer Anti-Virus
             Research", Ph.D. Thesis, in print.

[Chaum]      David Chaum, "Achieving Electronic Privacy", Scientific
             American, August 1992, pp. 96-101.

[Cohen84]    Fred Cohen, "Computer Viruses - Theory and Experiments",
             7th Security Conf., DOD/NBS, September 1984, pp. 143-158.

[Cohen89]    Fred Cohen, "Computational Aspects of Computer Viruses",
             Computers & Security, 8 (1989), pp. 325-344.

[Cohen91]    Fred Cohen, "Trends In Computer Virus Research", ASP,
             1991.

[Cohen92]    Fred Cohen, "A Formal Definition of Computer Worms and
             Some Related Results", Computers & Security, 11 (1992),
             pp. 641-652.

[Cohen94]    Fred Cohen, "It's Alive!", John Wiley & Sons, 1994, ISBN
             0-471-00860-5.

[Seborg]     Brian Seborg, An article in the electronic forum
             Virus-L/comp.virus.

[Shoch]      John F. Shoch, Jon A. Hupp, "The 'Worm' Programs - Early
             Experience with a Distributed Computation", CACM, vol.
             25, 3, March 1982.

