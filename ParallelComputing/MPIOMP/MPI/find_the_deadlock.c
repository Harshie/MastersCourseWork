#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
FILE *fr;

int main(int argc, char **argv){ 
   int i, ierr, rank, nprocs; 
   long elapsed_seconds;
   int indata[25];
   char buf[256];

   ierr = MPI_Init(&argc,&argv);
   ierr = MPI_Comm_rank(MPI_COMM_WORLD, &rank); 
   ierr = MPI_Comm_size(MPI_COMM_WORLD, &nprocs);

   if (rank == 0 ) {
    /* open the file for reading */ 
      fr = fopen ("values.dat", "rt");

      /* fill indata */
      i = 0;
      while (!feof(fr)) {
        fscanf(fr, "%d", &indata[i]);
        i = i + 1;
     }
      /* close the file */
     fclose(fr);

    //ierr = MPI_Bcast( indata, 25, MPI_DOUBLE, 1, MPI_COMM_WORLD); 
   }
   //Deadlock - This Bcast should be out of rank 0 if block.
   //Bugs- The array variable indata is of Int type. Here, in broadcast, it is written as Double. This is changed to MPI_INT. Also, the source processor is mentioned as 1,but it //should be '0'- the root processor.
    
	ierr = MPI_Bcast( indata, 25, MPI_INT, 0, MPI_COMM_WORLD); 
     // output process rank 0 in file output.0
     // output process rank 1 in file output.1
     // output process rank 2 in file output.2 
     // and so on ...

     snprintf(buf, sizeof(buf), "output.%d", rank); 
	 //The output files are opened with write mode.
	 fr=fopen(buf,"wt");

     i = 0;
     while ( i<25 ) {
       fprintf(fr, "%d\n", indata[i]);
       i = i + 1; 
     }
	 //After the data is written to file, fclose function closes the file.
	fclose(fr);
   ierr = MPI_Finalize();
   return 0;
}

/*-------Debugging deadlocks and bugs-------
-The Broadcast function was inside if block of rank = 0. It was moved out of it. (Line 34)
-The indata are declared to be int datatype. But in broadcast function, the buffer is defined as double. So, it is updated to MPI_INT. (Line 34)
-The data from the file is scanned by the root rank. But in broadcast function, it is mentioned as 1. So, it is updated to 0. (Line 34)
-Command fopen is added after snprintf to open the file for writing the data to the files. These files are created parallelly based on the number of processors. (Line 42) 
-After the data is written to file, fclose function closes the files. (Line 50)

---OP---
Program is run with 9 processors.
[sp227@sciprog Assignment2]$ mpicc -o deadlock find_the_deadlock.c
[sp227@sciprog Assignment2]$ mpirun -n 9 ./deadlock

-rwxr-xr-x 1 sp227 users  8416 Apr 25 21:40 deadlock
-rw-r--r-- 1 sp227 users  2151 Apr 25 21:40 find_the_deadlock.c
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.0
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.1
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.2
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.3
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.4
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.5
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.6
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.7
-rw-r--r-- 1 sp227 users    66 Apr 25 21:41 output.8

*/