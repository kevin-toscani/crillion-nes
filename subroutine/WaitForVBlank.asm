
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; subroutine/WaitForVBlank.asm
;;
;; Subroutine that essentially pauses script execution until
;; vBlank happens.
;;
;;

sub_WaitForVBlank:
    BIT $2002
    BPL sub_WaitForVBlank
    RTS

