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

;; Max number of animations on screen
MAX_ANIMATIONS  = #$04

;; Animation data
ANIMATION_SPEED = #$04 ; number of frames per animation frame
ANIM_SLIDES     = #$0A ; number of slides in an animation

;; Slide data
SLIDE_WIDTH     = #$03 ; slide width in tiles
SLIDE_SIZE      = #$09 ; total number of tiles in slide

;; Sprite RAM address
SPRITE_RAM      = $0200
