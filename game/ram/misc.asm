
;; miscellaneous (non-zeropage) ram variables go here

.enum ADDR_OTHERRAM
    ;; PPU buffer (3x32 bytes, as a capped max for NMI)
    ppu_buffer                .dsb 96

    ;; Explosion timer, counts from ANIMATION_SPEED to 0 per slide
    explosion_timer           .dsb 4

    ;; Explosion currentframe, keeps track which anim frame we're at
    explosion_currentframe    .dsb 4

    ;; Explosion attributes, to distinguish between ball and wall explosion
    explosion_attributes      .dsb 4

    ;; x- and y-coordinate of the explosion
    explosion_x               .dsb 4
    explosion_y               .dsb 4

    ;; active flag to see if animation is/should be shown
    explosion_active          .dsb 4
    
    ;; move block variables (similar to explosions)
    move_block_x              .dsb 4
    move_block_y              .dsb 4
    move_block_timer          .dsb 4 ; doubles as move_block_active
    move_block_tile_type      .dsb 4

    ;; move block flags
    ;; #% ccc ... h d
    ;;    ||| ||| | +-- direction: up/left (1) or right/down (0) 
    ;;    ||| ||| +---- direction: horizontal (1) or vertical (0)
    ;;    ||| +++----- (unused)
    ;;    +++--------- color (1-6, also unused)
    move_block_flags          .dsb 4
    
.ende


.enum ADDR_SCREENTILERAM
    ;; screen tile type data
    ;;  #% b m p d ccC s
    ;;     | | | | ||| +-- block is solid
    ;;     | | | | ||+---- block color (CHR offset boolean)
    ;;     | | | | ++----- block color (subpal 0-3)
    ;;     | | | +-------- death block
    ;;     | | +---------- paint block
    ;;     | +------------ move block
    ;;     +-------------- color block
    tile_type                 .dsb 160
    
    ;; attribute table in ram (for easy updating during gameplay)
    tile_attributes           .dsb 64
.ende

