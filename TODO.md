# To-do list

## Table of to-do's
- End level routine
- Bonus score routine
- End game routine
- Finetuning/Wishlist

## End level routine
**Summary:** if all color blocks are destroyed, end the current level and load the next one.  
**Elaboration:**
- ~~If the ball touches a color block~~
- ~~Decrease the number of color blocks~~
- ~~If the number of color blocks is zero~~
- ~~Set the game in freeze state~~
- Hide ball
- ~~Set null tile color to yellow~~
- Meanwhile, play end level sweep sound effect
- ~~After \* frames, set null tile color to dark blue~~
- After \* frames, initiate bonus score routine (BSR)
- ~~\* frames after BSR, initiate blinds routine~~
- ~~After blinds routine~~
- If the current level is the last one
- Initiate end game routine
- ~~Load next level~~
- ~~Unfreeze ball~~

## Bonus score routine
**Summary:** convert the bonus timer value to the player's score  
**Elaboration:**
- Every \* frames
- Subtract one from bonus timer
- Add 10? to game score
- Play a random frequency beep
- If bonus timer is zero
- Return to end level routine

## End game routine
**Summary:** play an end game animation and show game over message  
**Elaboration:**
- Every \* frames
- Rotate the background color palette
- Play a frequency sweep
- After \* frames
- Initiate game over routine

## Level design updates
- Fix level 11 (unbeatable)
- Fix level 15 (too hard)

## Finetuning/Wishlist
**Summary:** various minor flaws and fixes, and things that are not required but would be nice to have.  
**Elaboration:**
- Improve timing on blinds effect
- Add a high score system
- Pause ball before each level start
- Fix move block recoloring flaw
- Move animation loader to subroutine and call it within sub_WaitXFrames to ensure animations to finish before level end
- Fix blank screen during game over sequence

## Reference video
https://www.youtube.com/watch?v=5pBsyOKlrrc
