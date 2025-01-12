#include<stdio.h>
#include<cuda.h>
__global__ void display(int n){
    int idx = threadIdx.x + blockIdx.x*blockDim.x;
    if(idx<n){
        printf("Hello World in cuda Programming!!! from thread : %d\n",idx);
    }
}
int main(){
    int n;
    int threadsPerBlock,blocksPerGrid;
    printf("Enter number of messages : ");
    scanf("%d",&n);
    printf("Enter the number of threads per block: ");
    scanf("%d", &threadsPerBlock);
    blocksPerGrid = ((n+threadsPerBlock-1)/threadsPerBlock);
    display<<<blocksPerGrid,threadsPerBlock>>>(n);
    cudaDeviceSynchronize();
    return 0;
}

// to compile - nvcc add.cu -o add
// to run - ./add or add.exe