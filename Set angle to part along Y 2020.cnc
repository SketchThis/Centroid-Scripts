;Script will calculate the angle of a a part on the table and adjust the WCS accordingly

IF #50001                         			;Force lookahead to stop processing This will make the program truly wait for operator input.
IF #4201 || #4202 THEN GOTO 1000   			;Force this program to quite out if graphing or searching

#100=4;pause time for on screen messages
#102=0;wait for cycle start
#102=.235;touch off plate thickness

;#140 is the bit diameter
;#141 Y height of angle at bottom left
;#142 x length of angle measurement
;#143 y height of angle at bottom right
;#144 this is the length of the distance y traveled when we were measuring
;#145 rotation angle
#146=2.85 ;plate thickness x
#147=2.85 ;plate thickness y These can be different if you're using a metal square to zero
#148=.5 ;backoff distance

;INPUT "What is the diameter of the bit you're using to probe?" #140
#140=.25 ; sets the bit diameter to.25
n100
INPUT "Which WCS are we going to save the angle and part origin to? 1-7" #105
IF [#105 EQ 1] g54 
IF [#105 EQ 2] g55
IF [#105 EQ 3] g56
IF [#105 EQ 4] g57
IF [#105 EQ 5] g58
IF [#105 EQ 6] g59
IF [#105 EQ 7] g60

#2400=0 ; resets axis angle comp for the active WCS

;------------------------------------------------------------
M225 #100 "Drive the machine to the bottom left side of the part"
M00; wait for cycle start

M225 #100 "Tap the touch off plate to the bit to begin zeroing"
m101/50001 ; this waits for the operator to tap thetouch off plate to the bit to start the routine
g4 p.25; pauses a second

M116 /y P1 F10 ;moves in Y until the touch plate is hit


G91 y-.5 F40 ;moves up a bit so we can hit the switch again in incremental mode
G90 ;goes back to absolute position
#2600=#5022; zeros out Y on tool center to current machine position
#2500=#5021; zeros out x axis current machine position
;------------------------------------------------------------
M225 #100 "Drive the machine to the bottom right side of the part"
M00; wait for cycle start

M225 #100 "Tap the touch off plate to the bit to begin zeroing"
m101/50001 ; this waits for the operator to tap thetouch off plate to the bit to start the routine
g4 p.25; pauses a second
M116 /Y P1 F10 ;moves in Y until the touch plate is hit


;------------------------------------------------------------
;Lets figure out the angle
G91 y-.5 F40 ;moves up a bit so we can hit the switch again in incremental mode
G90 ;goes back to absolute position
g4 p.25; pauses a second
#145=(ATAN(#5042/#5041))

m225 #100 "Angle is %f" #145
#2400=#145 ; sets the axis angle

g4 p2; pauses for 2 seconds


N1000 m30;ends the program
