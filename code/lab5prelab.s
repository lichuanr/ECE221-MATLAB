/*
.text 
    0x400
	
.data
	0x400
*/

.global _start
_start:

READ_SENSORS_AND_SPEED: 
	movia r7, 0x10001020 /* r7 now contains the base address */
  
WRITE_POLL_0:/* give the initial speed for the car */
	ldwio r3, 4(r7) /* Load from the JTAG */
	srli  r3, r3, 16 /* Check only the write available bits */
	beq   r3, r0, WRITE_POLL_0 /* If this is 0 (branch true), data cannot be sent */ 
	movui r4, 0x04 /* for prompt taking information */
	stwio r4, 0(r7) /* Write the byte to the JTAG */  
	movui r4, 0x41 #Acceleration of the car
	stwio r4, 0(r7)
	br WRITE_POLL_2
  
WRITE_POLL_1:
	ldwio r3, 4(r7) /* Load from the JTAG */
	srli  r3, r3, 16 /* Check only the write available bits */
	beq   r3, r0, WRITE_POLL_1 /* If this is 0 (branch true), data cannot be sent */ 
	movui r4, 0x04 /* for prompt taking information */
	stwio r4, 0(r7) /* Write the byte to the JTAG */
	movui r4, 0x81 # Changed new acceleration
	stwio r4, 0(r7)
	br WRITE_POLL_2
  
WRITE_POLL_2:/*sensor and speed*/
	ldwio r3, 4(r7) /* Load from the JTAG */
	srli  r3, r3, 16 /* Check only the write available bits */
	beq   r3, r0, WRITE_POLL_2 /* If this is 0 (branch true), data cannot be sent */
  movui r2, 0x03 /* the write_poll to sent */
  stwio r2, 0(r7) /* Write the byte to the JTAG */
  
  READ_POLL:
  ldwio r2, 0(r7) /* Load from the JTAG */
  andi  r3, r2, 0x8000 /* Mask other bits */
  beq   r3, r0, READ_POLL /* If this is 0 (branch true), data is not valid */
  andi  r3, r2, 0x00FF /* Data read is now in r3 */
  
  READ_POLL_1:
  ldwio r2, 0(r7) /* Load from the JTAG */
  andi  r5, r2, 0x8000 /* Mask other bits */
  beq   r5, r0, READ_POLL_1 /* If this is 0 (branch true), data is not valid */
  andi  r5, r2, 0x00FF /* Data read is now in r3 */
  
  READ_POLL_2:
  ldwio r2, 0(r7) /* Load from the JTAG */
  andi  r6, r2, 0x8000 /* Mask other bits */
  beq   r6, r0, READ_POLL_2 /* If this is 0 (branch true), data is not valid */
  andi  r6, r2, 0x00FF /* Data read is now in r3 */
  

  movui r10, 0x1f
  movui r11, 0x1e
  movui r12, 0x1c
  movui r13, 0x0f
  movui r17, 0x07

  beq r5, r10, STEER_POLL_1
  beq r5, r11, STEER_POLL_2
  beq r5, r12, STEER_POLL_3
  beq r5, r13, STEER_POLL_4
  beq r5, r17, STEER_POLL_5
  
  STEER_POLL_1:
  ldwio r14, 4(r7) /* Load from the JTAG */
  srli  r14, r14, 16 /* Check only the write available bits */
  beq   r14, r0, STEER_POLL_2 /* If this is 0 (branch true), data cannot be sent */
  
  movia r9, 25000000
  movui r15, 0x05 /* ASCII code for 0 */
  stwio r15, 0(r7) /* Write the byte to the JTAG */
  movui  r16, 0x00 /*Steering angle*/
  stwio r16, 1(r7)
  br SPEED
  
  STEER_POLL_2:
  ldwio r14, 4(r7) /* Load from the JTAG */
  srli  r14, r14, 16 /* Check only the write available bits */
  beq   r14, r0, STEER_POLL_2 /* If this is 0 (branch true), data cannot be sent */
  
  movia r9, 25000000
  movui r15, 0x05 /* ASCII code for 0 */
  stwio r15, 0(r7) /* Write the byte to the JTAG */
  movui  r16, 0x45 /*Steering angle*/
  stwio r16, 1(r7)

  br SPEED
  
  
  STEER_POLL_3:
  ldwio r14, 4(r7) /* Load from the JTAG */
  srli  r14, r14, 16 /* Check only the write available bits */
  beq   r14, r0, STEER_POLL_3 /* If this is 0 (branch true), data cannot be sent */
  
  movia r9, 25000000
  movui r15, 0x05 /* ASCII code for 0 */
  stwio r15, 0(r7) /* Write the byte to the JTAG */
  movui  r16, 0x7f /*Steering angle*/
  stwio r16, 1(r7)

  br SPEED
  
  
  STEER_POLL_4:
  ldwio r14, 4(r7) /* Load from the JTAG */
  srli  r14, r14, 16 /* Check only the write available bits */
  beq   r14, r0, STEER_POLL_4 /* If this is 0 (branch true), data cannot be sent */
  
  movia r9, 25000000
  movui r15, 0x05 /* ASCII code for 0 */
  stwio r15, 0(r7) /* Write the byte to the JTAG */
  movui  r16, 0xdd /*Steering angle e2:30 dd:35*/
  stwio r16, 1(r7)
  br SPEED
  
  
  STEER_POLL_5:
  ldwio r14, 4(r7) /* Load from the JTAG */
  srli  r14, r14, 16 /* Check only the write available bits */
  beq   r14, r0, STEER_POLL_5 /* If this is 0 (branch true), data cannot be sent */
  
  movia r9, 25000000
  movui r15, 0x05 /* ASCII code for 0 */
  stwio r15, 0(r7) /* Write the byte to the JTAG */
  movui  r16, 0x81 /*Steering angle*/
  stwio r16, 1(r7)
  br SPEED
  
  SPEED:
  movia r19, 0x2d

  bgt r6, r19, WRITE_POLL_1  
  br WRITE_POLL_0
  
   
LOOP:
	br LOOP
	
 /*
 WRITE_POLL_3: 
  ldwio r3, 4(r7)
  srli  r3, r3, 16 
  beq   r3, r0, WRITE_POLL_3 
  movui r4, 0x04 
  stwio r4, 0(r7) 
  movui r4, 0x10
  stwio r4, 1(r7)
  br WRITE_POLL_1
  
  movia r18, 0x50
  bgt r6, r18, WRITE_POLL_2
  
 movia r9, 100
 DELAY:
 subi r9,r9,1       
 bne r9,r0, DELAY   
 */
 /* movia r9, 250000000
  
   DELAY:
   subi r9,r9,1       
   bne r9,r0, DELAY
   
 WRITE_POLL_2:
  ldwio r3, 4(r7)
  srli  r3, r3, 16 
  beq   r3, r0, WRITE_POLL_2 
  movui r2, 0x04 
  stwio r2, 0(r7) 
  movui r2, 0x03
  stwio r2, 0(r7)
  */
  