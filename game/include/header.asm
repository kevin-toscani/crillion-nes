
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; include/header.asm
;;
;; The iNES header for the game. This tells the hardware /
;; emulator the number of PRG-ROM and CHR-ROM banks, which
;; mapper to use, the mirroring type, and some other ROM info.
;;
;; See https://www.nesdev.org/wiki/INES for more info.
;;
;;

    ;; iNES identifier
    .db "NES", $1A

    ;; Number of PRG-ROM (1) and CHR-ROM (1) banks
    .db $01, $01
    
    ;; Mapper (0, or NROM)
    .db %00000000
    .db %00000000

    ;; Add an additional 8 bytes of padding
    .db $00, $00, $00, $00, $00, $00, $00, $00

