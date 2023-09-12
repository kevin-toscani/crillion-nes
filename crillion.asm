;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    ╔══ ╔═╗  ╖ ╖   ╖   ╖ ╔══╗ ╔══╗
;;    ║   ║ ║  ║ ║   ║   ║ ║  ║ ║  ║
;;    ║   ╠═╩╗ ║ ║   ║   ║ ║  ║ ║  ║
;;    ║   ║  ║ ║ ║   ║   ║ ║  ║ ║  ║
;;    ╚══ ╙  ╙ ╙ ╚══ ╚══ ╙ ╚══╝ ╙  ╙
;;
;;  A 2023 NES port of the Commodore 64 game "Crillion"
;;
;;  Design, sound, graphics and program by Oliver Kirwa
;;  © 1987,1988
;;
;;  NES port by Kevin81 © 2023
;;
;;


;; Project constants and macros
.include "include/constants.asm"
.include "include/macros.asm"

;; iNES header (can vary per game)
.include "game/include/header.asm"

;; Zero page RAM
.enum ADDR_ZEROPAGE
    .include "ram/zp.asm"
.ende

;; Other RAM (must be ENUM'd within)
.include "ram/misc.asm"

;; Instantly go to the static bank
.org ADDR_ENDBANK

;; Reset script
RESET:
    .include "interrupt/reset.asm"

;; Main game loop
lbl_MainGameLoop:
    JSR sub_WaitForNMI ; align main loop
    .include "game/main.asm"
    JMP lbl_MainGameLoop

;; Following sequences are outside main game loop
.include "game/include/main/game_over.asm"
.include "game/include/main/level_win.asm"
.include "game/include/main/initiate_level_load.asm"
.include "game/include/main/game_win.asm"


;; Subroutines
.include "include/subroutines.asm"

;; LUTs
.include "game/include/tables.asm"

;; NMI handler
NMI:
    .include "interrupt/nmi.asm"

;; IRQ handler (empty)
IRQ:
    .include "interrupt/irq.asm"

;; Interrupt vectors
.org ADDR_VECTORS
    .dw NMI
    .dw RESET
    .dw IRQ

;; CHR data
.incbin "game/graphics/sprites.chr"
.incbin "game/graphics/backgrounds.chr"

