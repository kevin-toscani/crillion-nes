
;; Level layout tables
;; (see ext_assets/LevelDesign.xlsx for more info)

ifdef TESTING
lvl_test:
    .db #$64, #%01000001, #$74, #%00000111, #$11, #%00010001, #$C1, #%00010011
    .db #$18, #%00011010, #$C8, #%00001011, #$13, #%11100111, #$58, #%01100111
    .db #LEVEL_END
endif

lvl_layout_01:
    .db #$61, #%00100001
    .db #$52, #%01100001
    .db #$43, #%01100101
    .db #$83, #%00000101
    .db #$93, #%00010101
    .db #$34, #%01111010
    .db #$74, #%01111010
    .db #$35, #%01111010
    .db #$75, #%01111010
    .db #$46, #%01100101
    .db #$86, #%00100101
    .db #$57, #%01100001
    .db #$68, #%00100001
    .db #LEVEL_END

lvl_layout_02:
    .db #$C0, #%00001010
    .db #$11, #%00010101
    .db #$21, #%01100010
    .db #$61, #%01100010
    .db #$A1, #%01000010
    .db #$12, #%01100111
    .db #$52, #%01100111
    .db #$92, #%01100111
    .db #$C3, #%00001101
    .db #$14, #%00010001
    .db #$24, #%01100101
    .db #$64, #%01100101
    .db #$A4, #%01000101
    .db #$15, #%01100111
    .db #$55, #%01100111
    .db #$95, #%01100111
    .db #$17, #%00010010
    .db #$27, #%01100001
    .db #$67, #%01100001
    .db #$A7, #%01000001
    .db #$38, #%01111010
    .db #$98, #%01011010
    .db #$18, #%00100111
    .db #$48, #%00100111
    .db #$78, #%00100111
    .db #$C8, #%00000111
    .db #LEVEL_END

lvl_layout_03:
    .db #$00, #%01111010
    .db #$40, #%01111010
    .db #$80, #%01111010
    .db #$C0, #%00011010
    .db #$10, #%10100001
    .db #$13, #%11100001
    .db #$17, #%11000001
    .db #$30, #%11000001
    .db #$34, #%11000001
    .db #$38, #%10100001
    .db #$50, #%11100001
    .db #$55, #%10000001
    .db #$57, #%11000001
    .db #$70, #%11000001
    .db #$73, #%10100001
    .db #$76, #%11100001
    .db #$90, #%11100001
    .db #$95, #%10000001
    .db #$97, #%11000001
    .db #$B0, #%11000001
    .db #$B4, #%11000001
    .db #$B8, #%10100001
    .db #$D0, #%10100001
    .db #$D3, #%11100001
    .db #$D7, #%11000001
    .db #LEVEL_END

lvl_layout_04:
    .db #$00, #%01001100
    .db #$40, #%01101100
    .db #$80, #%01001100
    .db #$81, #%10101100
    .db #$C1, #%00101100
    .db #$02, #%01101100
    .db #$42, #%11001100
    .db #$62, #%11101100
    .db #$A2, #%11001100
    .db #$C3, #%11001100
    .db #$04, #%01001100
    .db #$84, #%00101100
    .db #$25, #%10101100
    .db #$85, #%10101100
    .db #$06, #%10101100
    .db #$36, #%11001100
    .db #$56, #%11001100
    .db #$66, #%11101100
    .db #$96, #%01101100
    .db #$C7, #%10101100
    .db #$08, #%00101100
    .db #$78, #%01101100
    .db #$D8, #%00001100
    .db #$30, #%10100001
    .db #$B0, #%00100001
    .db #$01, #%01000001
    .db #$41, #%01100001
    .db #$91, #%10100001
    .db #$A1, #%00100001
    .db #$52, #%11000001
    .db #$72, #%11100001
    .db #$B2, #%11000001
    .db #$C2, #%00100001
    .db #$03, #%01000001
    .db #$33, #%11000001
    .db #$83, #%00100001
    .db #$D3, #%11100001
    .db #$05, #%00100001
    .db #$45, #%11100001
    .db #$A5, #%00100001
    .db #$16, #%10100001
    .db #$76, #%10100001
    .db #$27, #%10100001
    .db #$57, #%00100001
    .db #$87, #%01000001
    .db #$B7, #%10100001
    .db #$19, #%00100001
    .db #$39, #%01000001
    .db #$89, #%01000001
    .db #$C9, #%00100001
    .db #$D0, #%00011010
    .db #$55, #%00011010
    .db #$95, #%00011010
    .db #$D7, #%00011010
    .db #$09, #%00011010
    .db #$79, #%00011010
    .db #LEVEL_END

lvl_layout_05:
    .db #$40, #%00001010
    .db #$70, #%00011010
    .db #$B0, #%01000010
    .db #$41, #%10100111
    .db #$B1, #%00100010
    .db #$D1, #%00010101
    .db #$22, #%00001010
    .db #$52, #%00000101
    .db #$B2, #%01000010
    .db #$03, #%00100111
    .db #$33, #%01100111
    .db #$73, #%01100111
    .db #$B3, #%01000111
    .db #$05, #%11100101
    .db #$25, #%10100101
    .db #$35, #%00100101
    .db #$65, #%01000101
    .db #$A5, #%01000101
    .db #$46, #%11100101
    .db #$66, #%11100101
    .db #$86, #%11100101
    .db #$A6, #%11100010
    .db #$C6, #%11100101
    .db #$27, #%00100101
    .db #$77, #%00000101
    .db #$B7, #%00000010
    .db #$09, #%00000101
    .db #$79, #%00000101
    .db #$B9, #%00000010
    .db #LEVEL_END

lvl_layout_06:
    .db #$00, #%00000011
    .db #$20, #%00000011
    .db #$40, #%00000011
    .db #$A0, #%00000011
    .db #$C0, #%00000011
    .db #$11, #%00000011
    .db #$31, #%00000011
    .db #$51, #%00000011
    .db #$91, #%00000011
    .db #$B1, #%00000011
    .db #$D1, #%00000011
    .db #$02, #%00000011
    .db #$22, #%00000011
    .db #$42, #%00000011
    .db #$A2, #%00000011
    .db #$C2, #%00000011
    .db #$13, #%00000011
    .db #$33, #%00000011
    .db #$53, #%00000011
    .db #$93, #%00000011
    .db #$B3, #%00000011
    .db #$D3, #%00000011
    .db #$04, #%00000011
    .db #$24, #%00000011
    .db #$44, #%00000011
    .db #$A4, #%00000011
    .db #$C4, #%00000011
    .db #$15, #%00000011
    .db #$35, #%00000011
    .db #$55, #%00000011
    .db #$95, #%00000011
    .db #$B5, #%00000011
    .db #$D5, #%00000011
    .db #$06, #%00000011
    .db #$26, #%00000011
    .db #$46, #%00000011
    .db #$A6, #%00000011
    .db #$C6, #%00000011
    .db #$17, #%00000011
    .db #$37, #%00000011
    .db #$57, #%00000011
    .db #$97, #%00000011
    .db #$B7, #%00000011
    .db #$D7, #%00000011
    .db #$08, #%00000011
    .db #$28, #%00000011
    .db #$48, #%00000011
    .db #$A8, #%00000011
    .db #$C8, #%00000011
    .db #$19, #%00000011
    .db #$39, #%00000011
    .db #$59, #%00000011
    .db #$99, #%00000011
    .db #$B9, #%00000011
    .db #$D9, #%00000011
    .db #$60, #%01001011
    .db #$71, #%11001011
    .db #$62, #%01001011
    .db #$64, #%01001011
    .db #$75, #%11001011
    .db #$66, #%01001011
    .db #$68, #%01001011
    .db #$79, #%00001011
    .db #$70, #%00000011
    .db #$72, #%00000011
    .db #$74, #%00000011
    .db #$76, #%00000011
    .db #$78, #%00000011
    .db #LEVEL_END

lvl_layout_07:
    .db #$00, #%00010001
    .db #$01, #%11111010
    .db #$12, #%10111010
    .db #$23, #%11011010
    .db #$34, #%11111010
    .db #$05, #%11011010
    .db #$15, #%11111010
    .db #$45, #%10111010
    .db #$56, #%11011010
    .db #$27, #%10111010
    .db #$67, #%11011010
    .db #$38, #%00111010
    .db #$78, #%10111010
    .db #$09, #%00111010
    .db #$39, #%00111010
    .db #$89, #%00011010
    .db #$B0, #%00000001
    .db #$D0, #%00000001
    .db #$A1, #%00000001
    .db #$C1, #%00010001
    .db #$B2, #%00000001
    .db #$D2, #%00000001
    .db #$A3, #%00000001
    .db #$C3, #%00000001
    .db #$B4, #%00000001
    .db #$D4, #%00000001
    .db #$A5, #%00000001
    .db #$C5, #%00000001
    .db #$B6, #%00000001
    .db #$D6, #%00000001
    .db #$A7, #%00000001
    .db #$C7, #%00000001
    .db #LEVEL_END

lvl_layout_08:
    .db #$40, #%10110101
    .db #$31, #%00001101
    .db #$61, #%00010000
    .db #$42, #%11000111
    .db #$52, #%01100111
    .db #$63, #%11000111
    .db #$83, #%11100111
    .db #$05, #%00000111
    .db #$15, #%00111010
    .db #$07, #%01100011
    .db #$27, #%00010011
    .db #$38, #%10100101
    .db #$09, #%00010100
    .db #$19, #%00000101
    .db #$D0, #%11100000
    .db #$C2, #%10100000
    .db #$B3, #%11100000
    .db #$D5, #%11100000
    .db #$C6, #%11100000
    .db #$B0, #%11000100
    .db #$C0, #%10100100
    .db #$D1, #%10100100
    .db #$C4, #%00100100
    .db #$C5, #%00000100
    .db #$B7, #%01000100
    .db #$B8, #%10100100
    .db #$D9, #%00000101
    .db #LEVEL_END

lvl_layout_09:
    .db #$81, #%00000100
    .db #$D1, #%00000100
    .db #$32, #%11000100
    .db #$A2, #%11000100
    .db #$C2, #%00100100
    .db #$13, #%00100100
    .db #$53, #%00000100
    .db #$C3, #%00100111
    .db #$15, #%01101100
    .db #$55, #%01101100
    .db #$95, #%01101100
    .db #$D5, #%00001100
    .db #$27, #%11000111
    .db #$47, #%11000111
    .db #$67, #%11000111
    .db #$87, #%11000111
    .db #$A7, #%11000111
    .db #$C7, #%11000111
    .db #$08, #%00010011
    .db #$28, #%00010101
    .db #$48, #%00010010
    .db #$68, #%00010101
    .db #$88, #%00010001
    .db #$A8, #%00010000
    .db #$C8, #%00010100
    .db #$09, #%00000111
    .db #$19, #%00000011
    .db #$39, #%00000101
    .db #$59, #%00000010
    .db #$79, #%00000101
    .db #$99, #%00000001
    .db #$B9, #%00000000
    .db #$D9, #%00000100
    .db #LEVEL_END

lvl_layout_10:
    .db #$00, #%00000010
    .db #$10, #%11001001
    .db #$50, #%11001001
    .db #$90, #%11001001
    .db #$D0, #%11001001
    .db #$31, #%11001001
    .db #$71, #%11001001
    .db #$B1, #%11001001
    .db #$13, #%11001001
    .db #$53, #%11001001
    .db #$93, #%11001001
    .db #$D3, #%11001001
    .db #$34, #%11001001
    .db #$74, #%11001001
    .db #$B4, #%11001001
    .db #$16, #%11001001
    .db #$56, #%11001001
    .db #$96, #%11001001
    .db #$D6, #%11001001
    .db #$37, #%11001001
    .db #$77, #%11001001
    .db #$B7, #%11001001
    .db #$D8, #%00010010
    .db #LEVEL_END

lvl_layout_11:
    .db #$00, #%01100101
    .db #$40, #%01000101
    .db #$50, #%10100111
    .db #$80, #%00000101
    .db #$90, #%10100111
    .db #$A0, #%01100101
    .db #$01, #%01000011
    .db #$31, #%00100011
    .db #$61, #%10100111
    .db #$81, #%10100111
    .db #$A1, #%01100011
    .db #$02, #%01000100
    .db #$32, #%01000100
    .db #$92, #%00000100
    .db #$A2, #%01100100
    .db #$03, #%01000000
    .db #$33, #%01000000
    .db #$64, #%10000001
    .db #$84, #%10000010
    .db #$93, #%00000000
    .db #$A3, #%01100000
    .db #$04, #%01000001
    .db #$34, #%01000001
    .db #$94, #%00000010
    .db #$A4, #%01100010
    .db #$05, #%01000111
    .db #$35, #%01100111
    .db #$75, #%00001010
    .db #$85, #%01000111
    .db #$B5, #%01000111
    .db #$06, #%11100111
    .db #$16, #%01011010
    .db #$26, #%00010001
    .db #$46, #%00010011
    .db #$56, #%00011010
    .db #$66, #%00010100
    .db #$86, #%00010000
    .db #$96, #%01011010
    .db #$A6, #%00010010
    .db #$C6, #%00010101
    .db #$D6, #%11100111
    .db #LEVEL_END

lvl_layout_12:
    .db #$00, #%00000000
    .db #$50, #%11000000
    .db #$80, #%00000000
    .db #$61, #%00000000
    .db #$22, #%11000000
    .db #$82, #%11100000
    .db #$C2, #%11100000
    .db #$A3, #%00100000
    .db #$C3, #%00010000
    .db #$04, #%00000000
    .db #$54, #%00100000
    .db #$15, #%00001010
    .db #$25, #%11000000
    .db #$55, #%11100000
    .db #$86, #%00100000
    .db #$C6, #%11100000
    .db #$C7, #%10100000
    .db #$88, #%00000000
    .db #$59, #%00000000
    .db #$89, #%00100000
    .db #$D9, #%00011010
    .db #LEVEL_END

lvl_layout_13:
    .db #$10, #%11100000
    .db #$20, #%11100000
    .db #$30, #%11100000
    .db #$40, #%01000000
    .db #$80, #%01100000
    .db #$C0, #%11100000
    .db #$D0, #%11100000
    .db #$41, #%01000000
    .db #$71, #%01100000
    .db #$52, #%01100000
    .db #$A2, #%00100000
    .db #$43, #%01100000
    .db #$83, #%01100000
    .db #$14, #%01110100
    .db #$54, #%01110100
    .db #$94, #%01110100
    .db #$D4, #%00010100
    .db #$15, #%00001101
    .db #$55, #%00001101
    .db #$95, #%00001101
    .db #$D5, #%00001101
    .db #$26, #%00001101
    .db #$46, #%00001101
    .db #$66, #%00001101
    .db #$86, #%00001101
    .db #$A6, #%00001101
    .db #$C6, #%00001101
    .db #$07, #%00010000
    .db #$37, #%00001101
    .db #$77, #%00001101
    .db #$B7, #%00001101
    .db #$28, #%00001101
    .db #$48, #%00001101
    .db #$68, #%00001101
    .db #$88, #%00001101
    .db #$A8, #%00001101
    .db #$C8, #%00001101
    .db #$19, #%00001101
    .db #$59, #%00001101
    .db #$99, #%00001101
    .db #$D9, #%00001101
    .db #LEVEL_END

lvl_layout_14:
    .db #$00, #%01100111
    .db #$40, #%01100111
    .db #$80, #%01100111
    .db #$C0, #%00100111
    .db #$01, #%00100111
    .db #$31, #%11000111
    .db #$51, #%11000111
    .db #$71, #%11000111
    .db #$91, #%11000111
    .db #$B1, #%11000111
    .db #$D1, #%00000111
    .db #$02, #%11100111
    .db #$06, #%11100111
    .db #$13, #%00000111
    .db #$D3, #%00000111
    .db #$15, #%00000111
    .db #$35, #%00000111
    .db #$55, #%00000111
    .db #$75, #%00000111
    .db #$95, #%00000111
    .db #$B5, #%00000111
    .db #$D5, #%00000111
    .db #$17, #%00000111
    .db #$37, #%11000111
    .db #$57, #%11000111
    .db #$77, #%11000111
    .db #$97, #%11000111
    .db #$B7, #%11000111
    .db #$D7, #%00000111
    .db #$19, #%00000111
    .db #$D9, #%00000111
    .db #$22, #%01001100
    .db #$62, #%01001100
    .db #$A2, #%01001100
    .db #$24, #%00001100
    .db #$44, #%00001100
    .db #$64, #%00001100
    .db #$84, #%00001100
    .db #$A4, #%00001100
    .db #$C4, #%00001100
    .db #$26, #%00001100
    .db #$46, #%00001100
    .db #$66, #%00001100
    .db #$86, #%00001100
    .db #$A6, #%00001100
    .db #$C6, #%00001100
    .db #$28, #%01001100
    .db #$68, #%01001100
    .db #$A8, #%01001100
    .db #$32, #%00000100
    .db #$52, #%00000100
    .db #$72, #%00000100
    .db #$92, #%00000100
    .db #$B2, #%00000100
    .db #$38, #%00000100
    .db #$58, #%00000100
    .db #$78, #%00000100
    .db #$98, #%00000100
    .db #$B8, #%00000100
    .db #LEVEL_END

lvl_layout_15:
    .db #$00, #%01111010
    .db #$40, #%01111010
    .db #$80, #%01111010
    .db #$C0, #%00111010
    .db #$61, #%01100100
    .db #$05, #%11100100
    .db #$15, #%01100100
    .db #$55, #%01100100
    .db #$95, #%01100100
    .db #$D5, #%11100100
    .db #$26, #%00000100
    .db #$46, #%01000100
    .db #$76, #%01100100
    .db #$C6, #%00000100
    .db #$17, #%00000100
    .db #$37, #%01100100
    .db #$77, #%01000100
    .db #$B7, #%00000100
    .db #$18, #%01100100
    .db #$58, #%01100100
    .db #$98, #%01100100
    .db #LEVEL_END

lvl_layout_16:
    .db #$10, #%11100001
    .db #$20, #%10011010
    .db #$30, #%11100001
    .db #$40, #%11100001
    .db #$50, #%11100001
    .db #$60, #%11000001
    .db #$70, #%11100001
    .db #$80, #%11100001
    .db #$90, #%11100001
    .db #$A0, #%01100001
    .db #$21, #%11000001
    .db #$A1, #%00011010
    .db #$B1, #%01000001
    .db #$A2, #%11100001
    .db #$B2, #%11100001
    .db #$C2, #%00011010
    .db #$D2, #%11100001
    .db #$63, #%00011010
    .db #$C3, #%11000001
    .db #$14, #%01100001
    .db #$54, #%01100001
    .db #$94, #%11000001
    .db #$15, #%01100001
    .db #$55, #%01000001
    .db #$85, #%00011010
    .db #$16, #%01000001
    .db #$46, #%00011010
    .db #$56, #%01100001
    .db #$A6, #%01100001
    .db #$17, #%01100111
    .db #$57, #%01100111
    .db #$97, #%01100111
    .db #$D7, #%00000111
    .db #$28, #%01000001
    .db #$58, #%01100001
    .db #$A8, #%01000001
    .db #$18, #%00010001
    .db #$38, #%00010001
    .db #$98, #%00010001
    .db #$B8, #%00010001
    .db #$D8, #%00010001
    .db #$59, #%00001001
    .db #LEVEL_END

lvl_layout_17:
    .db #$10, #%11101010
    .db #$20, #%11100010
    .db #$30, #%01100010
    .db #$70, #%00000010
    .db #$80, #%01101010
    .db #$90, #%00100010
    .db #$01, #%10101010
    .db #$31, #%01101010
    .db #$81, #%00101010
    .db #$A1, #%00000010
    .db #$C1, #%00000010
    .db #$D1, #%00001010
    .db #$32, #%11101010
    .db #$42, #%01101010
    .db #$62, #%00000010
    .db #$92, #%01101010
    .db #$D2, #%11100010
    .db #$43, #%00011010
    .db #$53, #%11001010
    .db #$73, #%00000010
    .db #$83, #%01001010
    .db #$B3, #%11001010
    .db #$C3, #%11101010
    .db #$04, #%00001010
    .db #$14, #%10100010
    .db #$24, #%10101010
    .db #$44, #%10101010
    .db #$64, #%01101010
    .db #$65, #%01101010
    .db #$A5, #%10101010
    .db #$06, #%11101010
    .db #$16, #%01100010
    .db #$56, #%01000010
    .db #$86, #%00101010
    .db #$17, #%01000010
    .db #$47, #%00010010
    .db #$57, #%01101010
    .db #$97, #%01001010
    .db #$A7, #%00000010
    .db #$18, #%00000010
    .db #$28, #%00001010
    .db #$38, #%00100010
    .db #$68, #%00101010
    .db #$88, #%01100010
    .db #$C8, #%00001010
    .db #$D8, #%00000010
    .db #$19, #%00101010
    .db #$39, #%00101010
    .db #$69, #%01000010
    .db #$99, #%00101010
    .db #$B9, #%01000010
    .db #LEVEL_END

lvl_layout_18:
    .db #$00, #%00010010
    .db #$40, #%00011010
    .db #$50, #%00010001
    .db #$70, #%00011010
    .db #$80, #%00010000
    .db #$D0, #%00010011
    .db #$01, #%00011010
    .db #$22, #%00010101
    .db #$A2, #%00011010
    .db #$B2, #%00010100
    .db #$03, #%01100111
    .db #$43, #%01100111
    .db #$83, #%01100111
    .db #$24, #%00001001
    .db #$74, #%00001101
    .db #$C4, #%00001010
    .db #$05, #%10100111
    .db #$45, #%00100111
    .db #$95, #%00100111
    .db #$16, #%11000111
    .db #$36, #%01100111
    .db #$86, #%01100111
    .db #$D6, #%00000111
    .db #$07, #%10100011
    .db #$27, #%00100011
    .db #$47, #%11000111
    .db #$57, #%10100000
    .db #$67, #%10100111
    .db #$77, #%00100000
    .db #$97, #%11000111
    .db #$A7, #%10100100
    .db #$B7, #%10100111
    .db #$C7, #%00100100
    .db #$28, #%00001011
    .db #$38, #%10100011
    .db #$78, #%00001000
    .db #$88, #%10100000
    .db #$C8, #%00001100
    .db #$D8, #%10100100
    .db #$09, #%01000011
    .db #$59, #%01000000
    .db #$A9, #%01000100
    .db #LEVEL_END

lvl_layout_19:
    .db #$11, #%10101000
    .db #$21, #%01101000
    .db #$81, #%00101000
    .db #$B1, #%01001000
    .db #$22, #%01001000
    .db #$62, #%01101000
    .db #$B2, #%00101000
    .db #$23, #%00101000
    .db #$83, #%00101000
    .db #$B3, #%00101000
    .db #$04, #%11101000
    .db #$24, #%00001000
    .db #$44, #%00001000
    .db #$64, #%11101000
    .db #$84, #%11101000
    .db #$C4, #%10101000
    .db #$D4, #%11101000
    .db #$15, #%01001000
    .db #$55, #%11001000
    .db #$75, #%11001000
    .db #$A5, #%00001000
    .db #$36, #%00001000
    .db #$B6, #%00001000
    .db #$27, #%01001000
    .db #$97, #%00101000
    .db #$C7, #%00001000
    .db #$09, #%01100001
    .db #$19, #%00010001
    .db #$49, #%01100001
    .db #$89, #%00110001
    .db #$A9, #%01100001
    .db #LEVEL_END

lvl_layout_20:
    .db #$00, #%01100000
    .db #$10, #%00011010
    .db #$40, #%10100111
    .db #$50, #%00100000
    .db #$70, #%00011010
    .db #$80, #%01000000
    .db #$B0, #%00011010
    .db #$C0, #%00100000
    .db #$01, #%01000000
    .db #$31, #%00011010
    .db #$A1, #%01000000
    .db #$D1, #%00011010
    .db #$43, #%01100111
    .db #$83, #%01000111
    .db #$44, #%10100111
    .db #$54, #%00100101
    .db #$94, #%00001000
    .db #$A4, #%10100111
    .db #$55, #%00000101
    .db #$65, #%00001000
    .db #$06, #%00100111
    .db #$36, #%01100111
    .db #$76, #%00101000
    .db #$A6, #%00100111
    .db #$D6, #%00000111
    .db #$A7, #%10100111
    .db #$08, #%01100000
    .db #$09, #%01100000
    .db #$18, #%10100111
    .db #$48, #%10100111
    .db #$58, #%01000111
    .db #$88, #%00100111
    .db #$B8, #%00100000
    .db #$D8, #%00011010
    .db #$59, #%00010101
    .db #$69, #%01100000
    .db #$A9, #%01100000
    .db #LEVEL_END

lvl_layout_21:
    .db #$00, #%00010011
    .db #$10, #%00010001
    .db #$20, #%01100111
    .db #$60, #%01100111
    .db #$A0, #%01000111
    .db #$D0, #%00010101
    .db #$32, #%01100011
    .db #$72, #%00000101
    .db #$82, #%01000011
    .db #$B2, #%01000011
    .db #$33, #%00000011
    .db #$43, #%00101010
    .db #$63, #%01111010
    .db #$73, #%00101010
    .db #$A3, #%01111010
    .db #$34, #%01100011
    .db #$74, #%01100011
    .db #$B4, #%01000011
    .db #$06, #%01100011
    .db #$46, #%01100011
    .db #$86, #%01100011
    .db #$C6, #%11000011
    .db #$07, #%01111010
    .db #$47, #%01111010
    .db #$67, #%00001010
    .db #$87, #%01111010
    .db #$08, #%00010011
    .db #$18, #%01000011
    .db #$48, #%01100011
    .db #$88, #%01100011
    .db #LEVEL_END

lvl_layout_22:
    .db #$00, #%01111010
    .db #$40, #%01111010
    .db #$80, #%01111010
    .db #$C0, #%00111010
    .db #$13, #%01100111
    .db #$83, #%10100111
    .db #$B3, #%00000111
    .db #$14, #%00000111
    .db #$44, #%00000111
    .db #$A4, #%00000111
    .db #$15, #%10100101
    .db #$45, #%10100101
    .db #$85, #%00100101
    .db #$86, #%00000101
    .db #$A6, #%00000101
    .db #$17, #%00010001
    .db #$47, #%10100001
    .db #$87, #%10100001
    .db #$B7, #%10100001
    .db #$18, #%01000001
    .db #$68, #%00000001
    .db #$D8, #%00000001
    .db #LEVEL_END

lvl_layout_23:
    .db #$00, #%01110001
    .db #$40, #%00010001
    .db #$50, #%01000011
    .db #$80, #%11010001
    .db #$90, #%11100011
    .db #$A0, #%01100011
    .db #$01, #%01100011
    .db #$41, #%01100011
    .db #$A1, #%01100011
    .db #$02, #%01100011
    .db #$42, #%01100011
    .db #$62, #%00010001
    .db #$A2, #%01100111
    .db #$04, #%01100011
    .db #$44, #%00100011
    .db #$64, #%11010001
    .db #$74, #%11100011
    .db #$84, #%11110001
    .db #$94, #%11100011
    .db #$A4, #%11000111
    .db #$B4, #%00100011
    .db #$05, #%01100011
    .db #$45, #%00100011
    .db #$06, #%01110001
    .db #$46, #%00010001
    .db #$56, #%11100011
    .db #$D6, #%00000111
    .db #$17, #%11010001
    .db #$27, #%01000011
    .db #$67, #%11010001
    .db #$A7, #%11000111
    .db #$C7, #%10100111
    .db #$D7, #%10110011
    .db #$28, #%01000011
    .db #$78, #%01000011
    .db #$29, #%01000011
    .db #$79, #%01000011
   .db #LEVEL_END

lvl_layout_24:
    .db #$02, #%01100111
    .db #$42, #%01100111
    .db #$82, #%01100111
    .db #$05, #%01100111
    .db #$45, #%01100111
    .db #$85, #%01100111
    .db #$08, #%01100111
    .db #$48, #%01100111
    .db #$88, #%01100111
    .db #$30, #%11100111
    .db #$70, #%11100111
    .db #$B0, #%11100111
    .db #$34, #%11100111
    .db #$74, #%11100111
    .db #$B4, #%11100111
    .db #$20, #%00010011
    .db #$40, #%00010000
    .db #$80, #%00000010
    .db #$41, #%00000101
    .db #$B1, #%00001001
    .db #$02, #%00001001
    .db #$52, #%00001100
    .db #$13, #%00010001
    .db #$33, #%00000100
    .db #$74, #%00001100
    .db #$B4, #%00001000
    .db #$15, #%00001001
    .db #$55, #%00001100
    .db #$95, #%00001100
    .db #$47, #%00000011
    .db #$A7, #%00010010
    .db #$18, #%00010101
    .db #$09, #%00000101
    .db #$19, #%00000011
    .db #LEVEL_END

lvl_layout_25:
    .db #$00, #%00010010
    .db #$10, #%01100011
    .db #$60, #%01100011
    .db #$A0, #%00000111
    .db #$01, #%00010001
    .db #$A1, #%00000010
    .db #$02, #%01100111
    .db #$42, #%00000111
    .db #$62, #%01100111
    .db #$A2, #%11000111
    .db #$03, #%01100001
    .db #$43, #%00000001
    .db #$63, #%01100001
    .db #$A6, #%11100111
    .db #$B6, #%01000111
    .db #$C6, #%00000001
    .db #$B7, #%01000010
    .db #$B8, #%01000010
    .db #$C8, #%00001010
    .db #$09, #%01111010
    .db #$49, #%01111010
    .db #$89, #%00111010
    .db #$B9, #%01000010
    .db #LEVEL_END

;; Level layout address pointers
tbl_lvl_layout_hi:
ifdef TESTING
    .db >#lvl_test
endif
    .db >#lvl_layout_01, >#lvl_layout_02, >#lvl_layout_03, >#lvl_layout_04, >#lvl_layout_05
    .db >#lvl_layout_06, >#lvl_layout_07, >#lvl_layout_08, >#lvl_layout_09, >#lvl_layout_10
    .db >#lvl_layout_11, >#lvl_layout_12, >#lvl_layout_13, >#lvl_layout_14, >#lvl_layout_15
    .db >#lvl_layout_16, >#lvl_layout_17, >#lvl_layout_18, >#lvl_layout_19, >#lvl_layout_20
    .db >#lvl_layout_21, >#lvl_layout_22, >#lvl_layout_23, >#lvl_layout_24, >#lvl_layout_25

tbl_lvl_layout_lo:
ifdef TESTING
    .db <#lvl_test
endif
    .db <#lvl_layout_01, <#lvl_layout_02, <#lvl_layout_03, <#lvl_layout_04, <#lvl_layout_05
    .db <#lvl_layout_06, <#lvl_layout_07, <#lvl_layout_08, <#lvl_layout_09, <#lvl_layout_10
    .db <#lvl_layout_11, <#lvl_layout_12, <#lvl_layout_13, <#lvl_layout_14, <#lvl_layout_15
    .db <#lvl_layout_16, <#lvl_layout_17, <#lvl_layout_18, <#lvl_layout_19, <#lvl_layout_20
    .db <#lvl_layout_21, <#lvl_layout_22, <#lvl_layout_23, <#lvl_layout_24, <#lvl_layout_25

;; Ball start position (#$YX)
tbl_lvl_ball_startpos:
ifdef TESTING
    .db #$29
endif
    .db #$9B, #$10, #$21, #$9B, #$11
    .db #$81, #$89, #$47, #$1C, #$20
    .db #$77, #$20, #$7D, #$6B, #$28
    .db #$9D, #$36, #$1B, #$01, #$59
    .db #$90, #$47, #$9C, #$34, #$18

    
;; Ball start direction, color and tile score
;; #% ccc v tttt
;;    ||| | ++++-- tile score
;;    ||| +------- vertical direction, up (0) or down
;;    +++--------- color (CBRYGM)
tbl_lvl_ball_init:
ifdef TESTING
    .db #%00100000
endif
    .db #%00110000, #%00110000, #%00110000, #%00100000, #%01010000
    .db #%01110000, #%01010000, #%10110000, #%10000000, #%00110000
    .db #%01010000, #%01010000, #%10100000, #%10010000, #%10010000
    .db #%00100000, #%01010000, #%10000000, #%00010000, #%00010000
    .db #%01100000, #%10110000, #%00100000, #%10010000, #%01100000

