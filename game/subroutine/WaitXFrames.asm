
sub_WaitXFrames:
    JSR sub_WaitForNMI
    DEX
    BNE sub_WaitXFrames

    RTS

