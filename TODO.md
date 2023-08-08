# To-do list

## Table of to-do's
- End level routine
- End game routine
- Finetuning/Wishlist

## End level routine
**Summary:** if all color blocks are destroyed, end the current level and load the next one.  
**Elaboration:**
- ~~If the ball touches a color block~~
- ~~Decrease the number of color blocks~~
- ~~If the number of color blocks is zero~~
- ~~Set the game in freeze state~~
- ~~Hide ball~~
- ~~Set null tile color to yellow~~
- Play end level sweep sound effect
- ~~After \* frames, set null tile color to dark blue~~
- ~~After \* frames, initiate bonus score routine (BSR)~~
- ~~\* frames after BSR, initiate blinds routine~~
- ~~After blinds routine~~
- If the current level is the last one
- Initiate end game routine
- ~~Load next level~~
- ~~Unfreeze ball~~

## End game routine
**Summary:** play an end game animation and show game over message  
**Elaboration:**
- Every \* frames
- Rotate the background color palette
- Play a frequency sweep
- After \* frames
- Initiate game over routine

## Finetuning/Wishlist
**Summary:** various minor flaws and fixes, and things that are not required but would be nice to have.
**Elaboration:**
- Add sound effects for move and paint blocks
- Improve timing on blinds effect
- Add a high score system
- Fix move block recoloring flaw
- Fix blank screen during game over sequence

## Reference video
https://www.youtube.com/watch?v=5pBsyOKlrrc
