;; Ball variables
ball_xpos           .db 1   ; left pixel x-position on screen
ball_ypos           .db 1   ; top pixel y-position on screen
ball_lives          .db 1   ; number of lives left
ball_score          .db 5   ; decimal score, five bytes (0-9)
ball_bonus          .db 3   ; decimal bonus points, three bytes (0-9)


;; Ball flags
;; #% c c c l h v n a
;;    | | | | | | | +-- ball is dead (0) or alive (1)
;;    | | | | | | +---- ball is being nudged (1) or not (0)
;;    | | | | | +------ ball moves up (0) or down (1)
;;    | | | | +-------- ball is moving horizontally (1) or not (0)
;;    | | | +---------- ball is moving left (0) or right (1)
;;    +-+-+------------ ball color (1-6)
ball_flags          .db 1


;; Screen mode
;; #%00000000 = intro screen
;; #%. . . . . . w g
;;   | | | | | | | +--------- game mode (1) or not (0)
;;   | | | | | | +----------- win screen (1) or not (0)
;;   +-+-+-+-+-+------------- unused
screen_mode         .db 1


;; Start level pointer
;; You can start the game at level 1, 5, 9, 13 or 17.
;; This is the pointer that tells you at which level to start.
startlevel_pointer  .db 1 

