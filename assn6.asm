;=================================================
; 
; Name: Nguyen, Kevin
; Username: knguy092@ucr.edu
;
; SID: 861151221
; Assignment name: <assn 7>
; Lab section: 022
; TA: Jose Rodriguez
;
; I hereby certify that I have not receieved 
; assistance on this assignment, or used code,
; from ANY outside source other than the
; instruction team. 
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
PRINT_MENU

	LD R0, MENU
	JSRR R0				;AFTER THIS SUBROUTINE, R1 SHOULD HOLD THE VALUE OF THE USER INPUT FOR MENU OPTIONS
	
	ADD R1,R1,#-1		;DECREMENT THE VALUE IN R1 TO CHECK WHAT SUBROUTINE TO CHOOSE
	BRz CHOSE_1
	ADD R1,R1,#-1
	BRz CHOSE_2
	ADD R1,R1,#-1
	BRz CHOSE_3
	ADD R1,R1,#-1
	BRz CHOSE_4
	ADD R1,R1,#-1
	BRz CHOSE_5
	ADD R1,R1,#-1
	BRz CHOSE_6
	ADD R1,R1,#-1
	BRz CHOSE_7
	
	
	CHOSE_1				;CALLING THE SUBROUTINES
		LD R0,OPTION1
		JSRR R0
		BR PRINT_MENU	;REPEAT THE PROGRAM WHEN DONE, EXCEPT FOR OPTION 7
	CHOSE_2
		LD R0,OPTION2
		JSRR R0
		BR PRINT_MENU
	CHOSE_3
		LD R0,OPTION3
		JSRR R0
		BR PRINT_MENU
	CHOSE_4
		LD R0,OPTION4
		JSRR R0
		BR PRINT_MENU
	CHOSE_5
		LD R0,OPTION5
		JSRR R0
		BR PRINT_MENU
	CHOSE_6
		LD R0,OPTION6
		JSRR R0
		BR PRINT_MENU
	CHOSE_7
		LEA R0,END_MESSAGE		;GOODBYE MESSAGE
		PUTS
    

HALT
;---------------	
;Data
;---------------
MENU	.FILL	x3200
OPTION1 .FILL 	x3400
OPTION2 .FILL 	x3600
OPTION3 .FILL 	x3800
OPTION4 .FILL 	x4000
OPTION5 .FILL 	x4200
OPTION6 .FILL 	x4400
END_MESSAGE		.STRINGZ	"7\nGoodbye!\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
.orig x3200
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
ST R7, BACKUP_R7_3200

PRINT_MENU_3200
LD R1, Menu_string_addr	;STORE PRINT ADDRESS INTO R1
PRINT_LOOP
	LDR R0, R1, #0		;LOAD INTO R0 AND PRINT OUT
	OUT
	ADD R1, R1, #1		;INCREMENT R1 AKA THE MEMORY LOCATION OF THE STRING
	ADD R0, R0, #0
	BRz DONE_PRINTING
	BR PRINT_LOOP
	
DONE_PRINTING
	GETC					;GET USER INPUT
	ADD R1, R0, #0			;TRANSFER USER INPUT INTO R1
	LD R2, UPPER_BOUND		;TRANSFER UPPER BOUND LIMIT TO R2
	ADD R2, R2, R1			;CHECK THE BOUNDS FOR VALID INPUT
	BRp ERROR_MESSAGE
	ADD R1, R0, #0			;RESET R1 TO CHECK LOWER BOUND
	LD R2, LOWER_BOUND
	ADD R2, R2, R1			;CHECK LOWER BOUNDS NOW
	BRn ERROR_MESSAGE
	LD R2, CONVERT			;STORE ASCII CONVERT INTO R2
	ADD R1, R0, R2			;CONVERT THE VALUE IN R1 TO A DECIMAL VALUE
	BR FINISH_3200
	
ERROR_MESSAGE
	LEA R0, Error_message_1
	PUTS
	BR PRINT_MENU_3200
	

FINISH_3200
;LD R0, NEWLINE
;OUT
LD R7, BACKUP_R7_3200
RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
BACKUP_R7_3200	.BLKW	#1
Error_message_1 .STRINGZ "INVALID INPUT\n"
Menu_string_addr .FILL x6000
CONVERT			.FILL	#-48
UPPER_BOUND		.FILL	#-55
LOWER_BOUND		.FILL	#-49
NEWLINE			.FILL	#10
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.orig x3400
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R7, BACKUP_R7_3400

LD R3, DATA_PTR_3400
LDR R3, R3, #0
BRz BUSY
LEA R0, NOT_ALL_BUSY
PUTS
AND R2, R2, #0		;STORE 0 INTO R2
BR FINISH_3400

BUSY
	LEA R0, ALL_BUSY
	PUTS
	AND R2, R2, #0
	ADD R2, R2, #1	;STORE 1 INTO R2


FINISH_3400
LD R7, BACKUP_R7_3400
RET
;Data
DATA_PTR_3400	.FILL	x5000	
BACKUP_R7_3400	.BLKW	#1
ALL_BUSY		.STRINGZ	"1\nAll machines are busy\n"
NOT_ALL_BUSY	.STRINGZ	"1\nNot all machines are busy\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.orig x3600
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
ST R7, BACKUP_R7_3600

LD R3, DATA_PTR_3600
LDR R3, R3, #0
BRz NOT_FREE
LEA R0, FREE_MESG
PUTS
AND R2, R2, #0		;STORE 1 INTO R2
ADD R2, R2, #1
BR FINISH_3600

NOT_FREE
	LEA R0, NOT_FREE_MESG
	PUTS
	AND R2, R2, #0	;STORE 0 INTO R2
	
FINISH_3600	

LD R7, BACKUP_R7_3600
RET
;Data
BACKUP_R7_3600	.BLKW	#1
DATA_PTR_3600	.FILL	x5000
FREE_MESG		.STRINGZ	"2\nALL of the machines are free\n"
NOT_FREE_MESG	.STRINGZ	"2\nNot all of the machines are free\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
.orig x3800
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
ST R7, BACKUP_R7_3800

AND R1, R1, #0
ADD R1, R1, #1			;R1 WILL HOLD #1 FOR THE MASKING
AND R2, R2, #0
LD R6, BIT_COUNTER
LD R3, DATA_PTR_3800
LDR R3, R3, #0			;LOAD FIRST MEMORY LOCATION INTO R3

LOOP_3800
	AND R4, R3, R1		;AND IT WITH ONE TO SEE IF IT ZERO OR 1
	BRz ZERO_BIT 		;IF IT IS ZERO, DO NOTHING AND JUST DECREMENT STUFF
	ADD R2, R2, #1		;IF NOT ZERO THEN INCREMENT R2, R2 WILL HOLD FREE MACHINES
	ADD R1, R1, R1		;IF ONE THEN INCREMENT THE MASK
	ADD R6, R6, #-1		;DECREMENT BIT COUNTER
	BRp LOOP_3800
	BR FINISH_3800
	
	
ZERO_BIT
	ADD R1, R1, R1		;INCREMENT THE MASK
	ADD R6, R6, #-1		;DECREMENT THE 16 BIT COUNTER
	BRnp LOOP_3800
	
FINISH_3800
NOT R2, R2				;MAKE IT NEGATIVE
ADD R2, R2, #1		
LD R3, BIT_COUNTER	
ADD R2, R2, R3			;ADD 16 TO THIS NEGATIVE NUMBER TO FIND NUMBER OF BUSY MACHINES
						;R2 NOW HOLDS NUMBER OF BUSY MACHINES
AND R1, R1, #0
ADD R1, R2, #0			;TRANSFER THIS INTO R1 AND CALL THE SUBROUTINE FOR PRINTING NUMBERS
;LD R4, CONVERT_3800
;ADD R1, R1, R4			;CONVERT R1 INTO DECIMAL

LEA R0, FIRST_HALF_MSG
PUTS

LD R0, PRINT_PTR
JSRR R0

LEA R0, SECOND_HALF
PUTS


LD R7, BACKUP_R7_3800
RET
;Data
BACKUP_R7_3800	.BLKW	#1
DATA_PTR_3800	.FILL	x5000
COUNTER			.FILL	#0
BIT_COUNTER		.FILL	#16
PRINT_PTR		.FILL	x4800
CONVERT_3800	.FILL	#-48
FIRST_HALF_MSG	.STRINGZ	"3\nThere are "
SECOND_HALF		.STRINGZ	" busy machines!\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
.orig x4000
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
ST R7, BACKUP_R7_4000
						;THIS SUBROUTINE IS EXACTLY LIKE THE ONE ABOVE,
						;EXCEPT IT DOESN'T NEED TO SUBTRACT R2 FROM 16

AND R1, R1, #0
ADD R1, R1, #1			;R1 WILL HOLD #1 FOR THE MASKING
AND R2, R2, #0
LD R6, BIT_COUNTER_4000
LD R3, DATA_PTR_4000
LDR R3, R3, #0			;LOAD FIRST MEMORY LOCATION INTO R3

LOOP_4000
	AND R4, R3, R1		;AND IT WITH ONE TO SEE IF IT ZERO OR 1
	BRz ZERO_BIT_4000 		;IF IT IS ZERO, DO NOTHING AND JUST DECREMENT STUFF
	ADD R2, R2, #1		;IF NOT ZERO THEN INCREMENT R2, R2 WILL HOLD FREE MACHINES
	ADD R1, R1, R1		;IF ONE THEN INCREMENT THE MASK
	ADD R6, R6, #-1		;DECREMENT BIT COUNTER
	BRp LOOP_4000
	BR FINISH_4000
	
	
ZERO_BIT_4000
	ADD R1, R1, R1		;INCREMENT THE MASK
	ADD R6, R6, #-1		;DECREMENT THE 16 BIT COUNTER
	BRnp LOOP_4000
	
FINISH_4000

AND R1, R1, #0
ADD R1, R2, #0			;TRANSFER THIS INTO R1 AND CALL THE SUBROUTINE FOR PRINTING NUMBERS
;LD R4, CONVERT_3800
;ADD R1, R1, R4			;CONVERT R1 INTO DECIMAL

LEA R0, FIRST_HALF_4000
PUTS

LD R0, PRINT_PTR_4000
JSRR R0

LEA R0, SECOND_HALF_4000
PUTS

LD R7, BACKUP_R7_4000
RET
;Data
BACKUP_R7_4000	.BLKW	#1
DATA_PTR_4000		.FILL	x5000
BIT_COUNTER_4000	.FILL	#16
PRINT_PTR_4000		.FILL	x4800
FIRST_HALF_4000	.STRINGZ	"4\nThere are "
SECOND_HALF_4000	.STRINGZ	" free machines!\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
.orig x4200
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
ST R7, BACKUP_R7_4200

LEA R0, NUMBER
PUTS

LD R0, INPUT_PTR
JSRR R0

LEA R0, FIRST_HALF_4200
PUTS

LD R0, PRINT_PTR_4200
JSRR R0

ADD R5, R1, #0			;TRANSFER USERINPUT INTO R5
LD R3, LEFT_SHIFT_BIT
SHIFT
	ADD R5, R5, #0
	BRz END_SHIFT		;DECREMENTING WHATS IN R5 TO ZERO
	ADD R3, R3, R3		;IF NOT ZERO, THEN KEEP LEFT SHIFTING X0001 UNTIL REACHING DESIRED BIT POSITION TO MASK LATER
	ADD R5, R5, #-1
	BR SHIFT
	
END_SHIFT				;R3 SHOULD NOW HOLD THE CORRECT BIT MASK TO CHECK THE MACHINE
	LD R4, DATA_PTR_4200
	LDR R4, R4, #0
	AND R6, R4, R3		;NOW MASK THE BIT
	BRz BUSY_4200		;IF ZERO THEN THE BIT WAS ZERO AND THEREFORE BUSY
	BR FREE_4200
	
BUSY_4200
	AND R2, R2, #0		;SINCE MACHINE IS BUSY THEN MAKE R2 ZERO
	LEA R0, SECOND_HALF_4200_1
	PUTS
	BR FINISH_4200
	
FREE_4200
	AND R2, R2, #0
	ADD R2, R2, #1
	LEA R0, SECOND_HALF_4200_2
	PUTS
	
FINISH_4200
LD R7, BACKUP_R7_4200
RET
;Data
BACKUP_R7_4200	.BLKW	#1
INPUT_PTR		.FILL	x4600
PRINT_PTR_4200	.FILL	x4800
DATA_PTR_4200	.FILL	x5000
FIRST_HALF_4200	.STRINGZ	"Machine "	
SECOND_HALF_4200_1	.STRINGZ	" is busy\n"
SECOND_HALF_4200_2	.STRINGZ	" is free\n"
NUMBER			.STRINGZ	"5\n"
LEFT_SHIFT_BIT	.FILL	x0001
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
.orig x4400
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
ST R7, BACKUP_R7_4400

AND R2, R2, #0				;RESET R2 TO ZERO
LD R1, SIXTEEN				;FILL R1 WITH THE 16 BIT COUNTER
LD R3, LEFTSHIFT_4400		;FILL R3 WITH X0001
LD R4, DATA_PTR_4400		
LDR R4, R4, #0

SHIFT_4400
	AND R5, R4, R3			;CHECKS IF FIRST BIT IS A ONE
	BRp	FINISH_44			;IF A ONE IS FOUND, THEN FINISH
	ADD R3, R3, R3			;IF NOT THEN LEFT SHIFT THE COUNTER
	ADD R2, R2, #1			;INCREMENT THE POSITION OF THE FREE MACHINE
	ADD R1, R1, #-1			;DECREMENT THE 16BIT COUNTER
	BRz FINISH_44			;WHEN ZERO FINISH THE LOOP
	BR SHIFT_4400			
	
FINISH_44
	ADD R1, R1, #0			;CHECK TO SEE WHAT R1 HOLDS
	BRp FREE_PRINT			;IF R1 IS POSITIVE, THEN PROCEED TO CHECK THE MACHINE NUMBER
	LEA R0, NO_FREE			;IF NOT, THEN NO MACHINES WERE FREE
	PUTS
	BR DONE_4400
	
FREE_PRINT
	LEA R0, FREE		
	PUTS
	AND R1, R1, #0
	ADD R1, R2, #0			;TRANSFER R2 INTO R1 FOR PRINTING
	LD R4, CONVERT_4400
	ADD R1, R1, R4
	LD R0, PRINT_PTR_4400
	JSRR R0
	LD R0, NEWLINE_4400
	OUT

	
	
DONE_4400
LD R7, BACKUP_R7_4400
RET
;Data
BACKUP_R7_4400	.BLKW	#1
SIXTEEN			.FILL	#16
LEFTSHIFT_4400	.FILL	x0001
DATA_PTR_4400	.FILL	x5000	
FREE			.STRINGZ	"6\nThe first available machine is "
NO_FREE		.STRINGZ	"6\nNo machines are free\n"
NEWLINE_4400	.FILL	'\n'
PRINT_PTR_4400	.FILL	x4800
NEWLINE_4400	.FILL	'\n'
CONVERT_4400	.FILL	#-48
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
.orig x4600
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R7, BACKUP_R7_4600


INTRO
	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	AND R6, R6, #0
	ST R0, R10
	
	;TO Output Intro Message
	LEA R0, prompt  ; Output Intro Message
	PUTS
	LD R5, TEN_COUNTER

INPUT

	GETC				;GET USER INPUT
	LD R2, ENTER		;CHECK IF USER ONLY INPUT ENTER FIRST
	ADD R2, R2, R0
	BRz ERROR
	OUT					;OUTPUT TO SCREEN IF NOT ENTER

	LD R2, MINUS		;CHECK IF USER INPUT MINUS, IF MINUS THEN FLAG THAT IT IS FOR LATER
	ADD R2, R0, R2
	BRz FLAG

	LD R2, PLUS			;CHECK IF THE USER INPUTS A PLUS, IF SO THEN IGNORE AND PROCEED TO LOOP
	ADD R2, R0, R2
	BRp LOOP

	ST R0, STORE
	
	LD R2, MINUS				;STORE #-45 INTO R2
	ADD R2, R2, R0
	BRz PRE_LOOP				;CHECK IF MINUS, THEN GET NEXT INPUT

	LD R2, PLUS					;STORE #-43 INTO R2
	ADD R2, R0, R2
	BRz PRE_LOOP				;CHECK IF IT IS PLUS, THEN GET NEXT INPUT


	LD R2, ENTER		;OUTPUTS ERROR IF USER ENTERS ONE SIGN AND THEN PRESSES ENTER
	ADD R2, R2, R0
	BRz ERROR

	LD R2, UPPER_LIMIT_4600	;CHECKS IF INPUT IS A VALID 1-9 DECIMAL
	ADD R2, R0, R2
	BRp ERROR
	
	LD R2, LOWER_LIMIT_4600	;CHECKS IF INPUT IS VALID 1-9 DECIMAL
	ADD R2, R0, R2
	BRn ERROR
	
	BR PRE_LOOP

FLAG
	LD R4, R10		;FLAG FOR LATER USE TO CHECK IF NUMBER IS NEG OR NOT
	ADD R4, R4, #1
	ST R4, R10
	BR PRE_LOOP
	
PRE_LOOP
	GETC
	;LD R2, ENTER
	;ADD R2, R0, R2
	;BRz LOOP
	OUT
	
	LD R2, MINUS				;STORE #-45 INTO R2
	ADD R2, R2, R0
	BRz ERROR				;CHECK IF MINUS, THEN GET NEXT INPUT

	LD R2, PLUS					;STORE #-43 INTO R2
	ADD R2, R0, R2
	BRz ERROR				;CHECK IF IT IS PLUS, THEN GET NEXT INPUT
	
	
LOOP
	;LD R1, RESET_ZERO
	ADD R1, R0, #0	;STORE INPUT IN R1
	ADD R4, R1, #0	; ALSO STORE INPUT IN R4
	
	LD R2, ENTER
	ADD R4, R2, R4	;CHECKS IF INPUT IS AN ENTER
	BRz FINISH_LOOP	;IF SO THEN END THE LOOP BEFORE MULTIPLYING STEP
	
	ST R0, STORE
	
	LD R2, UPPER_LIMIT_4600	;CHECKS IF INPUT IS A VALID 1-9 DECIMAL
	ADD R2, R0, R2
	BRp ERROR
	
	LD R2, LOWER_LIMIT_4600	;CHECKS IF INPUT IS VALID 1-9 DECIMAL
	ADD R2, R0, R2
	BRn ERROR
	
	ADD R3, R0, R3	;TRANSFERS INPUT INTO R3
	LD R4, CONVERT_4600
	ADD R3, R4, R3	;CONVERTS R3 INTO A DECIMAL
	ST R4, CONVERT_4600
	
	ADD R6, R3, #0
	
	TEN_MULT
		ADD R3, R3, R6
		ADD R5, R5, #-1
		BRp TEN_MULT
	LD R5, TEN_COUNTER
	BR PRE_LOOP
		
	
	
FINISH_LOOP
	ADD R1, R6, #0
	LD R0, STORE
	
	LD R4, R10		;IF NEG IS SET TO FLAG 1, THEN -1 WILL MAKE IT ZERO
	ADD R4, R4, #-1
	BRz MAKE_NEGATIVE
	BR DONE
	

MAKE_NEGATIVE
	NOT R1, R1
	ADD R1, R1, #1
	
BR DONE


ERROR

	LD R0, NEWLINE_4600
	OUT
	;TO Output Error Message
	LEA R0, Error_message_2  ; Output Error Message
	PUTS

	BR INTRO
	
DONE

;LD R0, NEWLINE
;OUT


;HINT Restore your registers
LD R0, BACKUP_R0
LD R2, BACKUP_R2
LD R3, BACKUP_R3
LD R4, BACKUP_R4
LD R5, BACKUP_R5
LD R6, BACKUP_R6

LD R7, BACKUP_R7_4600
RET

;--------------------------------
;Data for subroutine Get input
;--------------------------------
BACKUP_R7_4600	.BLKW	#1
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"
BACKUP_R0	.BLKW	#1
BACKUP_R1	.BLKW	#1
BACKUP_R2	.BLKW	#1
BACKUP_R3	.BLKW	#1
BACKUP_R4	.BLKW	#1
BACKUP_R5	.BLKW	#1
BACKUP_R6	.BLKW	#1
BACKUP_R7	.BLKW	#1
ENTER			.FILL	#-10
RESET_ZERO		.FILL	#0
MINUS			.FILL	#-45
PLUS			.FILL	#-43
R10				.FILL 	#0
STORE 			.FILL	#0
NEWLINE_4600			.FILL	'\n'
UPPER_LIMIT_4600     .FILL 	#-58
LOWER_LIMIT_4600	    .FILL 	#-48
CONVERT_4600			.FILL 	#-48
TEN_COUNTER		.FILL 	#9
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to print the number to the user WITHOUT leading 0's and DOES NOT output the '+' 
;	for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
.orig x4800
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R1, BACKUP_R1_4800
ST R7, BACKUP_R7_4800


LD R0,DEC_10000
AND R3,R3,#0

LD R0, DEC_10000
ADD R1, R1, R0
BRzp NEXT0


LD R1, BACKUP_R1_2
LD R0, DEC_1000
ADD R1, R1, R0
BRzp NEXT

LD R1, BACKUP_R1_2
LD R0, DEC_100
ADD R1, R1, R0
BRzp NEXT1

LD R1, BACKUP_R1_2
LD R0, DEC_10
ADD R1, R1, R0
BRzp NEXT2

LD R1, BACKUP_R1_2
LD R0, DEC_1
ADD R1, R1, R0
BRzp NEXT3

LD R1, BACKUP_R1_2
LD R0, ZERO_2
ADD R1, R1, R0
BRz ZERO_END


NEXT0
ADD R3, R3, #1
DECR_10000              
    ADD R2,R1,#0        ;STORES R1 INTO R2
    ADD R2,R2,R0        ;ADD R2 BY -10000
    BRn DONE_10000      ;IF NEGATIVE THEN GO TO DONE LOOP
    ADD R3,R3,#1        
    ADD R1,R2,#0
    BR DECR_10000
DONE_10000
    LD R4, ASCII_TOCHAR ;LOAD R4 WITH 48 TO CONVERT FROM ASCII TO DECIMAL
    ADD R0,R3,R4        
    OUT
    AND R3, R3, #0
    BR NEXT_1

NEXT
ADD R3, R3, #1
NEXT_1
    LD R0,DEC_1000
    DECR_1000
        ADD R2,R1,#0
        ADD R2,R2,R0
        BRn DONE_1000
        ADD R3,R3,#1
        ADD R1,R2,#0
        BR DECR_1000
    DONE_1000
        LD R4, ASCII_TOCHAR
        ADD R0,R3,R4
        OUT
        AND R3, R3, #0
        BR NEXT1_1

NEXT1
ADD R3, R3, #1
NEXT1_1
    LD R0,DEC_100
    DECR_100
        ADD R2,R1,#0
        ADD R2,R2,R0
        BRn DONE_100
        ADD R3,R3,#1
        ADD R1,R2,#0
        BR DECR_100
    DONE_100
        LD R4, ASCII_TOCHAR
        ADD R0,R3,R4
        OUT
        AND R3, R3, #0
        BR NEXT2_1
NEXT2
ADD R3, R3, #1
NEXT2_1
    LD R0,DEC_10
    DECR_10
        ADD R2,R1,#0
        ADD R2,R2,R0
        BRn DONE_10
        ADD R3,R3,#1
        ADD R1,R2,#0
        BR DECR_10
    DONE_10
        LD R4, ASCII_TOCHAR
        ADD R0,R3,R4
        OUT
        AND R3, R3, #0
        BR NEXT3_2
    
    
NEXT3 
ADD R3, R3, #1
NEXT3_2
    LD R0,DEC_1
    DECR_1
        ADD R2,R1,#0
        ADD R2,R2,R0
        BRn DONE_1
        ADD R3,R3,#1
        ADD R1,R2,#0
        BR DECR_1
    DONE_1
        LD R4, ASCII_TOCHAR
        ADD R0,R3,R4
        OUT
BR FINISH_2
        
ZERO_END
	LD R4, ASCII_TOCHAR
	LD R1, ZERO_2
	ADD R0, R1, R4
	OUT
	
FINISH_2

LD R1, BACKUP_R1_4800
LD R7, BACKUP_R7_4800
RET

;--------------------------------
;Data for subroutine print number
;--------------------------------
BACKUP_R7_4800	.BLKW	#1
BACKUP_R1_4800	.BLKW	#1
;Data for subroutine:
BACKUP_R0_2	.BLKW	#1
BACKUP_R1_2	.BLKW	#1
BACKUP_R2_2	.BLKW	#1
BACKUP_R3_2	.BLKW	#1
BACKUP_R4_2	.BLKW	#1
BACKUP_R5_2	.BLKW	#1
BACKUP_R6_2	.BLKW	#1
BACKUP_R7_2	.BLKW	#1
ASCII_TOCHAR .FILL #48
DEC_10000 .FILL #-10000
DEC_1000 .FILL #-1000
DEC_100 .FILL #-100
DEC_10 .FILL #-10
DEC_1 .FILL #-1
PLUS_SIGN		.FILL	'+'
MINUS_SIGN		.FILL	'-'
ZERO_2			.FILL	#0
CONVERT_4800	.FILL	#-48



.ORIG x5000			; Remote data
BUSYNESS .FILL x4000		; <----!!!VALUE FOR BUSYNESS VECTOR!!!
.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"
;---------------	
;END of PROGRAM
;---------------	
.END
