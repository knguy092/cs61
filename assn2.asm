;=================================================
; Name: Nguyen, Kevin
; Username: knguy092
; 
; Assignment name: assn2
; Lab section:  022
; TA: Jose Rodriguez
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the 
; instruction team.
;
;=================================================

.orig x3000
;=================================================
;Instructions
;=================================================

LEA R0, OUTPUT		;output starting message
PUTS

GETC			;retrieve first input
OUT
ADD R1, R0, #0		;store first input in R1

LD R0, NEWLINE
OUT
GETC			;retrieve second input
OUT
ADD R2, R0, #0		;store second input in R2

LD R0, NEWLINE
OUT

ADD R0, R1, #0
OUT
LD R0, MINUS
OUT
ADD R0, R2, #0
OUT
LD R0, EQUAL
OUT


; ---------------------------------------

; now actually performing all the arithmatic
; --------------------------------------


LD R6, A2N 

NOT R6,R6

ADD R6,R6, #1 		;make 48 negatvive


ADD R1, R1, R6   

ADD R2, R2, R6 		

NOT R2, R2		;two's compliment, "not" R2 and store into R2
ADD R2, R2, #1		;add 1 to R3

ADD R4, R2, R1		;add the two numbers together


BRn NEGATIVE		;if R4 < 0, go to negative, else go to Positive

	
		POSITIVE
		
			LD R0, A2N
		
			ADD R0, R0, R4
		
			OUT


		
BR LABELEND		;code is read downwards, so even if we read in positive, it will still continue to read down 				
					;to negative, therefore we need this labelend branch to skip the negative branch


		NEGATIVE
		
			LD R0, MINUS
		
			OUT
                
                
			NOT R4, R4
                
			ADD R4, R4, #1 
                
		
			LD R0, A2N
		
			ADD R0, R0, R4
        	
			OUT 

		LABELEND 


LD R0, NEWLINE

OUT

HALT
;=================================================
;Local Data
;=================================================
OUTPUT		.STRINGZ		"ENTER two numbers (i.e '0'....'9')\n"
MINUS		.FILL			'-'
EQUAL		.FILL			'='
NEWLINE		.FILL			'\n'

A2N             .FILL                    #48  ;48 because this is the ASCII for zero
;=================================================
.END
