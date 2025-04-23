.data
    A: .word 0, 2, 4, 6, 8, 10, 12, 14, 16
    B: .word 16, 14, 12, 10, 8, 6, 4, 2, 0
    C: .space 36

.text
    .globl main
    
main:
    la      s0, A   # s0 apunta a A[0][0]
    la      s1, B   # s1 apunta a B[0][0]
    la      t6, C   # t6 apunta a C[0][0]

    li      s4, 3   # N = 3
    li      t0, 0   # i = 0

loop_i:
    # if i >= N, salir
    bge     t0, s4, end_i

    # j = 0
    li      t1, 0

loop_j:
    # if j >= N, siguiente i
    bge     t1, s4, next_i

    li      t3, 0       # sum = 0
    li      t2, 0       # k = 0

loop_k:
    # if k >= N, guardar sum
    bge     t2, s4, store

    # offset = (i*3 + k) * 4
    li      t4, 3
    mul     t5, t0, t4   # t5 = i*3
    add     t5, t5, t2   # t5 = i*3 + k
    slli    t5, t5, 2    # t5 *= 4
    # cargar A[i][k] en s2
    add     s2, s0, t5
    lw      s2, 0(s2)
    # offset = (k*3 + j) * 4
    mul     t5, t2, t4   # t5 = k*3
    add     t5, t5, t1   # t5 = k*3 + j
    slli    t5, t5, 2    # t5 *= 4
    # cargar B[k][j] en s3
    add     s3, s1, t5
    lw      s3, 0(s3)

    # sum += s2 * s3
    mul     s2, s2, s3
    add     t3, t3, s2

    addi    t2, t2, 1
    j       loop_k

store:
    # offset = (i*3 + j) * 4
    mul     t5, t0, t4   # t5 = i*3
    add     t5, t5, t1   # t5 = i*3 + j
    slli    t5, t5, 2    # t5 *= 4
    # almacenar sum en C[i][j]
    add     s2, t6, t5
    sw      t3, 0(s2)

    addi    t1, t1, 1
    j       loop_j

next_i:
    addi    t0, t0, 1
    j       loop_i

end_i:
    li      a7, 93
    li      a0, 0
