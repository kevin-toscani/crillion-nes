;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Concept: storing level data
;;
;;
;;  Levels are 14x10 metatiles big. There are 25 levels. That means
;;  that unoptimized level storage would take about 3.5kB of data.
;;  Let's find a way to shave a few bytes off.
;;
;;  There are 21 types of metatiles (called blocks):
;;  - 6 color blocks (Cx*)
;;  - 6 move blocks (Mx*)
;;  - 6 paint blocks (Px*)
;;  - 1 death block (DB*)
;;  - 1 idle block (..)
;;  - 1 wall block (WL)
;;  * x = color number from 0-5
;;
;;  So we would need at least 5 bits to store each block in a tile.
;;  Current train of thought:
;;
;;  - Fill level up with idle blocks, so we don't need to worry about
;;    storing those into the level data.
;;  - Store columns and rows of tiles, instead of single tiles.
;;  - If we're able to overwrite tiles with different ones, we can
;;    save some more data.
;;
;;  Each column/row of tiles takes up two bytes of data, stored as
;;  follows:
;;
;;  #% xxxx yyyy   #% d nn tt ccc
;;     |||| ||||      | || || +++- color of tile (0-5); 7 is wall!
;;     |||| ||||      | || ++----- tile type (0=C/W* 1=M 2=P 3=D)
;;     |||| ||||      | ++-------- number of tiles, minus one
;;     |||| ||||      +----------- direction: row (0) or column (1)
;;     |||| ++++------------------ y-position in grid (0-9)
;;     ++++----------------------- x-position in grid (0-13)
;;
;;  * Wall block if ccc = 7, Color block if not
;;  If the first of those two bytes is #$FF, it indicates the end of
;;  the level.
;;
;;  An example level looks like this:
;;
;;  DB C0 DB C0 DB C0 DB C0 DB C0 DB C0 DB C0
;;  .. C0 .. C0 .. C0 .. C0 .. C0 .. C0 .. C0
;;  .. .. .. C0 .. C0 .. C0 .. C0 .. C0 .. ..
;;  .. C0 .. .. .. C0 .. C0 .. C0 .. .. .. C0
;;  .. C0 .. C0 .. .. .. C0 .. .. .. C0 .. C0
;;  .. C0 .. C0 .. C0 .. .. .. C0 .. C0 .. C0
;;  .. C0 .. C0 .. .. .. C0 .. .. .. C0 .. C0
;;  .. C0 .. .. .. C0 .. C0 .. C0 .. .. .. C0
;;  .. .. .. C0 .. C0 .. C0 .. C0 .. C0 .. ..
;;  .. C0 .. C0 .. C0 .. C0 .. C0 .. C0 .. C0
;;
;;
;;  To store this level, we'd put in the following data:
;;
;;  ; one row of death blocks
;;  .db #$00, #%01111000, #$40, #%01111000, #$80, #%01111000, #$C0, #%00111000
;;  
;;  ; four sets of color blocks at the 2nd grid column
;;  .db #$10, #%10100000, #$13, #%11100000, #$16, #%11000000, #$19, #%00000000
;;
;;  ; three sets of color blocks at the 4th grid column
;;  .db #$30, #%11000000, #$34, #%11000000, #$38, #%10100000
;;
;;  ; also for grid columns 6, 8, 10, 12 and 14
;;  .db #$50, #%11100000, #$55, #%00000000, #$57, #%11000000
;;  .db #$70, #%11100000, #$74, #%00000000, #$76, #%11100000
;;  .db #$90, #%11100000, #$95, #%00000000, #$97, #%11000000
;;  .db #$B0, #%11000000, #$B4, #%11000000, #$B8, #%10100000
;;  .db #$D0, #%10100000, #$D3, #%11100000, #$D6, #%11000000, #$D9, #%00000000
;;
;;  ...which takes up 54 bytes of data for this level, instead of 140.
;;
;;
