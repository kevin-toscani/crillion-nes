;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; game/main.asm
;;
;; The main game loop content.
;;
;;

    ;; Reset sprite pointer every game loop
    LDA #$00
    STA sprite_ram_pointer

    ;; Store previous buttons
    LDA buttons_held
    STA buttons_prev

    ;; Read controller input
    JSR sub_ReadController

    ;; Get buttons released
    LDA buttons_held
    EOR #$FF
    AND buttons_prev
    STA buttons_released

    ;; Set buttons pressed
    LDA buttons_prev
    EOR #$FF
    AND buttons_held
    STA buttons_pressed

    ;; Load screen?
    LDA screen_mode
    AND #%10000000
    BEQ +screenLoaded

    ;; Get screen type to load
    LDA screen_mode
    AND #%00000011
    TAY
    
    ;; Get address to load screen type from
    LDA tbl_LoadScreenLo,y
    STA pointer
    LDA tbl_LoadScreenHi,y
    STA pointer+1

    ;; Load screen
    JSR sub_DisableRendering
    JSR sub_JumpToPointer
    JSR sub_EnableRendering
    
    ;; Don't load screen anymore next loop
    LDA screen_mode
    AND #%01111111
    STA screen_mode
    

+screenLoaded:

    ;; Check if we're on the game screen
    LDA screen_mode
    CMP #IS_GAME_SCREEN
    BEQ +
        JMP +checkNextScreen
    +

    ;; Load sprite 0 in place
    LDA #$28
    STA ADDR_SPRITERAM
    LDA #$0F
    STA ADDR_SPRITERAM+1
    LDA #$22
    STA ADDR_SPRITERAM+2
    LDA #$F8
    STA ADDR_SPRITERAM+3
    LDA #$04
    STA sprite_ram_pointer

    ;; We're on the game screen
    ;; Check if position should be updated (ie. has nmi happened yet)
    LDA ball_update_position
    BEQ +
        JMP +skipBallMovement
    +
    
    ;; Move the ball
    .include "game/include/main/move_ball.asm"
    
    ;; Do collision detection
    .include "game/include/main/collision_detection.asm"

    ;; Testinging timed PPU scroll concept
    .include "game/test/timed_ppuscroll_test.asm"


+skipBallMovement:
    ;; Add to sprite buffer
    LDX sprite_ram_pointer
    LDA ball_ypos_hi
    STA ADDR_SPRITERAM,x
    INX
    LDA #BALL_TILE_CHR
    STA ADDR_SPRITERAM,x
    INX
    LDA #BALL_ATTR
    STA ADDR_SPRITERAM,x
    INX
    LDA ball_xpos_hi
    STA ADDR_SPRITERAM,x
    INX
    STX sprite_ram_pointer
    JMP +doneScreenLoad


+checkNextScreen:

    ;; Upon pressing START, (next level) design will be drawn
    .include "game/test/load_next_level.asm"


+doneScreenLoad:

    ;; Load animations (if any)
    .include "game/include/main/load_animations.asm"

    ;; Sprite clean-up
    LDX sprite_ram_pointer
    LDA #$EF
    -
        STA ADDR_SPRITERAM,x
        INX
    BNE -
