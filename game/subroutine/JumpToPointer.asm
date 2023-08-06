
;; Helper subroutine to JSR to a variable pointer address
sub_JumpToPointer:
    JMP (pointer)
    ;RTS must be handled by the routine (pointer) jumps to

