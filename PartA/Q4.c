#include<stdio.h>
#include<omp.h>
#define N 100

int main(){
    int a[N],b[N],sum[N],diff[N];
    for(int i=0;i<N;i++){
        a[i]=i;
        b[i] = N-i;
    }
    #pragma omp sections
    {
        #pragma omp section{
            for(int i=0;i<N;i++){
                sum[i]=a[i]+b[i];
            }
            printf("Addition completed by thread %d\n", omp_get_thread_num());
        }
        #pragma omp section{
            for (int i = 0; i < N; i++)
            {
                diff[i] = a[i] - b[i];
            }
            printf("Substraction completed by thread %d\n", omp_get_thread_num());
        }
    }
    printf("First 10 elements of the sum array:\n");
    for (int i = 0; i < 10; i++)
    {
        printf("sum[%d] = %d\n", i, sum[i]);
    }

    printf("First 10 elements of the difference array:\n");
    for (int i = 0; i < 10; i++)
    {
        printf("diff[%d] = %d\n", i, diff[i]);
    }

    return 0;
}