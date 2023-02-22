;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CONCEPT: block shades
;;
;;
;;  $0400: tile RAM
;;
;;  the address that corresponds with the metatile at (x,y) is $04YX
;;  the values of tile RAM are stored as follows:
;;
;;  #% b p m d ccc s
;;     | | | | ||| +-- block is solid
;;     | | | | +++---- block color (0-5)
;;     | | | +-------- death block
;;     | | +---------- move block
;;     | +------------ paint block
;;     +-------------- color block
;;
;;
;;  Drawing a tile with shade
;;
;;  TL TR
;;  BL BR sr
;;     sl sb
;;
;;  TL,TR,BL,BR are the four tiles that make up the metatile.
;;  sr,sl,sb is the shade. This is how the shades are drawn:
;;
;;  IF Y=10 SKIP sl,sb
;;  IF X=14 SKIP sr,sb
;;
;;  - IF ($04YX + 1) IS NOT SOLID AND X!=14
;;    - draw sr
;;  - IF ($04XY + $10) IS NOT SOLID AND Y!=10
;;    - draw sl
;;  - IF ($04XY + $11) IS NOT SOLID AND X!=14 AND Y!=10
;;    - draw sb
;;
;;
;;  Correcting shades when destroying a tile
;;  
;;  When a tile get destroyed, its graphic should be replaced by this:
;;
;;  Ba Ba
;;  Bb BG Bc
;;     Bd Be
;;  
;;  BG: random background tile
;;  Ba: if ($04YX - #$10 = solid) then NULL else BG
;;  Bb: if ($04YX - #$01 = solid) then NULL else BG
;;  Bc: if ($04YX + #$01 = solid) then SKIP else BG
;;  Bd: if ($04YX + #$10 = solid) then SKIP else BG
;;  Be: if ($04YX + #$11 = solid) then SKIP else BG
;;
;;
;;
