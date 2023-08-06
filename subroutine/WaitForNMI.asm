
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; subroutine/WaitForVBlank.asm
;;
;; Subroutine that essentially pauses script execution until
;; vBlank happens.
;;
;;

sub_WaitForNMI:
    LDA #$01
    STA check_nmi
    -
        LDA check_nmi
    BNE -
    RTS

