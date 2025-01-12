#include<stdio.h>
#include<omp.h>
#define N 1000
#define CHUNK_SIZE 100

int main(){
    int a[N],b[N],c[N];
    for(int i=0;i<N;i++){
        a[i]=i;
        b[i]=N-i;
    }
    #pragma omp parallel for schedule(dynamic,CHUNK_SIZE)
    for(int i=0;i<N;i++) c[i]=a[i]+b[i];
    printf("First 10 elements of the result array:\n");
    for (int i = 0; i < 10; i++)
    {
        printf("c[%d] = %d\n", i, c[i]);
    }

    return 0;
}