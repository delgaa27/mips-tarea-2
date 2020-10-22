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
