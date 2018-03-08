## Assignment 5 Description

Has been posted. You have the entire spring break to do it. The assignment is on page 187 to 191. Basic is to do the stuff about the absolute threshold (brightness), which replicates a classic experiment in psychophysics. Ambitious is to either implement the relative threshold experiment outlined at the end of that chapter or do something else entirely - determine the relative threshold of detecting which gabor is oriented to the left or right (clockwise or counterclockwise) of a reference, as a function of the orientation of the reference gabor (vertical, horizontal, oblique). The code you need to do that has been added to the code we wrote together today. 

<span style="color:red">**Note**</span>: Although not explicitly stated in the PDF, you are required to plot the psychometeric curve for the data for both the basic and the ambitious parts of the assignment. 

Specifically (AMBITIOUS): 

I want you to illustrate the oblique effect. The oblique effect refers to the phenomenon that people are best at judging the orientation of lines around the "cardinals": Horizontal and vertical, but bad at doing the same at oblique orientations:

http://en.wikipedia.org/wiki/Oblique_effect

So here is what I want you do to:

1. Have a gabor on the left and a gabor on the right (and a fixation point in the middle). 

2. For any given condition, the orientation of each gabor (the left and right one left and right) should be picked at random, from -5 to 5 degrees) relative to the reference (more on the reference in the next point). I would pick this completely at random from an uniform distribution between -5 and 5 - you can bin it later.

3. I want you to do 4 conditions (each condition corresponds to a difference reference): Condition 1: Vertical (|), Condition 2: Horizontal ( - ), Condition 3: Oblique 45 degrees ( / ), Condition 4: Oblique 135 degrees ( \ ).

4. The observer should judge - on any given trial - whether the gabor on the right is oriented clockwise (by pressing one button) or counterclockwise (by pressing another button) relative to the one on the left.

5. Do at least 50 trials per condition (200 trials total) and note whether each is correct or not.

6. Plot thresholds as a function of condition (bar graph will do). Threshold corresponds to the relative difference in orientation that will yield 75% accuracy. 

7. Make sure to save the workspace. Put the data into a variable "DATA" that contains the 200 trials as rows. As for columns, note the condition (column 1), the relative orientation (to reference) of the left grating in degrees (column 2), the relative orientation (to reference) of the right grating in degrees (column 3), participant response (column 4, counterclockwise key = 0, clockwise key = 1), accuracy (column 5, false = 0, correct = 1). 

So as an example, let's say a given trial is in the vertical condition, the left grating might be pointing 3 degrees off vertical to the left. The right grating might be pointing 2.5 degrees off vertical to the right. So the relative difference between the two gratings would be 5.5 degrees and the correct answer would be "clockwise". In another trial, say in the horizontal condition, the grating on the left might be pointing 1.2 degrees clockwise from horizontal. The grating on the right might be pointing 0.8 degrees clockwise from horizontal, so the relative difference between the two gratings would be -0.4 degrees and the correct answer would be "counterclockwise", but most people wouldn't get that, due to this being a rather small difference. Of course, people have a 50% chance of being correct just by chance.   

I also posted slides and the code for this week. 

This assignment concludes the part of the class that deals with data recording and you should now basically be able to implement/replicate most if not all experiments in cognitive psychology, psychophysics, social psychology, etc. that rely on recording of behavior data (RT, performance, thresholds, etc.).

Please let me know if you have any questions about this.

Good luck,

Pascal