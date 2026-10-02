;
; The Enigma Encryption
; Input / Output / Processing
; by Chris Andrews
;

.ORIG	x3000

MENU				; shows menu
	LD	R0,MENU1
	PUTS
	LD	R0,MENU2
	PUTS
	LD	R0,MENU3
	PUTS

	GETC			; takes input for menu
	OUT			; displays input text

	LD	R6,N_INDEX	; indexes input
	ADD	R0,R0,R6

	ADD	R6,R0,#-4	; determines if input is invalid
	BRp	INVALID

	LD	R6,M_INDEX	; adds line to index
	ADD	R0,R0,R6
	JSRR	R0		; jumps to menu call

MENU_ENCRYPT	BR	START
MENU_PLUG	BR	PLUG_CONF
MENU_ROTOR	BR	ROTOR1_CONF
MENU_REFLECT	BR	REFL_CONF
MENU_QUIT	HALT

PLUG_CONF
	LD	R0,PLUG
	PUTS

	LD	R6,C_PLUG
	LD	R5,ZERO
	
PLUG_LOOP
	LD	R0,LINEBR
	OUT

	;LDR	R0,R6,#0	; load into R0, PLUG+offset

	LD	R0,ALPHA
	ADD	R0,R0,R5
	LDR	R0,R0,#0
	OUT

	LD	R0,CAROT	; print ">"
	OUT
	
PLUG_LOOP2
	GETC			; take input for plug board

	LD	R4,ASCII	; compares if input<A
	ADD	R4,R4,R0
	BRn	PLUG_LOOP_CK

	LD	R4,ZEE		; compares if input>Z
	ADD	R4,R4,R0
	BRp	PLUG_LOOP2

	OUT			; displays input
	
	LD	R4,ASCII	; indexes input
	ADD	R4,R4,R0
	STR	R0,R6,#0

PLUG_LOOP3
	ADD	R6,R6,#1	; incriments pointer
	ADD	R5,R5,#1	; incriments counter

	LD	R0,N_ALPHA	; compares counter
	ADD	R0,R0,R5

	BRn	PLUG_LOOP
	BRzp	MENU

PLUG_LOOP_CK
	LD	R4,MASK
	AND	R4,R4,R0
	BRnp	PLUG_LOOP2

	LDR	R0,R6,#0	; load into R0, PLUG+offset
	OUT
	BR	PLUG_LOOP3

ROTOR1_CONF

	; left rotor configutation
	LD	R0,CONFIG1
	PUTS
	GETC
	OUT

	LD	R6,N_INDEX	; indexes input
	ADD	R0,R0,R6

	ADD	R0,R0,#-1	; determines if selection is #1
	BRz	R_CONF_L1

	ADD	R0,R0,#-1	; determines if selection is #2
	BRz	R_CONF_L2

	ADD	R0,R0,#-1	; determines if selection is #3
	BRz	R_CONF_L3

	BR	ROTOR1_CONF

ROTOR2_CONF
	; center rotor configuration
	LD	R0,CONFIG2
	PUTS
	GETC
	OUT

	LD	R6,N_INDEX	; indexes input
	ADD	R0,R0,R6

	ADD	R0,R0,#-1	; determines if selection is #1
	BRz	R_CONF_C1

	ADD	R0,R0,#-1	; determines if selection is #2
	BRz	R_CONF_C2

	ADD	R0,R0,#-1	; determines if selection is #3
	BRz	R_CONF_C3

	BR	ROTOR2_CONF

ROTOR3_CONF
	; right rotor configuration
	LD	R0,CONFIG3
	PUTS
	GETC
	OUT

	LD	R6,N_INDEX	; indexes input
	ADD	R0,R0,R6

	ADD	R0,R0,#-1	; determines if selection is #1
	BRz	R_CONF_R1

	ADD	R0,R0,#-1	; determines if selection is #2
	BRz	R_CONF_R2

	ADD	R0,R0,#-1	; determines if selection is #3
	BRz	R_CONF_R3

	BR	ROTOR3_CONF

ROTOR1_CONFring
	LD	R5,C_LEFTr
	JSR	RINGSETTING
	BR	ROTOR2_CONF

ROTOR2_CONFring
	LD	R5,C_CENTr
	JSR	RINGSETTING
	BR	ROTOR3_CONF

ROTOR3_CONFring
	LD	R5,C_RIGHr
	JSR	RINGSETTING
	BR	MENU

RINGSETTING
	; rotor ring setting
	LD	R0,CONFIGr

	LD	R6,ZERO
	ADD	R6,R6,R7

RINGSETTING2
	PUTS
	GETC
	OUT

	LD	R4,ASCII	; indexes input
	ADD	R0,R0,R4

	; if R0 < A
	BRn	RINGSETTING2

	; if R0 < Z
	LD	R4,N_ALPHA
	ADD	R4,R4,R0
	BRzp	RINGSETTING2

	; if correct input
	STR	R0,R5,#0	

	LD	R7,ZERO
	ADD	R7,R7,R6
	RET

R_CONF_L1
	; left rotor is rotor 1
	LD	R6,C_LEFT
	LEA	R5,ROTOR1
	JSR	SET_CONF
	BR	ROTOR1_CONFring

R_CONF_L2
	; left rotor is rotor 2
	LD	R6,C_LEFT
	LEA	R5,ROTOR2
	JSR	SET_CONF
	BR	ROTOR1_CONFring

R_CONF_L3
	; left rotor is rotor 3
	LD	R6,C_LEFT
	LEA	R5,ROTOR3
	JSR	SET_CONF
	BR	ROTOR1_CONFring

R_CONF_C1
	; center rotor is rotor 1
	LD	R6,C_CENT
	LEA	R5,ROTOR1
	JSR	SET_CONF
	BR	ROTOR2_CONFring
	

R_CONF_C2
	; center rotor is rotor 2
	LD	R6,C_CENT
	LEA	R5,ROTOR2
	JSR	SET_CONF
	BR	ROTOR2_CONFring

R_CONF_C3
	; center rotor is rotor 3
	LD	R6,C_CENT
	LEA	R5,ROTOR3
	JSR	SET_CONF
	BR	ROTOR2_CONFring

R_CONF_R1
	; right rotor is rotor 1
	LD	R6,C_RIGH
	LEA	R5,ROTOR1
	JSR	SET_CONF
	BR	ROTOR3_CONFring

R_CONF_R2
	; right rotor is rotor 2
	LD	R6,C_RIGH
	LEA	R5,ROTOR2
	JSR	SET_CONF
	BR	ROTOR3_CONFring

R_CONF_R3
	; right rotor is rotor 3
	LD	R6,C_RIGH
	LEA	R5,ROTOR3
	JSR	SET_CONF
	BR	ROTOR3_CONFring

SET_CONF
	LDR	R4,R5,#0	; ex: ROTOR1 -> C_LEFT
	STR	R4,R6,#0

	ADD	R6,R6,#1
	ADD	R5,R5,#1

	LDR	R4,R5,#0	; ex: ROTOR1i -> C_LEFTi
	STR	R4,R6,#0

	ADD	R6,R6,#1
	ADD	R5,R5,#1

	LDR	R4,R5,#0	; ex: ROTOR1n -> C_LEFTn
	STR	R4,R6,#0

	ADD	R6,R6,#1
	RET

REFL_CONF
	LD	R0,REFLEC
	PUTS
	GETC
	OUT

	LD	R4,ASCII	; loads the mask of "-A"
	ADD	R6,R0,R4	; determines if A was pressed
	BRz	REFL_SETA	; sets reflector to A

	ADD	R4,R4,#-1	; loads the mask of "-B"
	ADD	R6,R0,R4	; determines if B was pressed
	BRZ	REFL_SETB	; sets reflector to B

	BR	INVALID		; invalid input, then goes to menu

REFL_SETA
	LD	R6,C_REFL
	LD	R4,REF_A
	STR	R4,R6,#0	; store Ref A as current reflector
	BR	MENU

REFL_SETB
	LD	R6,C_REFL
	LD	R4,REF_B
	STR	R4,R6,#0	; store Ref B as current reflector
	BR	MENU

INVALID
	LD	R0,MENUinv	; displays invalid text
	PUTS
	BR	MENU

; ----------------------------------------------------------------------------------

; used for offsetting
ZEE	.FILL	#-90	; used for checking if input > Z
ASCII	.FILL	#-65	; used for offsetting letters
P_ALPHA	.FILL	#26	; used for offsetting alphabet
N_ALPHA	.FILL	#-26	; used for offsetting alphabet
LOW_A	.FILL	#-97	; used for converting lowercase
LOW_Z	.FILL	#-122	; used for converting lowercase
LOWER	.FILL	#-32	; used for converting lowercase
N_INDEX	.FILL	#-48	; used for offsettings menu/numbers
M_INDEX	.FILL	x300F	; used for offsettings menu/numbers

; references to menu
MENU1	.FILL	x4200
MENU2	.FILL	x4236
MENU3	.FILL	x427F
MENUinv	.FILL	x42A9
PAUSE	.FILL	x42C5
PLUG	.FILL	x42E2
CONFIG1	.FILL	x4301
CONFIG2	.FILL	x4316
CONFIG3	.FILL	x432D
CONFIGr	.FILL	x4343
REFLEC	.FILL	x4359

; references of rotors
ALPHA	.FILL	x4000
ROTOR1	.FILL	x401B
ROTOR1i	.FILL	x4036
ROTOR1n	.FILL	x40F3
ROTOR2	.FILL	x4051
ROTOR2i	.FILL	x406C
ROTOR2n	.FILL	x40F4
ROTOR3	.FILL	x4087
ROTOR3i	.FILL	x40A2
ROTOR3n	.FILL	x40F5
REF_A	.FILL	x40BD
REF_B	.FILL	x40D8

; references of config
C_LEFT	.FILL	x4500
C_LEFTi	.FILL	x4501
C_LEFTn	.FILL	x4502
C_LEFTr	.FILl	x4503
C_CENT	.FILL	x4504
C_CENTi	.FILL	x4505
C_CENTn	.FILL	x4506
C_CENTr	.FILL	x4507
C_RIGH	.FILL	x4508
C_RIGHi	.FILL	x4509
C_RIGHn	.FILL	x450A
C_RIGHr	.FILL	x450B
C_REFL	.FILL	x450C
C_PLUG	.FILL	x450D

; used for prompting
PROMPT	.STRINGZ	"\n\nINPUT:  "
SHOW	.STRINGZ	"\nOUTPUT: "
LINEBR	.FILL	X000A	; line break
CAROT	.FILL	x003E	; >

; variables
ZERO	.FILL	#0	; number zero
ORIGIN	.FILL	x3000	; start of program
CLR	.FILL	x0000	; zero
PTR	.FILL	x5000	; pointer to the storage location
MASK	.FILL	xFFF5	; the opposite of LF (new line) character

; ----------------------------------------------------------------------------------

START
	LD	R5,PTR		; loads storage pointer
	LD	R3,C_LEFTr	; left rotor shift
	LDR	R3,R3,#0
	LD	R2,C_CENTr	; middle rotor shift
	LDR	R2,R2,#0
	LD	R1,C_RIGHr	; right rotor shift
	LDR	R1,R1,#0
	LEA	R0,PROMPT	; loads pointer to input text into R0
	PUTS			; displays the input text

INPUT
	; takes keyboard input
	GETC

	; determines if the enter key was pressed
	LD	R4,MASK
	AND	R4,R4,R0
	BRn	INPUT
	BRz	OUTPUT
	
	; if R0 < A
	LD	R4,ASCII
	ADD	R4,R4,R0
	BRn	INPUT

	; if R0 < Z
	LD	R4,ZEE
	ADD	R4,R4,R0
	BRnz	PROCESS

	; if R0 > low a
	LD	R4,LOW_A
	ADD	R4,R4,R0
	BRzp	CK_LOW
	BR	INPUT

CK_LOW
	; if R0 < low z
	LD	R4,LOW_Z
	ADD	R4,R4,R0
	BRnz	CONV_LOW
	BRp	INPUT

CONV_LOW
	; converts to uppercase
	LD	R4,LOWER
	ADD	R0,R0,R4
	BR	PROCESS

PROCESS
	; Echoes input
	OUT

	; Plug board
	JSR	PLUGBOARD

	; Rotors spinning
	JSR	ROTATE

	; Rotor 1 forward
	ADD	R0,R0,R1
	LD	R6,C_RIGH
	LDR	R6,R6,#0
	JSR	ENCRYPT

	; Fixes R1 rotation
	NOT	R1,R1
	ADD	R1,R1,#1
	ADD	R0,R0,R1

	; Rotor 2 forward
	ADD	R0,R0,R2
	LD	R6,C_CENT
	LDR	R6,R6,#0
	JSR	ENCRYPT

	; Fixes R2 rotation
	NOT	R2,R2
	ADD	R2,R2,#1
	ADD	R0,R0,R2

	; Rotor 3 forward
	ADD	R0,R0,R3
	LD	R6,C_LEFT
	LDR	R6,R6,#0
	JSR	ENCRYPT

	; Fixes R3 rotation
	NOT	R3,R3
	ADD	R3,R3,#1
	ADD	R0,R0,R3

	; Reflector
	LD	R6,C_REFL
	LDR	R6,R6,#0
	JSR	ENCRYPT

	; Fixes R3 rotation
	NOT	R3,R3
	ADD	R3,R3,#1

	; Rotor 3 inverse
	ADD	R0,R0,R3
	LD	R6,C_LEFTi
	LDR	R6,R6,#0
	JSR	ENCRYPT

	; Fixes R2 rotation
	NOT	R2,R2
	ADD	R2,R2,#1

	; Rotor 2 inverse
	ADD	R0,R0,R2

	; Weird R3 offset fix
	NOT	R3,R3
	ADD	R3,R3,#1
	ADD	R0,R0,R3
	NOT	R3,R3
	ADD	R3,R3,#1

	; Rotor 2 inverse (cont.)
	LD	R6,C_CENTi
	LDR	R6,R6,#0
	JSR	ENCRYPT

	; Fixes R1 rotation
	NOT	R1,R1
	ADD	R1,R1,#1

	; Rotor 1 inverse
	ADD	R0,R0,R1

	; Weird R2 offset fix
	NOT	R2,R2
	ADD	R2,R2,#1
	ADD	R0,R0,R2
	NOT	R2,R2
	ADD	R2,R2,#1

	; Rotor 1 inverse (cont.)
	LD	R6,C_RIGHi
	LDR	R6,R6,#0
	JSR	ENCRYPT

	; Fixes R1 for output
	NOT	R1,R1
	ADD	R1,R1,#1
	ADD	R0,R0,R1

	NOT	R1,R1
	ADD	R1,R1,#1

	LD	R4,ASCII
	ADD	R4,R4,R0
	BRn	CIRCLE3

	; Stores and loops
	JSR	STORE
	BR	INPUT

PLUGBOARD
	LD	R4,ASCII
	ADD	R0,R0,R4	; index input
	LD	R4,C_PLUG	; load plug board
	ADD	R4,R4,R0	; adds offset
	LDR	R0,R4,#0	; loads reference of offset
	RET

ROTATE
	LD	R4,C_CENTn	; loads R2's notch
	LDR	R4,R4,#0
	LDR	R4,R4,#0
	ADD	R4,R4,#1	; check if its waiting on the notch
	ADD	R4,R4,R2	; compares R2's notch and R2's offset
	BRnp	ROTATE_RIGHT

ROTATE_LEFT
	ADD	R3,R3,#1
	LD	R4,N_ALPHA
	ADD	R4,R4,R3
	BRzp	RESET_LEFT	

ROTATE_CENT
	ADD	R2,R2,#1
	LD	R4,N_ALPHA
	ADD	R4,R4,R2
	BRzp	RESET_CENT
	BR	ROTATE_RIGHT

;ROTATE_CENT2
;	LD	R4,C_CENTn	; loads R2's notch
;	LDR	R4,R4,#0
;	LDR	R4,R4,#0
;	ADD	R4,R4,R2	; compares R2's notch and R2's offset
;	BRnp	ROTATE_RIGHT
;	ADD	R3,R3,#1

ROTATE_CENT3
	ADD	R2,R2,#1
	LD	R4,N_ALPHA
	ADD	R4,R4,R2
	BRz	RESET_CENT2
	RET

ROTATE_RIGHT
	ADD	R1,R1,#1
	LD	R4,N_ALPHA
	ADD	R4,R4,R1
	BRzp	RESET_RIGHT

ROTATE_RIGH2
	LD	R4,C_RIGHn	; loads R1's notch
	LDR	R4,R4,#0
	LDR	R4,R4,#0
	ADD	R4,R4,R1	; compares R1's notch and R1's offset
	BRz	ROTATE_CENT3
	RET

RESET_LEFT
	LD	R3,ZERO
	BR	ROTATE_CENT

RESET_CENT
	LD	R2,ZERO
;	BR	ROTATE_CENT2
	BR	ROTATE_RIGHT

RESET_CENT2
	LD	R2,ZERO
	RET

RESET_RIGHT
	LD	R1,ZERO
	BR	ROTATE_RIGH2

ENCRYPT
	; Gets alphabet position index
	LD	R4,ASCII
	ADD	R0,R0,R4
	BRn	CIRCLE

CHECK
	; Checks digit
	LD	R4,N_ALPHA
	ADD	R4,R4,R0
	BRzp	CIRCLE2
	BR 	CONTINUE

CIRCLE
	LD	R4,P_ALPHA
	ADD	R0,R0,R4	; adds 26 to the input
	BR	CHECK

CIRCLE2
	LD	R4,N_ALPHA
	ADD	R0,R0,R4	; subtracts 26 from the input
	BR	CONTINUE

CIRCLE3
	LD	R4,P_ALPHA
	ADD	R0,R0,R4	; adds 26 to the input so it isn't < A
	JSR	STORE
	BR	INPUT

CONTINUE
	ADD	R0,R0,R6	; adds new offset to encrypted address
	LDR	R0,R0,#0	; loads contents of pointer
	RET			; returns from subroutine

STORE
	; copies R7 to R6 for now
	LD	R6,ZERO
	ADD	R6,R7,#0

	; plug board
	JSR	PLUGBOARD

	STR	R0,R5,#0	; stores the encrypted character
	ADD	R5,R5,#1	; incriments storage pointer

	; copies R6 back to R7
	LD	R7,ZERO
	ADD	R7,R6,#0
	RET			; returns from subroutine
	
OUTPUT
	LD	R0,CLR		; loads x0000 into R0
	STR	R0,R5,#0	; stores a blank after the output

	LEA	R0,SHOW		; loads pointer to output text into R0
	PUTS			; displays the output text

	LD	R0,PTR		; loads pointer to encrypted text into R0
	PUTS			; outputs the string of characters starting at x5000

	LD	R0,PAUSE
	PUTS
	GETC

	LD	R7,ORIGIN
	RET

.END