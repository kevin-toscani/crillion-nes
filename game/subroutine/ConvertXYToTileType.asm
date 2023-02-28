
;; Subroutine to convert the ball's position to a tile type
;; - Expects temp to be y-position of ball within game area
;; - Expects temp+1 to be x-position of ball within game area
;; - Puts result in accumulator and zp variable
;; - Corrupts X-register

sub_ConvertXYToTileType:
    LDA temp
    LSR
    LSR
    LSR
    LSR
    STA temp
    LDA temp+1
    AND #%11110000
    CLC
    ADC temp
    TAX
    LDA ADDR_SCREENTILERAM, x
    STA colliding_tile
    RTS

