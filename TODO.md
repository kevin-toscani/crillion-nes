# To-do list

## Table of to-do's
- Kill block
- Move block
- ~~Bonus counter~~
- End level routine
- Bonus score routine
- End game routine
- Game over routine
- Finetuning

## Kill block
**Summary:** if ball touches kill block, kill ball.  
**Elaboration:**
- If the ball collides with the kill block:
- Set ball in "killed" state
- Play explosion animation
- After \* frames, decrease the lives counter
- If lives = 0, initiate game over routine
- If lives > 0, restart the current level

## Move block
**Summary:** if the ball touches a move block with the same color, and the move block has room to move in the pushed direction, move the block one spot in that direction.  
**Elaboration:**
- If the ball collides with the move block
- Ricochet the ball off the move block
- If the ball has the same color as the move block
- Check the spot on the other side of the move block. If that spot is empty
- Replace the move block with null tiles
- Create a metasprite in the move block's position
- Move the metasprite in the pushed direction
- If the metasprite is in the desired spot
- Draw move block and shade tiles in the new spot

## ~~Bonus counter~~
~~**Summary:** decrease the bonus counter over time until it reaches zero~~  
~~**Elaboration:**~~
- ~~Every 6 frames~~
- ~~If **not** all bonus timer digits are 0~~
- ~~Subtract one from the lowest bonus timer digit (LBD)~~
- ~~If LBD < 0, set to 9 and subtract one from the middle bonus timer digit (MBD)~~
- ~~If MBD < 0, set to 9 and subtract one from the highest bonus timer digit~~
- ~~Update bonus score to PPU buffer~~

## End level routine
**Summary:** if all color blocks are destroyed, end the current level and load the next one.  
**Elaboration:**
- If the ball touches a color block
- Decrease the number of color blocks
- If the number of color blocks is zero
- Set the game in freeze state
- Set null tile color to yellow
- Play the end level sweep sound effect
- After \* frames, set null tile color to dark blue
- After \* frames, initiate bonus score routine (BSR)
- \* frames after BSR, initiate blinds routine
- After blinds routine
- If the current level is the last one
- Initiate end game routine
- Load next level
- Unfreeze ball

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

## Game over routine
**Summary:** show game over message and reset game on button press  
**Elaboration:**
- Draw GAME OVER tiles over game screen
- If player score is larger than high score
- Overwrite high score with player score
- If player presses either A or START
- Initiate start screen routine (no hard reset as that resets the high score as well)

## Finetuning
**Summary:** various minor flaws and fixes
**Elaboration:**
- Improve timing on blinds effect
