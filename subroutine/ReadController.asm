
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; subroutine/ReadController.asm
;;
;; Subroutine that polls the controller and stores the input
;; buttons in a variable. This version only handles controller
;; 1. Expects "buttons" variable to be declared in RAM.
;;
;;

sub_ReadController:

    ;; Set strobe bit
    LDA #$01
    STA JOYPAD_1

    ;; Set up ring timer
    STA buttons_held

    ;; Clear strobe bit
    LSR
    STA JOYPAD_1

    ;; Loop through button presses
    -
        LDA JOYPAD_1
        LSR
        ROL buttons_held

    ;; Check if ring timer is done
    BCC -

    ;; Return from subroutine
    RTS

