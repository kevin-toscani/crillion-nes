
;; Subroutine to check if ball color matches colliding tile color

sub_ColorsMatch:
    ;; Save tile color in temp variable
    LDA colliding_tile
    AND #%00001110
    STA temp

    ;; Get ball color
    LDA ball_flags
    AND #%11100000
    LSR
    LSR
    LSR
    LSR

    ;; Compare with tile color
    CMP temp
    RTS

