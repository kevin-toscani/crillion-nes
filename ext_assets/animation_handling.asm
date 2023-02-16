;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Let's talk animation
;;  
;;  1) An animation consists of 
;;     - a number of slides
;;  2) Each slide consists of:
;;     - a width and height
;;     - a set of sprites (total width x height)
;;  
;;  Crillion uses a fixed number of frames per slide; no speed per
;;  animation is needed.
;;
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Declared constants

;; Max number of animations on screen
MAX_ANIMATIONS  = #$04

;; Animation data
ANIMATION_SPEED = #$03 ; number of frames per animation frame
ANIM_SLIDES     = #$08 ; number of slides in an animation

;; Slide data
SLIDE_WIDTH     = #$03 ; slide width in tiles
SLIDE_SIZE      = #$09 ; total number of tiles in slide

; ; Sprite RAM address
SPRITE_RAM      = $2000



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Zero-page variables

;; Pointer to keep track of the number of explosions
explosion_pointer         .db 1

;; Let's set up sprite RAM while we're at it
sprite_ram_pointer        .db 1



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc RAM variables to keep track of each explosion (max.4)

;; _framecounter, counts from ANIMATION_SPEED to 0 per slide
explosion_framecounter    .db 4

;; _currentframe, keeps track which anim frame we're at
explosion_currentframe    .db 4

;; _attributes, to distinguish between ball and wall explosion
explosion_attributes      .db 4

;; x- and y-coordinate of the explosion
explosion_x               .db 4
explosion_y               .db 4

;; active flag to see if animation is/should be shown
explosion_active          .db 4



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; In main game loop, add animation on collision

    ;; Get most recent slot for explosion
    LDX explosion_pointer

    ;; If 0, use max pointer value
    BEQ +
        LDX #MAX_ANIMATIONS
    +

    ;; Decrease pointer by one
    DEX
    STX explosion_pointer

    ;; Load explosion data into RAM
    LDA #$00
    STA explosion_currentframe,x
    LDA #ANIMATION_SPEED
    STA explosion_framecounter,x
    LDA #$40 ; should be dynamic x-variable
    STA explosion_x,x
    LDA #$40 ; should be dynamic y-variable
    STA explosion_y,x
    LDA #%00010001
    STA explosion_attibutes,x
    LDA #$01
    STA explosion_active,x



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; In main game loop, animate active explosions

    ;; Set up loop
    LDX #MAX_ANIMATIONS
    -loop_load_animation:
        ;; Check if current animation is active. If not, goto next
        LDA explosion_active,x
        BNE +
            JMP +next
        +

        ;; Check the explosion framecounter
        LDA explosion_framecounter,x
        BNE +
            ;; Framecounter is 0
            ;; Reset to animation speed
            LDA #ANIMATION_SPEED
            STA explosion_framecounter,x

            ;; Set next animation frame, and check if we're done yet
            INC explosion_currentframe,x
            LDA explosion_currentframe,x
            CMP #ANIM_SLIDES
            BNE +

            ;; If we're done, inactivate current explosion and
            ;; go to the next one
            LDA #$00
            STA explosion_active,x
            JMP +next
        +

        ;; Load (x,y) position in temp variables
        LDA explosion_x,x
        STA temp+1
        STA temp+3
        LDA explosion_y,x
        STA temp+2

        ;; Load attribute in temp variable
        LDA explosion_attribute,x
        STA temp+5

        ;; Load current frame into Y-register
        LDY explosion_currentframe,x

        ;; Load current frame ROM address from table
        LDA explosion_anim_hi,y
        STA pointer
        LDA explosion_anim_lo,y
        STA pointer+1

        ;; Save x-register on stack
        TXA
        PHA

        ;; Load sprites into sprite RAM
        LDX sprite_ram_pointer
        LDY #$00

        ;; Prepare (x,y) offset for loop
        STY temp

        -loop_load_sprite:
            ;; Add x-position to sprite ram buffer
            LDA temp+3
            STA SPRITE_RAM,x
            INX

            ;; Get tile number from frame ROM address, and
            ;; add it to sprite ram buffer
            LDA (pointer),y
            STA SPRITE_RAM,x
            INX

            ;; Add attribute data to sprite ram buffer
            LDA temp+5
            STA SPRITE_RAM,x
            INX

            ;; Add y-position to sprite ram buffer
            LDA temp+2
            STA SPRITE_RAM,x
            INX

            ;; Check if all sprites are done
            INY
            CPY #SLIDE_SIZE
            BEQ +done

            ;; Update x value
            LDA temp+3
            CLC
            ADC #$08
            STA temp+3

            ;; Update temp for x,y position
            INC temp
            LDA temp
            CMP #SLIDE_WIDTH
            BEQ +
                ;; Row is done; reset x-position
                LDA temp+1
                STA temp+3

                ;; Update y-position
                LDA temp+2
                CLC
                ADC #$08
                STA temp+2

                ;; Reset row counter
                LDA #$00
                STA temp
            +

        JMP -loop_load_sprite

    +done:
        ;; Retrieve x-register from stack
        PLA
        TAX

    +next:
        ;; Check if all animations have been updated
        DEX
        BEQ +done

    JMP -loop_load_animation
+done:



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Explosion data stored in ROM


;; CHR tile-id's per slide of explosion
explosion_slide0:
    .db #$3C, #$3D, #$3E
    .db #$4C, #$4D, #$4E
    .db #$5C, #$5D, #$5E

explosion_slide1:
    .db #$39, #$3A, #$3B
    .db #$49, #$4A, #$4B
    .db #$59, #$5A, #$5B

explosion_slide2:
    .db #$36, #$37, #$38
    .db #$46, #$47, #$48
    .db #$56, #$57, #$58

explosion_slide3:
    .db #$33, #$34, #$35
    .db #$43, #$44, #$45
    .db #$53, #$54, #$55

;; High and low bytes of animation slides
explosion_anim_hi:
    .db >#explosion_slide0
    .db >#explosion_slide1
    .db >#explosion_slide2
    .db >#explosion_slide3
    .db >#explosion_slide3
    .db >#explosion_slide2
    .db >#explosion_slide1
    .db >#explosion_slide0

explosion_anim_lo:
    .db <#explosion_slide0
    .db <#explosion_slide1
    .db <#explosion_slide2
    .db <#explosion_slide3
    .db <#explosion_slide3
    .db <#explosion_slide2
    .db <#explosion_slide1
    .db <#explosion_slide0

