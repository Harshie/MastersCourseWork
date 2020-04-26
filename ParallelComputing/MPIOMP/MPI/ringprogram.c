#include<stdio.h>
#include <mpi.h>

int main(int argc, char **argv){
    
	int ierror,i;
    
	// Calling MPI_Init before any other MPI calls
    ierror=MPI_Init(&argc,&argv);

	//Declaring variables
	int taskid, ntasks;
    MPI_Status   status;
    MPI_Request	send_request,recv_request;
    int msg[2];

    	
	/* Get the number of MPI tasks and the taskid of this task.      */
	ierror=MPI_Comm_rank(MPI_COMM_WORLD,&taskid);
	ierror=MPI_Comm_size(MPI_COMM_WORLD,&ntasks);
	
	
	msg[0]=taskid;
	msg[1]=taskid;
	
	//Ring format  non-blocking communication
	for(i=0;i<ntasks;i++){
		if(taskid==0){
			ierror=MPI_Isend(&msg,2,MPI_INT,taskid+1,0,MPI_COMM_WORLD, &send_request );
			
			//The taskid =0 or root node or originator rank sends the message to its neighbour rank and receives message from its left neighbour.
			ierror=MPI_Irecv( &msg, 2, MPI_INT, ntasks-1, 0, MPI_COMM_WORLD, &recv_request );
		
		}
		else if(taskid==ntasks-1){
		
			ierror=MPI_Irecv(&msg, 2, MPI_INT, taskid-1, 0, MPI_COMM_WORLD, &recv_request);

			ierror=MPI_Isend(&msg,2,MPI_INT,0,0,MPI_COMM_WORLD,&send_request);
		}	
		else {
		
			ierror=MPI_Irecv(&msg, 2, MPI_INT, taskid-1, 0, MPI_COMM_WORLD, &recv_request);
		
			ierror=MPI_Isend(&msg,2,MPI_INT,taskid+1,0,MPI_COMM_WORLD,&send_request);
		}
	
		ierror=MPI_Wait(&send_request,&status);
		ierror=MPI_Wait(&recv_request,&status);	

		if(msg[0]!=taskid){
			msg[1]=msg[1]+taskid;
		}
		//The below step can be used to check if the program is in ring motion.
		//printf( "Process %d got msg ID %d and msgval %d\n", taskid, msg[0],msg[1] );
	
	
		if(i==ntasks-1)
		printf(" The sum of all tasks at the end of taskid = %d after communicating with other task Ids in a ring format is %d \n",taskid,msg[1]);
				
	}
	
    // Calling MPI_Finalize() at the end of MPI code block
    ierror=MPI_Finalize();
    return ierror;

}

/*------OP--------

[sp227@sciprog Assign2]$ mpicc -o ringprogram ringprogram.c
[sp227@sciprog Assign2]$ mpirun -n 4 ./ringprogram

 The sum of all tasks at the end of taskid = 0 after communicating with other task Ids in a ring format is 6
 The sum of all tasks at the end of taskid = 2 after communicating with other task Ids in a ring format is 6
 The sum of all tasks at the end of taskid = 3 after communicating with other task Ids in a ring format is 6
 The sum of all tasks at the end of taskid = 1 after communicating with other task Ids in a ring format is 6


*/