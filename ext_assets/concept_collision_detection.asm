;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Ball collides with solid from the top or bottom
;;  - evaulate solid
;;
;;  Ball collides with solid from the top or bottom
;;  - reverse vertical ball direction
;;
;;  Ball collides with solid from the left or right
;;  - nudge ball
;;
;;  Evaluate solid: is it a color block?
;;  - destroy block if colors match
;;
;;  Evaluate solid: is it a paint block?
;;  - apply block color to ball
;;
;;  Evaluate solid: is it a move block?
;;  - move the block in the direction opposite of collision, but only
;;    if the colors match
;;
;;  Evaluate solid: is it a death block?
;;  - kill the ball
;;
;;  Are there no blocks left?
;;  - finalize the level
;;
;;
;;  COLLISION DETECTION
;;  
;;  1) - if the ball moves to the right
;;     - and the ball's right edge is equal to the solid's left edge
;;     - then nudge the ball to the left
;;     - and apply collision evaluation to the solid block type
;;
;;  2) - if the ball moves to the left
;;     - and the ball's left edge is equal to the solid's right edge
;;     - then nudge the ball to the right
;;     - and apply collision evaluation to the solid block type
;;
;;  3) - if the ball moves down
;;     - and the ball's bottom edge is equal to the solid's top edge
;;     - then move the ball up
;;     - and apply collision evaluation to the solid block type
;;
;;  4) - if the ball moves up
;;     - and the ball's top edge is equal to the solid's bottom edge
;;     - then move the ball down
;;     - and apply collision evaluation to the solid block type
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Game constants

BALL_LEFT_WGA  = #$FA ; Left position within game area (#$04 minus #$10)
BALL_TOP_WGA   = #$DA ; Top position within game area (#$04 minus #$30)
BALL_HALF_SIZE = #$04 ; Half the ball's size (8x8)
TILE_IS_SOLID  = #%00000001


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Game zero page

ball_left        .dsb 1
ball_center      .dsb 1
ball_right       .dsb 1
ball_top         .dsb 1
ball_middle      .dsb 1
ball_bottom      .dsb 1
colliding_tile   .dsb 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Main game loop

    ;; Get ball's x-left, x-center, x-right position
    LDA ball_xpos_hi
    CLC
    ADC #BALL_LEFT_WGA
    STA ball_left_wga
    CLC
    ADC #BALL_HALF_SIZE
    STA ball_center
    CLC
    ADC #BALL_HALF_SIZE
    STA ball_right

    ;; Get ball's y-top, y-middle, y-bottom position
    LDA ball_ypos_hi
    CLC
    ADC #BALL_TOP_WGA
    STA ball_top
    CLC
    ADC #BALL_HALF_SIZE
    STA ball_middle
    CLC
    ADC #BALL_HALF_SIZE
    STA ball_bottom

+checkRightCollision:
    ;; Check if ball moves right
    ;; No need to check nudging here as that will never collide with a tile
    LDA buttons_held
    AND #BUTTON_RIGHT
    BEQ +checkLeftCollision

    ;; Check tile at right position
    LDA ball_middle
    STA temp
    LDA ball_right
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +checkTopCollision ; no need for left check as ball moves right

    ;; Tile is solid; nudge ball and evaluate tile type
    LDA ball_flags
    ORA #NUDGE_BALL_LEFT
    STA ball_flags
    JSR sub_EvaluateTileType
    JMP +checkTopCollision

+checkLeftCollision:
    ;; Check if ball moves right
    ;; No need to check nudging here as that will never collide with a tile
    LDA buttons_held
    AND #BUTTON_LEFT
    BEQ +checkTopCollision

    ;; Check tile at right position
    LDA ball_middle
    STA temp
    LDA ball_left
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +checkTopCollision

    ;; Tile is solid; nudge ball and evaluate tile type
    LDA ball_flags
    AND #NUDGE_BALL_LEFT
    STA ball_flags
    JSR sub_EvaluateTileType
    ;JMP +checkTopCollision

+checkTopCollision:
    ;; Check if ball moves up
    LDA ball_flags
    AND #BALL_MOVES_DOWN
    BNE +checkBottomCollision

    ;; Check tile at top position
    LDA ball_top
    STA temp
    LDA ball_center
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +doneCheckingCollision ; no need for bottom check as ball moves up

    ;; Tile is solid; move ball down and evaluate tile type
    LDA ball_flags
    ORA #MOVE_BALL_DOWN
    STA ball_flags
    JSR sub_EvaluateTileType
    JMP +doneCheckingCollision

+checkBottomCollision:
    ;; No movement check needed: since ball is not moving up, it must move down

    ;; Check tile at bottom position
    LDA ball_bottom
    STA temp
    LDA ball_center
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +doneCheckingCollision

    ;; Tile is solid; move ball up and evaluate tile type
    LDA ball_flags
    AND #MOVE_BALL_UP
    STA ball_flags
    JSR sub_EvaluateTileType
    ;JMP +doneCheckingCollision

+doneCheckingCollision:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Subroutines

sub_ConvertXYToTileType:
    ;; - Expects temp to be y-position of ball within game area
    ;; - Expects temp+1 to be x-position of ball within game area
    ;; - Puts result in accumulator and zp variable
    ;; - Corrupts X-register
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
    STA collide_tile
    RTS

sub_EvaluateTileType:
    ;; - Expects X-register to be the ADDR_SCREENTILERAM offset
    ;; - Uses zp variable collide_tile
    ;; @TODO: add actual tile behavior (apart from solidity)
    RTS

