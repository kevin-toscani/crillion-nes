;; Ball variables
ball_xpos_hi        .dsb 1
ball_xpos_lo        .dsb 1
ball_ypos_hi        .dsb 1
ball_ypos_lo        .dsb 1
ball_lives          .dsb 1   ; number of lives left
ball_score          .dsb 6   ; decimal score, five bytes (0-9)
ball_bonus          .dsb 3   ; decimal bonus points, three bytes (0-9)


;; Update-position check
ball_update_position   .dsb 1


;; Ball flags
;; #% c c c l h v n a
;;    | | | | | | | +-- ball is dead (0) or alive (1)
;;    | | | | | | +---- ball is being nudged (1) or not (0)
;;    | | | | | +------ ball moves up (0) or down (1)
;;    | | | | +-------- ball is moving horizontally (1) or not (0)
;;    | | | +---------- ball is moving left (0) or right (1)
;;    +-+-+------------ ball color (1-6)
ball_flags          .dsb 1


;; Screen mode
;; #%00000000 = intro screen
;; #%. . . . . . w g
;;   | | | | | | | +--------- game mode (1) or not (0)
;;   | | | | | | +----------- win screen (1) or not (0)
;;   +-+-+-+-+-+------------- unused
screen_mode         .dsb 1


;; Start level pointer
;; You can start the game at level 1, 5, 9, 13 or 17.
;; This is the pointer that tells you at which level to start.
startlevel_pointer  .dsb 1 


;; PPU buffer variables
ppu_buffer_update   .dsb 1
ppu_buffer_pointer  .dsb 1

;; Pointer to keep track of the number of explosions
explosion_pointer         .dsb 1

;; Sprite RAM pointer to keep track of sprites to update
sprite_ram_pointer        .dsb 1

