;=================================================
; 
; Name: Nguyen, Kevin
; Username: knguy092
;
; SID: 861151221
; Assignment name: assn 3
; Lab section: 022
; TA: Jose Rodriguez
;
; I hereby certify that I have not received 
; assistance on this assignment, or used code,
; from ANY outside source other than the
; instruction team. 
;
;=================================================

                .ORIG x3000			    ; Program begins here
                ;-------------
                ;Instructions
                ;-------------
                LD R6, Convert_addr		; R6 <-- Address pointer for Convert
                LDR R1, R6, #0			; R1 <-- VARIABLE Convert 
                ;-------------------------------
                ;INSERT CODE STARTING FROM HERE
		LD R2, Mask
		NOT R2, R2
		LD R3, SIXTEEN_COUNT
		LD R4, FOUR_COUNT

WHILE		AND R0, R1, R2
		BRz
		LD R0, ONE
		OUT
		BRnzp SHIFT

PRINT_ZERO	LD R0, ZERO
		OUT

SHIFT		ADD R1, R1, R1
		ADD R4, R4, #-1
		BRz PRINT_SPACE
		BRnzp LOOP_AGAIN

PRINT_SPACE	LD R0, SPACE
		OUT
		LD R4, FOUR_COUNT

LOOP_AGAIN	ADD R3, R3, #-1
		BRp WHILE
		

                ;--------------------------------


                HALT
                ;---------------	
                ;Data
                ;---------------
Convert_addr    .FILL x5000	            ; The address of where to find the data

Mask		.FILL x7FFF
ONE		.FILL #1
ZERO		.FILL #0
SPACE		.FILL x20
FOUR_COUNT	.FILL #4			;need a space every four bits, therefore need counter
SIXTEEN_COUNT	.FILL #16
NEWLINE		.FILL '\n'


                .ORIG x5000			    ; Remote data
Convert         .FILL #169		        ; <----!!!NUMBER TO BE CONVERTED TO BINARY!!!

                ;---------------	
                ;END of PROGRAM
                ;---------------	
                .END
