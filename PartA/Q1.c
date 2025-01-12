#include<stdio.h>
#include<omp.h>
int main(){
    long num_steps = 1000000;
    double step = (1.0)/num_steps;
    double pi = 0.0;
    #pragma omp parallel{
        double sum = 0.0;
        int i;
        #pragma omp for
        for(i=0;i<num_steps;i++){
            double x = (i+0.5)*step;
            sum+=(4.0)/(1.0+x*x);
        }
        #pragma omp critical 
        {
            pi += sum*step;
        }
    }
    printf("Calculated value of pie : %.15f\n",pi);
}

// !gcc -fopenmp -o fileName fileName.c

