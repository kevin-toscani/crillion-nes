lvl_layout_1:
    .db #LEVEL_END

lvl_layout_2:
    .db #LEVEL_END

lvl_layout_3:
    ; one row of death blocks
    .db #$00, #%01111000, #$40, #%01111000, #$80, #%01111000, #$C0, #%00111000

    ; four sets of color blocks at the 2nd grid column
    .db #$10, #%10100000, #$13, #%11100000, #$16, #%11000000, #$19, #%00000000

    ; three sets of color blocks at the 4th grid column
    .db #$30, #%11000000, #$34, #%11000000, #$38, #%10100000

    ; also for grid columns 6, 8, 10, 12 and 14
    .db #$50, #%11100000, #$55, #%00000000, #$57, #%11000000
    .db #$70, #%11100000, #$74, #%00000000, #$76, #%11100000
    .db #$90, #%11100000, #$95, #%00000000, #$97, #%11000000
    .db #$B0, #%11000000, #$B4, #%11000000, #$B8, #%10100000
    .db #$D0, #%10100000, #$D3, #%11100000, #$D6, #%11000000, #$D9, #%00000000
    
    ;; end of level
    .db #LEVEL_END

lvl_layout_4:
    .db #LEVEL_END

lvl_layout_5:
    .db #LEVEL_END

;; Level layout address pointers
tbl_lvl_layout_hi:
    .db >#lvl_layout_1, >#lvl_layout_2, >#lvl_layout_3, >#lvl_layout_4, >#lvl_layout_5

tbl_lvl_layout_lo:
    .db <#lvl_layout_1, <#lvl_layout_2, <#lvl_layout_3, <#lvl_layout_4, <#lvl_layout_5

