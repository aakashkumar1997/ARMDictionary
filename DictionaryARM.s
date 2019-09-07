		;		-----------------	Embededd Systems Project	  ------------	;
		
		;By:-;
		;1)_Name:	Aakash Kumar		Roll no: 160108048;
		
		
		;		-----------------	Implementing Dictionary using Binary Search	-------------- ;
		;		Finds a word in Dictionary.;
		;		If the word is available in Dictionary, store location of desired word in result register. ;
		;		If word is not available in Dictionary, store 0 in result register		;
		
		
		;=================================Program	starts from here========================================================;
		
		
		MOV		R0 , #512			; Initial address of memory
		MOV		R1 , #0			; Lower Bound of number stored in memory
		MOV		R2 , #200			; Upper bound of number stored in memory
L2		CMP		R1 , R2			; Checking if index(R1) is equal to Upper bound(R2).
		BEQ		L1				; if R1 == R2, then do not enter in this loop
		ADD		R3 , R1 , #1		; make R3 = R1 + 1
		LSL		R3 , R3 , #1
		LSL		R4 , R1 , #2		; Logical Left Shift to make R4 = 4 * R1, to store address offset in R4
		STR		R3 , [R0 , R4]		; Store R3 in address location = Base Location(R0 = #256) + Offset(R4 = 4 * R1)
		ADD		R1 , R1 , #1		; Increment R1
		B		L2				; Unconditionally branch to L2
L1		MOV		R5 , #100			; Element to be searched in R5
		BL		binSearch			;Calling Binary Search block. Arguements in R0(initial address of memory location) & R5(element to be searched). Result in R6
		
end_prog	END
		
		
binSearch	SUB		SP , SP , #32		; Making space in stack by subtracting space for 4 * 8 = 32 bytes in stack pointer.
		STR		LR , [SP , #24]	; Storing LR in [SP , #24]
		STR		R6 , [SP , #16]	; Storing R6 in [SP , #16]
		STR		R7 , [SP , #8]		; Storing R7 in [SP , #8]
		STR		R8 , [SP , #0]		; Storing R8 in [SP , #0]
		MOV		R6 , #0			; Storing start index in R6 = 0
		SUB		R7 , R2 , #1		; Storing end index in R7 = R2 - 1 (length of dictionary - 1)
L7		CMP		R6 , R7			; Compare R6 and R7 i.e. start and end
		BGT		L9				; if start > end , then branch to L3
		ADD		R8 , R6 , R7		; make R8 = R6 + R7 i.e. mid_2 = start + end
		LSR		R8 , R8 ,#1		; Store R8 = R8 / 2 i.e. mid = mid_2 / 2. Using LSR instead of DIV for dividing mid_2 with 2.
		LSL		R9 , R8 , #2		; R9 = R8 * 4. address indexing
		LDR		R10 , [R0 , R9]	; load element at [R0 , R9] i.e. at mid index in stored memory block, in R10
		CMP		R5 , R10			; Compare R5(element to be searched) and mid index of memory block
		BNE		L4				; if R5 and R10 are not equal then branch to L4
		MOV		R6 , R8			; if R5 and R10 are equal, then move R8 (index at which desired element found in dictionary) into R6 (return register)
		ADD		R6 , R6 , #1
		B		L3				; unconditional branch to L3 i.e. exit out from binary serach function block
L4		CMP		R5 , R10			; compare element to be searched with element at mid index of dictionary
		BGT		L6				; if R5(element to find) > R10(element at mid of dictionary block), then branch to L6
		SUB		R7 , R8 , #1		; store R7 = R8 - 1, make end = mid - 1
		B		L7
L6		ADD		R6 , R8 , #1		; strore R6 = R8 + 1. make start = mid + 1
		B		L7				; unconditionally branch to L7
		
L9		MOV		R6 , #0			; Move 0 in R6 if element not found.
		;B		L3				; uncondiitonally branch ro L3.
		
		;		load back values from stack into registers.
		
L3		LDR		R8 , [SP , #0]		; load [SP , #0] in R8
		LDR		R7 , [SP , #8]		; load [SP , #0] in R7
		LDR		LR , [SP , #24]	; load [SP , #0] in LR
		ADD		SP , SP , #32		; add #32 in Sp, to fill up the space vacated for storing register's content sin stack
		B		end_prog			; function return to call location. BL LR not working thatswhy used 'B end_prog' label
