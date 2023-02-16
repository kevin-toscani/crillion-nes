;; miscellaneous (non-zeropage) ram variables go here

;; PPU buffer (3x16 bytes, as a capped max for NMI)
ppu_buffer                .dsb 48

;; _framecounter, counts from ANIMATION_SPEED to 0 per slide
explosion_framecounter    .dsb 4

;; _currentframe, keeps track which anim frame we're at
explosion_currentframe    .dsb 4

;; _attributes, to distinguish between ball and wall explosion
explosion_attributes      .dsb 4

;; x- and y-coordinate of the explosion
explosion_x               .dsb 4
explosion_y               .dsb 4

;; active flag to see if animation is/should be shown
explosion_active          .dsb 4
