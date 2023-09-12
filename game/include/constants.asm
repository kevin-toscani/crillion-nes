
;; Enable test mode
;; - Test mode adds a test level and allows the developer to start
;;   at any given level with any number of lives. Remove the line
;;   that starts with TESTING (or add a semicolon in front) to
;;   disable test mode.
;TESTING    =   1
START_LEVEL =   0
LAST_LEVEL  =   1
START_LIVES = 255


;; Starting address for screen tile RAM
ADDR_SCREENTILERAM  = $0400


;; Ball bounding box constants
BALL_HEIGHT  = #$08  ; Height of the ball graphic within the sprite(s)
BALL_WIDTH   = #$08  ; Width of the ball graphic within the sprite(s)
BALL_TOP     = #$00  ; Top offset of the ball graphic
BALL_LEFT    = #$00  ; Left offset of the ball graphic

;; Ball speed (high/low byte), tile and attribute
BALL_SPEED_HI  = #$01        ; High byte of ball speed
BALL_SPEED_LO  = #$88        ; Low byte of ball speed
BALL_TILE_CHR  = #$01        ; CHR tile ID
BALL_ATTR      = #%00000000  ; Attribute (no mirror, subpalette 0)
BALL_LEFT_WGA  = #$F0        ; Left position within game area (-#$10)
BALL_TOP_WGA   = #$D0        ; Top position within game area (-#$30)
BALL_HALF_SIZE = #$04        ; Half the ball's size (8x8)

;; Move block offset within game area
MOVE_BLOCK_LEFT_WGA  = #$F8   ; Left position within game area (-#$08)
MOVE_BLOCK_TOP_WGA   = #$D8   ; Top position within game area (-#$28)

;; Ball flag helpers
BALL_IS_DEAD     = #%00000001
KILL_BALL        = #%00000001
REVIVE_BALL      = #%11111110
NUDGE_BALL_RIGHT = #%00000010
NUDGE_BALL_LEFT  = #%11111101
BALL_IS_FROZEN   = #%00000100
FREEZE_BALL      = #%00000100
UNFREEZE_BALL    = #%11111011
BALL_MOVES_DOWN  = #%00010000
MOVE_BALL_DOWN   = #%00010000
MOVE_BALL_UP     = #%11101111
BALL_COLOR       = #%11100000

;; Tile flag helpers
TILE_IS_SOLID    = #%00000001
IS_COLOR_BLOCK   = #%10000000
IS_MOVE_BLOCK    = #%01000000
IS_PAINT_BLOCK   = #%00100000
IS_DEATH_BLOCK   = #%00010000


;; Screen load helpers
LOAD_INTRO_SCREEN = #%10000000
LOAD_GAME_SCREEN  = #%10000001
LOAD_WIN_SCREEN   = #%10000010
IS_INTRO_SCREEN   = #%00000000
IS_GAME_SCREEN    = #%00000001
IS_WIN_SCREEN     = #%00000010
CHECK_SCREEN_MODE = #%00000011


;; Game area bounds
BOUND_TOP       = #$30
BOUND_BOTTOM    = #$C8
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


;; Max number of nudge and bonus frames
NUDGE_FRAMES    = #$06
BONUS_FRAMES    = #$08

;; How many bonus points get subtracted per frame after a level
BONUS_COUNTDOWN_PER_FRAME = #$09

;; Helper constant for when a level is done loading
LEVEL_END       = #$FF


;; APU registers
PULSE1_VOLUME   = $4000
PULSE1_SWEEP    = $4001
PULSE1_TIMER_LO = $4002
PULSE1_TIMER_HI = $4003
PULSE1_LENGTH   = $4003

PULSE2_VOLUME   = $4004
PULSE2_SWEEP    = $4005
PULSE2_TIMER_LO = $4006
PULSE2_TIMER_HI = $4007
PULSE2_LENGTH   = $4007

NOISE_VOLUME    = $400C
NOISE_PERIOD    = $400E
NOISE_LENGTH    = $400F


;; Sound effects
SFX_EXPLOSION   = #0
SFX_THUD        = #1
SFX_BOUNCE      = #2


;; Character map
_SPACE = #$00
_0     = #$01
_1     = #$02
_2     = #$03
_3     = #$04
_4     = #$05
_5     = #$06
_6     = #$07
_7     = #$08
_8     = #$09
_9     = #$0A
_A     = #$0B
_B     = #$0C
_C     = #$0D
_D     = #$0E
_E     = #$0F
_F     = #$10
_G     = #$11
_H     = #$12
_I     = #$13
_J     = #$14
_K     = #$15
_L     = #$16
_M     = #$17
_N     = #$18
_O     = #$19
_P     = #$1A
_Q     = #$1B
_R     = #$1C
_S     = #$1D
_T     = #$1E
_U     = #$1F
_V     = #$20
_W     = #$21
_X     = #$22
_Y     = #$23
_Z     = #$24
_COMMA = #$25
_DOT   = #$26
_COLON = #$27
_COPY  = #$28

