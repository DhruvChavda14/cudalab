#include <stdio.h>
#include <cuda.h>

#define N 512

__global__ void dotProduct(int *a, int *b, int *result, int n)
{
    __shared__ int partialSum[256];

    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int threadID = threadIdx.x;
    partialSum[threadID] = 0;

    if (tid < n)
    {
        partialSum[threadID] = a[tid] * b[tid];
    }

    __syncthreads();

    for (int stride = blockDim.x / 2; stride > 0; stride /= 2)
    {
        if (threadID < stride)
        {
            partialSum[threadID] += partialSum[threadID + stride];
        }
        __syncthreads();
    }

    if (threadID == 0)
    {
        atomicAdd(result, partialSum[0]);
    }
}

int main()
{
    int host_a[N], host_b[N], host_result = 0;
    int *dev_a, *dev_b, *dev_result;

    for (int i = 0; i < N; i++)
    {
        host_a[i] = i + 1;
        host_b[i] = i + 2;
    }

    size_t size = N * sizeof(int);
    cudaMalloc((void **)&dev_a, size);
    cudaMalloc((void **)&dev_b, size);
    cudaMalloc((void **)&dev_result, sizeof(int));

    cudaMemcpy(dev_a, host_a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, host_b, size, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_result, &host_result, sizeof(int), cudaMemcpyHostToDevice);

    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

    dotProduct<<<blocksPerGrid, threadsPerBlock>>>(dev_a, dev_b, dev_result, N);

    cudaMemcpy(&host_result, dev_result, sizeof(int), cudaMemcpyDeviceToHost);

    printf("Dot product: %d\n", host_result);

    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_result);

    return 0;
}

// to compile - nvcc add.cu -o add
// to run - ./add or add.exe