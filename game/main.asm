;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; game/main.asm
;;
;; The main game loop content.
;;
;;


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
