
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
    LDA #$18
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
    LDA sprites_update_position
    BEQ +
        JMP +skipSpriteMovement
    +

    ;; Check if ball is frozen
    LDA ball_flags
    AND #BALL_IS_FROZEN
    BEQ +
        JMP +skipBallMovement
    +

    ;; Move the ball
    .include "game/include/main/move_ball.asm"
    
    ;; Do collision detection
    .include "game/include/main/collision_detection.asm"
    
    ;; Update bonus
    .include "game/include/main/update_bonus.asm"

    ;; Check if self-destruct
    LDA buttons_pressed
    AND #BUTTON_SELECT
    BEQ +
        JSR sub_Selfdestruct
    +


+skipBallMovement:
    ;; Move blocks a pixel up/down/left/right
    .include "game/include/main/move_blocks.asm"

+skipSpriteMovement:
    ;; Testing timed PPU scroll concept (disabled)
    ;; .include "game/test/timed_ppuscroll_test.asm"

    ;; Check if ball is dead
    LDA ball_flags
    AND #BALL_IS_DEAD
    BEQ +
        JMP +ballIsDead
    +
    
    ;; Add ball to sprite buffer
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
    JMP +drawBlocks

+ballIsDead:
    ;; Check if kill timer has reset
    LDA kill_timer
    BEQ +
        JMP +drawBlocks
    +
    
    ;; Take a live
    DEC ball_lives
    BNE +
        ;; If no lives left, initiate game over sequence
        JMP lbl_GameOver
    +
    
    ;; Reload current level
    JMP lbl_InitiateLevelLoad


+drawBlocks:
    ;; Draw moving block(s, if any)
    .include "game/include/main/draw_blocks.asm"
    JMP +doneScreenLoad



+checkNextScreen:

    ;; Upon pressing LEFT or RIGHT, increment the level number with 4
    ;; Upon pressing START, the selected level will start
    .include "game/include/main/select_level.asm"


+doneScreenLoad:

    ;; Load animations (if any)
    ;; and sprite clean-up
    JSR sub_LoadAnimations

