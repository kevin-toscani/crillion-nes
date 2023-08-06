
;; RNG
.include "subroutine/GetRandomNumber.asm"

;; Read controller input
.include "subroutine/ReadController.asm"

;; vBlank/NMI wait
.include "subroutine/WaitForNMI.asm"
.include "subroutine/WaitForVBlank.asm"

;; Game specific subroutines
.include "game/include/subroutines.asm"

