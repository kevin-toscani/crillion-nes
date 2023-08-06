
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; subroutine/GetRandomNumber.asm
;;
;; Simple and fast random number generator by White Flame.
;;
;; Set random_seed to an arbitrary number to randomize between
;; gaming sessions, for instance using the frame timer upon
;; pressing START on the intro screen.
;;
;;     ;; IF START PRESSED:
;;     LDA frame_counter
;;     STA random_seed
;;
;; Source:
;; codebase64.org/doku.php?id=base:small_fast_8-bit_prng
;;
;;

sub_GetRandomNumber:
    ;; Force EOR if random_seed is zero
    LDA random_seed
    BEQ +doEor

    ;; Shift left, and EOR if the high bit is set
    ASL
    BEQ +noEor
    BCC +noEor

+doEor:
    EOR #$1D

+noEor:
    STA random_seed

    RTS

