
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Subroutine: ColorizeBall
;;
;;  Applies the color set through ball_flags to the ball sprite.
;;  Expects ball_flags to be in the accumulator
;;


sub_ColorizeBall:

    ;; Get color from ball_flags
    LSR
    LSR
    LSR
    LSR
    LSR
    TAX

    ;; Add new light color of ball to PPU palette
    LDA #$3F
    STA temp
    LDA #$11
    STA temp+1
    LDA tbl_BallColorLight,x
    STA temp+2
    JSR sub_WriteByteToPPUBuffer
    
    ;; Add new dark color of ball to PPU palette
    INC temp+1
    LDA tbl_BallColorDark,x
    STA temp+2
    JSR sub_WriteByteToPPUBuffer
    
    RTS

