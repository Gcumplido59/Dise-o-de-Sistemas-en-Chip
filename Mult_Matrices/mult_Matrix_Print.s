.data
    A: .word 0, 2, 4, 6, 8, 10, 12, 14, 16
    B: .word 16, 14, 12, 10, 8, 6, 4, 2, 0
    C: .space 36

    espacio: .asciiz " "
    salto:   .asciiz "\n"

.text
    .globl main

main:
    la      s0, A      #0
    la      s1, B      #0
    la      s2, C      #0

    li      t0, 0       # i = 0
    li      t6, 3       # N = 3

# Bucle filas
loop_i:
    bge     t0, t6, print_start
    li      t1, 0       # j = 0

# Bucle columnas
loop_j:
    bge     t1, t6, next_i
    li      t2, 0       # k = 0
    li      t3, 0       # sum = 0

# Bucle count
loop_k:
    bge     t2, t6, store

    #A[i][k] en t4
    mul     t4, t0, t6
    add     t4, t4, t2
    slli    t4, t4, 2
    add     t4, s0, t4
    lw      t4, 0(t4)

    #B[k][j] en t5
    mul     t5, t2, t6
    add     t5, t5, t1
    slli    t5, t5, 2
    add     t5, s1, t5
    lw      t5, 0(t5)

    # Multiplicación y suma
    mul     t4, t4, t5
    add     t3, t3, t4

    addi    t2, t2, 1
    j       loop_k

store:
    mul     t4, t0, t6
    add     t4, t4, t1
    slli    t4, t4, 2
    add     t4, s2, t4
    sw      t3, 0(t4)

    addi    t1, t1, 1
    j       loop_j

next_i:
    addi    t0, t0, 1
    j       loop_i

# Imprimir matriz resultante (C)
print_start:
    li      t0, 0

print_i:
    bge     t0, t6, end_i
    li      t1, 0

print_j:
    bge     t1, t6, print_

    #C[i][j] en a0
    mul     t4, t0, t6
    add     t4, t4, t1
    slli    t4, t4, 2
    add     t4, s2, t4
    lw      a0, 0(t4)

    li      a7, 1       
    ecall

    la      a0, espacio
    li      a7, 4      
    ecall

    addi    t1, t1, 1
    j       print_j

print_:
    la      a0, salto
    li      a7, 4      
    ecall

    addi    t0, t0, 1
    j       print_i

end_i:
    li      a7, 10   
    li      a0, 0
    ecall
