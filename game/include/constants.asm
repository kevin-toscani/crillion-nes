;; Ball bounding box constants
BALL_HEIGHT  = #$08  ; Height of the ball graphic within the sprite(s)
BALL_WIDTH   = #$08  ; Width of the ball graphic within the sprite(s)
BALL_TOP     = #$04  ; Top offset of the ball graphic
BALL_LEFT    = #$04  ; Left offset of the ball graphic


;; Ball speed (high/low byte), tile and attribute
BALL_SPEED_HI = #$02
BALL_SPEED_LO = #$C0
BALL_TILE_CHR = #$01
BALL_ATTR     = #%00000000


;; Ball flag helpers
BALL_IS_DEAD    = #%00000001
KILL_BALL       = #%00000001
REVIVE_BALL     = #%11111110
BALL_IS_NUDGED  = #%00000010
NUDGE_BALL      = #%00000010
STOP_NUDGE_BALL = #%11111101
BALL_MOVES_DOWN = #%00000100
MOVE_BALL_DOWN  = #%00000100
MOVE_BALL_UP    = #%11111011
BALL_IS_FROZEN  = #%00010000
FREEZE_BALL     = #%00010000
UNFREEZE_BALL   = #%11101111


;; Screen load helpers
LOAD_INTRO_SCREEN = #%10000100
LOAD_GAME_SCREEN  = #%10000010
LOAD_WIN_SCREEN   = #%10000001

;; Game area bounds
BOUND_TOP       = #$10
BOUND_BOTTOM    = #$98
BOUND_LEFT      = #$10
BOUND_RIGHT     = #$E8


;; Max number of animations on screen
MAX_ANIMATIONS  = #$04


;; Animation data
ANIMATION_SPEED = #$04 ; number of frames per animation frame
ANIM_SLIDES     = #$0A ; number of slides in an animation


;; Slide data
SLIDE_WIDTH     = #$03 ; slide width in tiles
SLIDE_SIZE      = #$09 ; total number of tiles in slide

