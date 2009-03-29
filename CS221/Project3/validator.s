.data
  # Output messages
  Greeting:     .asciiz "** Enter commands, and hit return to process:\n"
  Prompt:       .asciiz ">> "
  Error:        .asciiz "!! Oh-oh! Something happened that shouldn't have: Error #"
  Goodbye:      .asciiz "** Awwww...\n"
  # Buffers
  # These have to have a lot of whitespace to pre-allocate the (possibly)
  # necessary memory
  BInput:      .asciiz "                                                                                                                               "
  BProcessing: .asciiz "                                                                                                                               "
  # Debugging
  YAY:          .asciiz "YAY!\n"
  
.text
  main:
    la $a0, Greeting($zero)
    li $v0, 4; syscall # print_string
  
  MOTHERLOOP_start:
    la $ra, MOTHERLOOP_after_shift
    j SHIFT
  MOTHERLOOP_after_shift:
    la $ra, MOTHERLOOP_have_input
    lb $t1, BInput($zero)
    beq $t1, 0, READ_NEW_INPUT
  MOTHERLOOP_have_input:
    j EXIT

# ---- ---- ! ---- ---- #
  
  li $a0, 0
  ERROR:
    move $t0, $a0
    la $a0, Error($zero)
    li $v0, 4; syscall # print_string
    
    move $a0, $t0
    li $v0, 1; syscall # print_int
    
    li $v0, 10; syscall # exit
  
  READ_NEW_INPUT:
    la $a0, Prompt($zero)
    li $v0, 4; syscall # print_string
    
    la $a0, BInput
    li $a1, 128
    li $v0, 8; syscall # read_string
    
    j $ra
  
  li $a0, 1
  j ERROR
  SHIFT:
    addi $sp, $sp, -4
    sw $s0, 0($sp)
    move $s0, $ra
    
    SHIFT_start:
      la $ra, SHIFT_middle
      li $a2, 59
      j COPY_STRING
      
    SHIFT_middle:
      addi $v0, 1
      la $ra, SHIFT_end
      move $a1, $a0
      move $a0, $v0
      li $a2, 0
      j COPY_STRING
      
    SHIFT_end:
      move $ra, $s0
      lw $s0, 0($sp)
      addi $sp, $sp, 4
      j $ra
  
  li $a0, 3
  j ERROR
  COPY_STRING:
    move $t1, $a0
    move $t2, $a1
    
    COPY_STRING_loop_start:
      lb $t0, 0($t1)
      beq $t0, 0, COPY_STRING_end
      beq $t0, $a2, COPY_STRING_end
      sb $t0, 0($t2)
    
    COPY_STRING_loop_end:
      addi $t1, 1
      addi $t2, 1
      j COPY_STRING_loop_start
    
    COPY_STRING_end:
      move $v0, $t1
      sb $zero, 0($t2)
      j $ra
  
  li $a0, 2
  j ERROR
  EXIT:
    la $a0, Goodbye($zero)
    li $v0, 4; syscall # print_string
    
    li $v0, 10; syscall # exit
