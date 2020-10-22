FACTORIAL ITERATIVO

.data
prompt: .asciiz "INGRESE UN NUMERO\n"


.text
  .globl main
    main:
    li $v0, 4       # SYSCALL CODE PARA IMPRIMIR STRING
    la $a0, prompt  # CARGA DIRECCION STRING
    syscall         # PRINT "INGRESE UN NUMERO \n"

    li $v0, 5       # SYSCALL CODE PARA LEER INT
    syscall         # LEE EL ENTERO Y EL RESULTADO QUEDA EN $v0
    move $t0, $v0   # MUEVE LO DE v0 A t0 

    addi $a0, $t0, -1 #RESTA 1 AL NUMERO INGRESADO


    jal factorial

    exit:
    li $v0, 1
    move $a0, $t0 # MUEVE LO DE t0 A a0
    syscall

    li        $v0, 10
    syscall                         

    jr $ra

    factorial:
    beq  $a0, $zero, exit
    mul $t0, $t0, $a0 #MULTIPLICA Y GUARDA EN t1
    addi $a0, $a0, -1 #RESTA 1 AL NUMERO INGRESADO
    j factorial


  
