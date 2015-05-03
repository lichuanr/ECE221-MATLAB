


.global _start
_start:

  .equ ADDR_JP1, 0x10000060   /*Address GPIO JP1*/
  movia  r8, ADDR_JP1
  
  
  
  movia  r9, 0x07f557ff        /* set direction for motors to all output */
  stwio  r9, 4(r8)
  movia  r9, 0xffffffff
  stwio r9, 0(r8)

sensor_3:
   movia r11, 0xfffeffff
   stwio r11, 0(r8)
   ldwio  r4, 0(r8)           /* checking for valid data sensor 3*/
   srli   r4, r4, 17           /* bit 17 equals valid bit for sensor 3*/           
   andi   r4, r4, 0x1
   bne    r0, r4, sensor_3     /* checking if low indicated polling data at sensor 3 is valid*/
good1:
   ldwio  r10, 0(r8)         /* read sensor3 value (into r9) */
   srli   r10, r10, 27       /* shift to the right by 27 bits so that 4-bit sensor value is in lower 4 bits */
   andi   r10, r10, 0x0f
   
sensor_0:
   movia r12, 0xfffff3ff
   #orhi r12, r0, 0x0
   #addi r12, r12, -0x401
   stwio r12, 0(r8)
   ldwio  r5, 0(r8)           /* checking for valid data sensor 0*/
   srli   r5, r5, 11           /* bit 17 equals valid bit for sensor 0*/           
   andi   r5, r5, 0x1
   bne    r0, r5, sensor_0        /* checking if low indicated polling data at sensor 3 is valid*/
 good:
   ldwio  r13, 0(r8)         /* read sensor3 value (into r9) */
   srli   r13, r13, 27       /* shift to the right by 27 bits so that 4-bit sensor value is in lower 4 bits */
   andi   r13, r13, 0x0f 
br compare
   
compare:
	beq r10, r13, sensor_3
	bgt r10, r13, right
	blt r10, r13, left

right:
  movia  r9, 0xffffffe #enable the motor 0 and sensor0 and sensor3
  stwio	 r9, 0(r8)	
  call motor
  br sensor_3
  
left:
  movia  r9, 0xffffffc #enable the motor 0 and sensor0 and sensor3
  stwio	 r9, 0(r8)	
  call motor
  br sensor_3
  
  
motor:
  movia r9,100000 /* set starting point for delay counter */
  DELAY:
  subi r9,r9,1       /* subtract 1 from delay */
  bne r9,r0, DELAY   /* continue subtracting if delay has not elapsed */
ret 



 