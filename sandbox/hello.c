#include <stdio.h>

int foo(int n) {
    int m, l;
    
    m = n - 5;
    l = n + 5;
    
    return m * l;
}

int main(void) {
    int i, j, k;
    
    i = 3;
    j = 42;
    k = 15;
    
    printf("Hello, Portland, %d!\n", foo(i*j*k));
    
    return 0;
}