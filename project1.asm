.data
	prompt: .asciiz "Please input array A: \n"
	array_s: .space 205
	array_i: .space 1000
	char: .space 2
	null: .asciiz "" 
	space: .asciiz " " 
	newline: .asciiz "\n" 
	comma: .asciiz ","
	key: .asciiz "Please input a key value: \n"
	step: .asciiz "Step "
	unsorted_m: .asciiz "Error! The array is not sorted.\n"
	notfound_m: .asciiz "Not found!\n"
	colon: .asciiz ": "
	string1: .asciiz "A["
	string2: .asciiz "] "
	greater: .asciiz "> "
	less: .asciiz "< "
	equal: .asciiz "= "
	minus: .asciiz "-"
	error_m: .asciiz "error!"
	
.text
main: 
	add $v0, $zero, $zero	# initialize
	add $a0, $zero, $zero
	li $v0, 4   	 
	la $a0, prompt   
	syscall   		#print prompt

gets:   
	la $s1, array_s 		 #set base address of array to $s1 
loop:   				#start of read loop 
	jal getchar 	 	#jump to getchar in order to get  one charactor in buffer 
	la $a0, char #reload byte space to primary address
         move $a0,$t0 # primary address = t0 address (load pointer)
	li $v0, 4
	add $a0, $t0, $zero
	syscall
	sb $t0, 0($s1) 	 	#store the char into the nth element of array 
	lb $t1, newline 		 #load newline char into t1 
	beq $t0, $t1, done	 #if end of string then jump to done 
	addi $s1, $s1, 1 		# base address ++
	j loop   		#jump to  loop 

getchar:  				 #read char from  buffer  
	li $v0, 8  		# read string 
	la $a0, char  		
	li $a1, 2 
	move $t0, $a0		
	syscall   		#store the char byte from  buffer into char 
	jr $ra   		#jump back to the gerchar function.data


done:
	addi $s1, $s1, -1 	# relocate address to as the end point
	la $s0, array_s 	 	#set base address of array_s to as the start point 
done_exe:
	beq $s1, $s0, FIN 
	lb $t1, 0($s0)
	li $v0, 1
	add $a0, $t1, $zero
	syscall
	addi $s0, $s0, 1
	j done_exe
FIN: 
	
	li $v0, 10  #ends program 
	syscall 	
