# Tarea de MIPS \#2

Ejercicios de lenguaje ensamblador. Más información en [el blog](https://la35.net/orga/mips-funciones.html). Para probar los programas pueden usar el SPIM.

## Ejercicio

Forkear este repo e implementar en _assembler_ de MIPS la función factorial tanto de manera iterativa como recursiva.

En la función `main` llamar a la función e imprimir el resultado en la consola. Usen un archivo separado para cada versión de factorial. En cada archivo tiene que haber una función factorial separada de `main` y la deben llamar usando `jal factorial`. 

Recuerden comentar el código.

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


  FACTORIAL RECURSIVO

.data
prompt: .asciiz "INGRESE NUMERO DEL FACTORIAL A CALCULAR:  " 
space:  .asciiz "\n"        

.text
.globl main
main:
## INGRESA Y LEE EL NUMERO
li		      $v0, 4		        # SYSCALL CODE LEE STRING 
la		      $a0, prompt		    # CAEGA DIRECCIÓN 
syscall                       # LEE PROMPT
li          $v0, 5            # SYSCALL CODE LEE INT
syscall                       # LEE NUMERO
move        $s0, $v0          # MUEVE LO DE $v0 A $s0
li		      $v0, 4		        # SYSCALL CODE LEE STRING
la		      $a0, space		    # LEE ESPACIO
syscall                       # AGREGA ESPACIO

## CASO DE 1 Y 0
beq         $s0, 1, bye  # if number == 1 goto bye
beq         $s0, 0, bye  # if number == 1 goto bye

## RESTA 1 AL NUMERO ELEGIDO
addi		    $a2, $s0, -1      # $a2 = $s0-- (number - 1)

## SALTA A LA FUNCION QUE CALCULA EL FACTORIAL
jal         factorial              # SALTAR A POSICIÓN FACTORIAL Y GUARDA LA POSICION A $ra

## FIN DEL PROGRAMA
li		      $v0, 10		        
syscall

## CALCULA EL FACTORIAL Y GUARDA DATOS EN LA PILA
factorial:
## GUARDA $SP, $S0
addi        $sp, $sp, -8      # HAGO LUGAR EN LA PILA
sw          $ra, 0($sp)       # PUSH $ra
sw          $s0, 4($sp)       # PUSH $s0 (NUMERO)
j           loop              # VA AL LOOP

## FUNCION LOOP DEL FACTORIAL
loop:
beq		      $a2, $zero, exit  # if $a2 == 0 go to exit
mul         $s0, $s0, $a2     # number *=  number-1
addi		    $a2, $a2, -1      # $a2 = $a2--
jal         loop              # SALTA AL LOOP Y GUARDA POSICION A $ra

## IMPRIME RESULTADO DEL FACTORIAL
exit:
li          $v0, 1            # SYSCALL CODE IMPRIME INT
move        $a0, $s0          # MUEVE $s0 A $a0
syscall

## TRAE LOS DATOS DE LA PILA Y RESTAURA EL ESPACIO DE LA PILA
lw          $ra, 0($sp)       # RECUPERA VALOR DE $ra
lw          $s0, 4($sp)       # RECUPERA VALOR DE $s0 (numero original)
addi        $sp, $sp, 8       # RECUPERA ESPACIO UTILIZADO EN LA PILA

## VUELVE A LA INSTRUCCION SEGUIDA AL PRIMER JAL (FIN DEL PROGRAMA)
jr          $ra

## CASO 1 y 0 => IMPRIME EL NUMERO Y TERMINA EL PROGRAMA
bye:
li          $v0, 1            # SYSCALL CODE IMPRIME INT
move        $a0, $s0          # MUEVE $s0 A $a0
syscall
li		      $v0, 10		        # syscall halt code
syscall
