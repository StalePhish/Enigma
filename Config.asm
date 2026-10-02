;
; The Enigma Encryption
; Configuration
; by Chris Andrews
;

.ORIG	x4500

CONF_LEFT	.FILL	x4087	; Default: Rotor 3
CONF_LEFTi	.FILL	x40A2	; Default: Rotor 3 inverse
CONF_LEFTn	.FILL	x40F5	; Default: Rotor 3 notch
CONF_LEFTr	.FILL	#0	; Default: 0 offset	 (x0000)
CONF_CENT	.FILL	x4051	; Default: Rotor 2
CONF_CENTi	.FILL	x406C	; Default: Rotor 2 inverse
CONF_CENTn	.FILL	x40F4	; Default: Rotor 2 notch
CONF_CENTr	.FILL	#0	; Default: 0 offset	 (x0000)
CONF_RIGHT	.FILL	x401B	; Default: Rotor 1
CONF_RIGHTi	.FILL	x4036	; Default: Rotor 1 inverse
CONF_RIGHTn	.FILL	x40F3	; Default: Rotor 1 notch
CONF_RIGHTr	.FILL	#0	; Default: 0 offset	 (x0000)
CONF_REFL	.FILL	x40D8	; Default: Reflector B
CONF_PLUG    .STRINGZ	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

.END
