
;; CHR tile-id's per slide of explosion
explosion_slide0:
    .db #$00, #$00, #$00
    .db #$2C, #$2D, #$2E
    .db #$3C, #$3D, #$3E

explosion_slide1:
    .db #$00, #$00, #$00
    .db #$29, #$2A, #$2B
    .db #$39, #$3A, #$3B

explosion_slide2:
    .db #$16, #$00, #$00
    .db #$26, #$27, #$28
    .db #$36, #$37, #$38

explosion_slide3:
    .db #$00, #$14, #$15
    .db #$23, #$24, #$25
    .db #$33, #$34, #$35

explosion_slide4:
    .db #$10, #$11, #$12
    .db #$20, #$21, #$22
    .db #$30, #$31, #$32

;; High and low bytes of animation slides
explosion_anim_hi:
    .db >#explosion_slide0
    .db >#explosion_slide1
    .db >#explosion_slide2
    .db >#explosion_slide3
    .db >#explosion_slide4
    .db >#explosion_slide4
    .db >#explosion_slide3
    .db >#explosion_slide2
    .db >#explosion_slide1
    .db >#explosion_slide0

explosion_anim_lo:
    .db <#explosion_slide0
    .db <#explosion_slide1
    .db <#explosion_slide2
    .db <#explosion_slide3
    .db <#explosion_slide4
    .db <#explosion_slide4
    .db <#explosion_slide3
    .db <#explosion_slide2
    .db <#explosion_slide1
    .db <#explosion_slide0

