
sub_LoadAnimations:

    ;; Set up loop
    LDX #$00
    -loop_load_animation:
        ;; Check if current animation is active. If not, goto next
        LDA explosion_active,x
        BNE +
            JMP +next
        +

        ;; Check the explosion framecounter
        LDA explosion_timer,x
        BNE +
            ;; Frametimer is 0
            ;; Reset to animation speed
            LDA #ANIMATION_SPEED
            STA explosion_timer,x

            ;; Set next animation frame, and check if we're done yet
            INC explosion_currentframe,x
            LDA explosion_currentframe,x
            CMP #ANIM_SLIDES
            BNE +

            ;; If we're done, inactivate current explosion, go to the next one
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
        LDA explosion_attributes,x
        STA temp+4

        ;; Load current frame into Y-register
        LDY explosion_currentframe,x

        ;; Load current frame ROM address from table
        LDA explosion_anim_lo,y
        STA pointer
        LDA explosion_anim_hi,y
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
        
            ;; Do not draw empty sprites
            LDA (pointer),y
            BEQ +nextSprite
        
                ;; Add y-position to sprite ram buffer
                LDA temp+2
                STA ADDR_SPRITERAM,x
                INX

                ;; Get tile number from frame ROM address, and
                ;; add it to sprite ram buffer
                LDA (pointer),y
                STA ADDR_SPRITERAM,x
                INX

                ;; Add attribute data to sprite ram buffer
                LDA temp+4
                STA ADDR_SPRITERAM,x
                INX

                ;; Add x-position to sprite ram buffer
                LDA temp+3
                STA ADDR_SPRITERAM,x
                INX

            +nextSprite:

            ;; Check if all sprites are done
            INY
            CPY #SLIDE_SIZE
            BEQ +updateSpriteRamPointer

            ;; Update x value
            LDA temp+3
            CLC
            ADC #$08
            STA temp+3

            ;; Update temp for x,y position
            INC temp
            LDA temp
            CMP #SLIDE_WIDTH
            BNE +
                ;; Row is done; reset x-position
                LDA temp+1
                STA temp+3

                ;; Update y-position
                LDA temp+2
                CLC
                ADC #$08
                STA temp+2

                ;; Reset row timer
                LDA #$00
                STA temp
            +

        JMP -loop_load_sprite

    +updateSpriteRamPointer:
        STX sprite_ram_pointer

        ;; Retrieve x-register from stack
        PLA
        TAX

    +next:
        ;; Check if all animations have been updated
        INX
        CPX #MAX_ANIMATIONS
        BEQ +cleanUpSpriteRam

    JMP -loop_load_animation

+cleanUpSpriteRam:
    LDX sprite_ram_pointer
    LDA #$EF
    -
        STA ADDR_SPRITERAM,x
        INX
    BNE -
    
    RTS
    
