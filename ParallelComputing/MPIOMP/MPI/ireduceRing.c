#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
 
int main(int argc, char* argv[])
{
	int ierror;
    
	ierror=MPI_Init(&argc, &argv);
 
    // Determine root's rank
    int root_taskid = 0;
 
    /* Get the number of MPI tasks and the taskid of this task.      */
    int taskid,ntasks;
    ierror=MPI_Comm_rank(MPI_COMM_WORLD, &taskid);
	ierror=MPI_Comm_size(MPI_COMM_WORLD,&ntasks);
 
    // Each MPI process sends its rank to reduction, root MPI process collects the result
    int reduction_result = 0;
    MPI_Request request;
    ierror= MPI_Ireduce(&taskid, &reduction_result, 1, MPI_INT, MPI_SUM, root_taskid, MPI_COMM_WORLD, &request);
 
    
    	
    // Wait for the MPI_Ireduce to complete
    ierror= MPI_Wait(&request, MPI_STATUS_IGNORE);
 
    if(taskid == root_taskid)
    {
        printf("The sum of all tasks at the end of taskid = %d after communicating with other task Ids in a ring format is %d.\n", root_taskid,reduction_result);
    }
 
	/* bcast is called by every processor, data is taken from root and stored up in every other taskid buf */
       ierror= MPI_Bcast(&reduction_result, 1, MPI_INT, root_taskid, MPI_COMM_WORLD);

        printf("After Bcast, the sum of all tasks at the end of taskid = %d in ring format is %d\n", taskid, reduction_result);
 
    MPI_Finalize();
 
    return ierror;
}


/*---OP---
[sp227@sciprog Assign2]$ mpicc -o ireduceRing ireduceRing.c
[sp227@sciprog Assign2]$ mpirun -n 4 ./ireduceRing

The sum of all tasks at the end of taskid = 0 after communicating with other task Ids in a ring format is 6.
After Bcast, the sum of all tasks at the end of taskid = 0 in ring format is 6
After Bcast, the sum of all tasks at the end of taskid = 1 in ring format is 6
After Bcast, the sum of all tasks at the end of taskid = 2 in ring format is 6
After Bcast, the sum of all tasks at the end of taskid = 3 in ring format is 6

*/