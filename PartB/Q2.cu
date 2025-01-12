#include<stdio.h>
#include<cuda.h>
#define N 512
__global__ void addVectors(int *a,int *b, int *res, int n){
    int idx = threadIdx.x + blockIdx.x*blockDim.x;
    if(idx<n){
        res[idx] = a[idx] + b[idx];
    }
}

int main(){
    int host_a[N],host_b[N], host_res[N];
    int *dev_a,*dev_b,*dev_res;
    for(int i=0;i<N;i++){
        host_a[i]=i;
        host_b[i]=N-i;
    }
    cudaMalloc((void**)&dev_a,N*sizeof(int));
    cudaMalloc((void**)&dev_b,N*sizeof(int));
    cudaMalloc((void**)&dev_res,N*sizeof(int));
    cudaMemcpy(dev_a, host_a, sizeof(int) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, host_b, sizeof(int) * N, cudaMemcpyHostToDevice);
    int threadsPerBlock = 256;
    int blockPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;
    addVectors<<<blockPerGrid, threadsPerBlock>>>(dev_a,dev_b,dev_res,N);
    cudaMemcpy(host_res,dev_res,N*sizeof(int),cudaMemcpyHostToDevice);
    printf("Result (Top 10 results) : \n");
    for(int i=0;i<10;i++){
        printf("c[%d] : %d \n",i,host_res[i]);
    }
    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_res);
    return 0;
}

// to compile - nvcc add.cu -o add
// to run - ./add or add.exe