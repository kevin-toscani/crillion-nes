
;; Ball variables
ball_xpos_hi           .dsb 1
ball_xpos_lo           .dsb 1
ball_ypos_hi           .dsb 1
ball_ypos_lo           .dsb 1
ball_ypos_hi_prev      .dsb 1
ball_ypos_lo_prev      .dsb 1
ball_xpos_hi_prev      .dsb 1
ball_xpos_lo_prev      .dsb 1
ball_lives             .dsb 1   ; number of lives left
ball_score             .dsb 6   ; decimal score, five bytes (0-9)
add_to_score           .dsb 6
ball_bonus             .dsb 3   ; decimal bonus points, three bytes (0-9)

;; Ball bounding box, relative to the screen
ball_left              .dsb 1
ball_center            .dsb 1
ball_right             .dsb 1
ball_top               .dsb 1
ball_middle            .dsb 1
ball_bottom            .dsb 1

;; Update-position check
sprites_update_position  .dsb 1

;; Lock block space helper variable
;; When the ball hits a lock block, it should only move if the space
;; where it moves to, is not solid. This variable holds the metatile
;; offset of the position where the lock block should move to, so
;; we can check if it is solid or not.
;;
;; UP:    #%11110000 #$F0
;; DOWN:  #%00010000 #$10
;; LEFT:  #%11111111 #$FF
;; RIGHT: #%00000001 #$01
;;        #%d......h
move_block_space_to_check  .dsb 1


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



;; PPU buffer variables
ppu_buffer_update      .dsb 1
ppu_buffer_pointer     .dsb 1

;; Pointer to keep track of the number of explosions
explosion_pointer      .dsb 1

;; Pointer to keep track of the number of move blocks
move_block_pointer     .dsb 1

;; Sprite RAM pointer to keep track of sprites to update
sprite_ram_pointer     .dsb 1

;; Timers 
nudge_timer            .dsb 1
bonus_timer            .dsb 1
kill_timer             .dsb 1
unfreeze_timer         .dsb 1
endgame_palette_timer  .dsb 1

;; Current level (doubles as level select variable)
current_level          .dsb 1

;; Tile type the ball is currently colliding with
colliding_tile         .dsb 1

;; Number of blocks left on screen
blocks_left            .dsb 1

;; Sound control variables
max_noise              .dsb 1
sweep_noise            .dsb 1
current_noise          .dsb 1
noise_timer            .dsb 1
do_beeps               .dsb 1
soft_pulse1            .dsb 1
noise_muted            .dsb 1

;; Sound effect variables
sfx_address            .dsb 2
sfx_timer              .dsb 3
sfx_frequency          .dsb 2
sfx_sweep_count        .dsb 1
sfx_sweep_volume       .dsb 1
sfx_sweep_next_volume  .dsb 1
sfx_sweep_frequency    .dsb 1

sfx_endgame_enabled    .dsb 1
sfx_endgame_p1_rest    .dsb 1
sfx_endgame_p1_freq_hi .dsb 1
sfx_endgame_p1_freq_lo .dsb 1
sfx_endgame_p2_rest    .dsb 1
sfx_endgame_p2_freq_hi .dsb 1
sfx_endgame_p2_freq_lo .dsb 1


;; Additional NMI check for timed PPU fade
check_nmi              .dsb 1

;; The TV system this game is running on (0=ntsc, 1=pal, 2=dendy, 3=unknown)
tv_system              .dsb 1

;; This variable should be used for absolutely nothing
void                   .dsb 1

;; Hacky solution to prevent double blinds
game_won               .dsb 1