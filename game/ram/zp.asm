;; Ball variables
ball_xpos_hi           .dsb 1
ball_xpos_lo           .dsb 1
ball_ypos_hi           .dsb 1
ball_ypos_lo           .dsb 1
ball_lives             .dsb 1   ; number of lives left
ball_score             .dsb 6   ; decimal score, five bytes (0-9)
ball_bonus             .dsb 3   ; decimal bonus points, three bytes (0-9)

;; Ball bounding box, relative to the screen
ball_left              .dsb 1
ball_center            .dsb 1
ball_right             .dsb 1
ball_top               .dsb 1
ball_middle            .dsb 1
ball_bottom            .dsb 1

;; Update-position check
ball_update_position   .dsb 1


;; Ball flags
;; #% c c c v . f n a
;;    | | | | | | | +-- ball is dead (0) or alive (1)
;;    | | | | | | +---- ball is being nudged left (0) or right (1)
;;    | | | | | +------ ball is frozen (not moving)
;;    | | | | +-------- (unused for now)
;;    | | | +---------- ball moves up (0) or down (1)
;;    +-+-+------------ ball color (1-6)
ball_flags             .dsb 1


;; Screen mode
;; #% u . . . . . t t
;;    | | | | | | +-+--------- screen type (00 = intro, 01 = game, 10 = win)
;;    | +-+-+-+-+------------- unused
;;    +----------------------- should the screen update
screen_mode            .dsb 1


;; Start level pointer
;; You can start the game at level 1, 5, 9, 13 or 17.
;; This is the pointer that tells you at which level to start.
startlevel_pointer     .dsb 1 


;; PPU buffer variables
ppu_buffer_update      .dsb 1
ppu_buffer_pointer     .dsb 1

;; Pointer to keep track of the number of explosions
explosion_pointer      .dsb 1

;; Sprite RAM pointer to keep track of sprites to update
sprite_ram_pointer     .dsb 1

;; Nudge counter
nudge_counter          .dsb 1

;; Current level
current_level          .dsb 1

;; Tile type the ball is currently colliding with
colliding_tile         .dsb 1
