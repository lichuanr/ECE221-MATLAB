/********
 * 
 * Write the assembly function:
 *     printn ( char * , ... ) ;
 * Use the following C functions:
 *     printHex ( int ) ;
 *     printOct ( int ) ;
 *     printDec ( int ) ;
 * 
 * Note that 'a' is a valid integer, so movi r2, 'a' is valid, and you don't need to look up ASCII values.
 ********/

.global	printn
printn:
ret
	subi sp, sp, 12
	stw r5, 0(sp)
	stw r6, 4(sp)
	stw r7, 8(sp)

	
	movi r8, 'H'#store "H"
	movi r9, 'O'#store "O"
	movi r10, 'D'#store "D"
	mov r11, r4#copy the text register
		
	STACK:
	ldw r4, 0(sp)
	addi sp, sp, 4#increment the stack by 4 bytes
	ldb r12, 0(r11)#load the bytes
	beq r12, r0, END_POINT#end of string

	addi r11, r11, 1#increment the text by 1 bytes
	br PRINT
	
	PRINT:
	subi sp,sp,20
	stw r8, 16(sp)
	stw r9, 12(sp)
	stw r10, 8(sp)
	stw r11, 4(sp)
	stw r12, 0(sp)

	beq r12, r8, H_BRANCH
	beq r12, r9, O_BRANCH
	beq r12, r10, D_BRANCH
	
	Restore:
	ldw r12, 0(sp)
	ldw r11, 4(sp)
	ldw r10, 8(sp)
	ldw r9, 12(sp)
	ldw r8, 16(sp)
	addi sp, sp, 20
	 
	 br STACK
	 
	 H_BRANCH:
	 call printHex
	 br Restore
	 
	 O_BRANCH:
	 call printOct
	 br Restore
	 
	 D_BRANCH:
	 call printDec
	 br Restore
	
	
	 
	END_POINT:
	ldw r5, 0(sp)
	ldw r6, 4(sp)
	ldw r7, 8(sp)

	
	addi sp, sp, 12
	
	
	
	
ret


