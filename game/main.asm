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

    ;; CONCEPT SCRIPTS
    
    ;; Upon pressing A, an explosion will happen on screen
    .include "game/test/show_animation.asm"

    ;; On the game screen, the ball should move
    LDA screen_mode
    CMP #IS_GAME_SCREEN
    BEQ +
        JMP ++
    +
    .include "game/test/move_ball.asm"
    ++
    
    ;; Upon pressing START, (next level) design will be drawn
    .include "game/test/load_next_level.asm"



    ;; Sprite clean-up
    LDX sprite_ram_pointer
    LDA #$EF
    -
        STA ADDR_SPRITERAM,x
        INX
    BNE -
