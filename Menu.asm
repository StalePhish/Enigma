;
; The Enigma Encryption
; Menu System
; Chris Andrews
;

.ORIG x4200

MENU1		.STRINGZ	"\n\n  THE ENIGMA\nby Chris Andrews\nChoose a Selection:\n\n"
MENU2		.STRINGZ	"0) Encrypt / Decrypt\n1) Change Plug Board\n2) Change Rotor Configuration\n"
MENU3		.STRINGZ	"3) Change Reflector\n4) Quit\n\n>Selection: "

INVALID		.STRINGZ	"\n\nInvalid input, try again\n"
PAUSE		.STRINGZ	"\n\nPress any key to continue "

PLUG		.STRINGZ	"\n\nMap each letter to another:\n"
CONFIG1		.STRINGZ	"\n\nLeft Rotor (1-3): "
CONFIG2		.STRINGZ	"\n\nCenter Rotor (1-3): "
CONFIG3		.STRINGZ	"\n\nRight Rotor (1-3): "
CONFIGring	.STRINGZ	"\nRing Setting (A-Z): "
REFLECT		.STRINGZ	"\n\nReflector (A-B): "

.END
