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

.include "game/test/tile_update.asm"

.include "game/test/show_animation.asm"
