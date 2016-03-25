;=================================================
; 
; Name: Nguyen, Kevin
; Username: knguy092
;
; SID: 861151221
; Assignment name: assn 4
; Lab section: 022
; TA: Jose Rodriguez
;
; I hereby certify that I have not received 
; assistance on this assignment, or used code
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
INTRO
	;TO Output Intro Message
	LD R0, introMessage  ; Output Intro Message
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

	LD R2, UPPER_LIMIT	;CHECKS IF INPUT IS A VALID 1-9 DECIMAL
	ADD R2, R0, R2
	BRp ERROR
	
	LD R2, LOWER_LIMIT	;CHECKS IF INPUT IS VALID 1-9 DECIMAL
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
	
	LD R2, UPPER_LIMIT	;CHECKS IF INPUT IS A VALID 1-9 DECIMAL
	ADD R2, R0, R2
	BRp ERROR
	
	LD R2, LOWER_LIMIT	;CHECKS IF INPUT IS VALID 1-9 DECIMAL
	ADD R2, R0, R2
	BRn ERROR
	
	ADD R3, R0, R3	;TRANSFERS INPUT INTO R3
	LD R4, CONVERT
	ADD R3, R4, R3	;CONVERTS R3 INTO A DECIMAL
	ST R4, CONVERT
	
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

	LD R0, NEWLINE
	OUT
	;TO Output Error Message
	LD R0, errorMessage  ; Output Error Message
	PUTS

	LD R0, RESET_ZERO	;RESET ALL REGISTERS BEFORE RESTARTING LOOP
	LD R1, RESET_ZERO
	LD R2, RESET_ZERO
	LD R3, RESET_ZERO
	LD R4, RESET_ZERO
	LD R5, RESET_ZERO
	LD R6, RESET_ZERO

	BR INTRO
	
DONE

LD R0, NEWLINE
OUT

HALT
;---------------	
;Data
;---------------

ENTER			.FILL	#-10
RESET_ZERO		.FILL	#0
MINUS			.FILL	#-45
PLUS			.FILL	#-43
R10				.FILL 	#0
STORE 			.FILL	#0
NEWLINE			.FILL	'\n'
UPPER_LIMIT     .FILL 	#-58
LOWER_LIMIT	    .FILL 	#-48
CONVERT			.FILL 	#-48
TEN_COUNTER		.FILL 	#9


introMessage .FILL x6000
errorMessage .FILL x6100

;------------
;Remote data
;------------
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_mes .STRINGZ	"ERROR INVALID INPUT\n"

;---------------
;END of PROGRAM
;---------------
.END
;-------------------
;PURPOSE of PROGRAM
;-------------------

