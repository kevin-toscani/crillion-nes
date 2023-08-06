
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; include/constants.asm
;;
;; List of general constant declarations, like addresses and
;; input button values, for example. These constants should
;; make developing easier and code better readable.
;;
;;

;; Cartridge RAM/ROM constants
ADDR_ZEROPAGE  = $0000
ADDR_SOUNDRAM  = $0100
ADDR_SPRITERAM = $0200
ADDR_OTHERRAM  = $0300
ADDR_STARTBANK = $8000
ADDR_ENDBANK   = $C000
ADDR_VECTORS   = $FFFA
ADDR_CHRROM    = $0000

;; PPU constants
PPU_CTRL   = $2000
PPU_MASK   = $2001
PPU_STATUS = $2002
PPU_SCROLL = $2005
PPU_ADDR   = $2006
PPU_DATA   = $2007

;; PPU flag helpers
SPRITE_0_HIT = #%01000000

;; Object attribute model addresses
OAM_ADDR   = $2003
OAM_DATA   = $2004
OAM_DMA    = $4014

;; Audio processing unit addresses
APU_CTRL   = $4010
APU_STATUS = $4015
APU_FC     = $4017

;; Joypad input addresses
JOYPAD_1   = $4016
JOYPAD_2   = $4017

;; Joypad buttons
BUTTON_A      = #%10000000
BUTTON_B      = #%01000000
BUTTON_SELECT = #%00100000
BUTTON_START  = #%00010000
BUTTON_UP     = #%00001000
BUTTON_DOWN   = #%00000100
BUTTON_LEFT   = #%00000010
BUTTON_RIGHT  = #%00000001

;; Custom game constants
.include "game/include/constants.asm"

