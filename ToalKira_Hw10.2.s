    .equ    SWI_PrStr,0x69
    .equ 	SWI_PrInt,0x6b
    .equ    Stdout,1
	.equ	Null,0x00
    .equ    N,19
    .equ    SWI_Exit,0x11
    .global _start
    .text
_start:
    ldr     r1, =StartMsg1
    bl      PrintString
    ldr     r1, =N
    mov		r0,#Stdout	
	swi		SWI_PrInt   @ Print Int 
    ldr     r1, =StartMsg2
    bl      PrintString
    ldr     r1, =NewLine
    bl      PrintString
    mov     r3, #1      @ Initialize r3 to hold 1 
    ldr     r4, =N      @ Initialize r4 to hold N 
    bl      Loop        @ Call loop function to print numbers 
    ldr     r1, =NewLine
    bl      PrintString
    ldr     r1, =EndMsg
    bl      PrintString
    swi     SWI_Exit

Loop:
    mov     r1, r3
    str 	lr, [sp, #-4]!
	bl 		PrintInt    @ print number  
	ldr 	lr, [sp], #4
    cmp     r3, r4      @ check if cap reched
    add     r3, r3, #1  @ increment counter  
    bne     Loop
    mov     pc, lr

PrintString:
    mov     r0, #Stdout
    swi     SWI_PrStr
    mov     pc, lr

PrintInt:
	mov		r0,#Stdout	
	swi		SWI_PrInt   @ Print Int 
    mov     r0, #Stdout
    ldr     r1, =NewLine
    swi     SWI_PrStr  @ Print Newline 
    mov     pc, lr

    .data
StartMsg1:   .asciz  "Printing "
StartMsg2:   .asciz  " integers ..."
EndMsg:     .asciz  "Done!"
NewLine:    .asciz  "\n"
    .end


