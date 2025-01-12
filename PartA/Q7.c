#include <stdio.h>
#include <omp.h>

#define N 1000

int main()
{
    int a[N];                 
    int largest_parallel = -1; 
    int largest_serial = -1;   

    
    for (int i = 0; i < N; i++)
    {
        a[i] = i * 2;
    }


    #pragma omp parallel for
    for (int i = 0; i < N; i++)
    {
        #pragma omp critical
        {
            if (a[i] > largest_parallel)
            {
                largest_parallel = a[i];
            }
        }
    }

    
    for (int i = 0; i < N; i++)
    {
        if (a[i] > largest_serial)
        {
            largest_serial = a[i];
        }
    }

    
    printf("Largest element (parallel): %d\n", largest_parallel);
    printf("Largest element (serial): %d\n", largest_serial);

    
    if (largest_parallel == largest_serial)
    {
        printf("The results match. Verification successful!\n");
    }
    else
    {
        printf("The results do not match. Verification failed!\n");
    }

    return 0;
}

// !gcc -fopenmp -o fileName fileName.c