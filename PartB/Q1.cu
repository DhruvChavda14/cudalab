#include<stdio.h>
#include<cuda.h>
__global__ void addNum(int* a,int *b, int* res){
    *res = *a + *b;
}
int main(){
    int host_a=5,host_b=10,host_res;
    int *deva,*devb,*devres;
    cudaMalloc((void**)&deva,sizeof(int));
    cudaMalloc((void**)&devb,sizeof(int));
    cudaMalloc((void**)&devres,sizeof(int));
    cudaMemcpy(deva,host_a,sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(devb,host_b,sizeof(int),cudaMemcpyHostToDevice);
    addNum<<<1,1>>>(deva,devb,devres);
    cudaMemcpyHostToDevice(&host_res, devres, sizeof(int), cudaMemcpyHostToDevice);
    printf("%d + %d = %d\n",host_a,host_b,host_res);
    cudaFree(deva);
    cudaFree(devb);
    cudaFree(devres);
}

// to compile - nvcc add.cu -o add
// to run - ./add or add.exe
