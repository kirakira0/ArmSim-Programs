	.global _start
    .equ 	SWI_PrInt,0x6b
    .equ 	Stdout,1 	
	.equ	Null,0x00 
    .equ    N, 2
	.equ 	SWI_Exit,0x11 	
	.text
_start:
    ldr     r1, =Arr1	@ Load start address of Arr1
    ldr     r2, =Arr2	@ Load start address of Arr2
    mov	    r0,#0	@ Initialize product to 0 
    ldr     r3, =N  @ Initialize counter to N
    bl      Loop
    mov 	r1,r0 @ Move product into r1 for printing
	mov		r0,#Stdout		@ mode is Stdout
	swi		SWI_PrInt		@ print integer to Stdout
    swi     SWI_Exit 
Loop:
    ldr 	r4,[r1]	@ Grab the first number from the first array
    ldr 	r5,[r2]	@ Grab the first number from the second array
    mla     r0, r4, r5, r0
    sub     r3, r3, #1      @ Decrement the counter
    add   r1, r1, #4     	@ move the pointer 	
    add   r2, r2, #4     	@ move the pointer 	
    cmp     r3, #0
    bne     Loop
    mov 	pc, lr 

 	.DATA		
Arr1: 	.WORD 	10, 20
Arr2: 	.WORD 	8, 17	
Result:	.SPACE	4
 	.END