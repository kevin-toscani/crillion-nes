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

;; Other RAM
.enum ADDR_OTHERRAM
    .include "ram/misc.asm"
.ende

;; Instantly go to the static bank
.org ADDR_ENDBANK

;; Reset script
RESET:
    .include "interrupt/reset.asm"

;; Main game loop
MainGameLoop:
    .include "game/main.asm"
    JMP MainGameLoop

;; Subroutines
.include "include/subroutines.asm"

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

;; CHR data (if any)
.incbin "game/graphics/backgrounds.chr"
.incbin "game/graphics/sprites.chr"
