#include<stdio.h>
#include<omp.h>

int main(){
    #pragma omp parallel {
        int num_threads = omp_get_num_threads();
        int thread_id = omp_get_thread_num();
        int num_procs = omp_get_num_procs();
        int in_parallel = omp_get_in_parallel();
        #pragma omp critical{
            printf("Thread %d out of %d threads:\n", thread_id, num_threads);
            printf("  Number of processors available: %d\n", num_procs);
            printf("  In parallel region: %s\n", in_parallel ? "Yes" : "No");
        }
    }
    return 0;
}




// !gcc -fopenmp -o fileName fileName.c