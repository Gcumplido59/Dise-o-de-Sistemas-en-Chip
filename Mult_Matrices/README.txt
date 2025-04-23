**Breve explicacion del codigo:

📌 Multiplicación de Matrices 3x3 en Ensamblador RISC-V
Este programa implementa la multiplicación de dos matrices de tamaño 3×3 en lenguaje ensamblador RISC-V (RV32I), utilizando bucles anidados y gestión de memoria de bajo nivel.

📋 ¿Qué hace el programa?
Define tres matrices en memoria:
    A: una matriz 3×3
    B: una matriz 3×3
    C: una matriz 3×3 vacía donde se almacenará el resultado.

Realiza la multiplicación de matrices:

    Utiliza tres bucles anidados (i, j, k) para calcular cada elemento C[i][j] como la suma del producto de elementos correspondientes de la fila i de A y la columna j de B.
    Guarda el resultado en la matriz C.
    Imprime la matriz C en consola, mostrando los resultados formateados con espacios y saltos de línea usando syscalls (ecall).

💻 Instrucciones clave utilizadas:
mul, add, slli, lw, sw: se utilizan como operaciones aritméticas y de acceso a memoria.

bge, j: lo utilicé para el control de flujo para bucles.

ecall: es para imprimir los valores de la matriz resultante.

🧪 Resultado esperado (matriz C):
36  24  12  
216 168 120  
396 312 228  

Este resultado se puede observar en la imagen .PNG anexada en el mismo repositorio, para que esten visibles estos numeros puse el tipo de Display en "Unsigned", los valores se pueden observar en los siguientes Address:
0x10000048
0x10000064
0x10000060
0x1000005c
0x10000058
0x10000054
0x10000050
0x1000004c
0x10000048
(Estos Address tambien son visibles en la imagen anexada)

El codigo lo probe tanto en Visual Studio Code como en Ripes.me, En visual studio Code me salia un error a la hora de poner "ecall"
