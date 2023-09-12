
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; include/zp_ram.asm
;;
;; List of zero-page RAM variables. Currently only holds a
;; variable to keep track of button presses, but will contain
;; more variables that should be accessed often or easily by
;; the game at any time, like temporary variables used by
;; subroutines or macros, game status flags, and the like.
;;
;;

    ;; Sentience (warm boot) check string
    sentience       .dsb 5
    
    ;; High score variables (declared up high, so basic reset
    ;; can skip over those)
    hi_score        .dsb 6
    
    ;; Reserve ten temporary variables for use in subroutines.
    temp              .dsb 10

    ;; Reserve a two-byte temporary variable for use with
    ;; 16-bit operations (like addresses)
    temp16            .dsb 2

    ;; Two-byte variable to store a pointer address
    pointer           .dsb 2

    ;; Variable to store button presses
    buttons_prev      .dsb 1
    buttons_held      .dsb 1
    buttons_pressed   .dsb 1
    buttons_released  .dsb 1

    ;; PPU mask buffer variable, used to store the new value of
    ;; the PPU mask outside NMI
    soft_ppu_mask     .dsb 1

    ;; Variables to skip NMI handling
    skip_nmi          .dsb 1
    force_skip_nmi    .dsb 1

    ;; Counters and seeds
    frame_counter     .dsb 1
    random_seed       .dsb 1

    ;; Game specific variables
    .include "game/ram/zp.asm"

