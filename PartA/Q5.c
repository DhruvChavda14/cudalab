#include<stdio.h>
#include<omp.h>
#define N 100

int main(){
    int a[N],sum=0;
    for(int i=0;i<N;i++){
        a[i]=i+1;
    }
    #pragma omp parallel for reduction(+:sum)
    for(int i=0;i<N;i++){
        sum+=a[i];
    }
    printf("Sum of array elements: %d\\n", sum);
    return 0;
}