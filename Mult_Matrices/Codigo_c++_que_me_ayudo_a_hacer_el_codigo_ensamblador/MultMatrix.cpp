#include <iostream>
using namespace std;

int main() {
    // Matrices predefinidas 3x3
    int A[3][3] = {
        {0, 2, 4},
        {6, 8, 10},
        {12, 14, 16}
    };
    int B[3][3] = {
        {16, 14, 12},
        {10,8, 6},
        {4, 2, 0}
    };
    
    // Matriz resultado C inicializada a ceros
    int C[3][3] = { {0} };
    
    // Multiplicación A * B = C
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            for (int k = 0; k < 3; ++k) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    
    // No mostramos C según lo solicitado
    return 0;
}
