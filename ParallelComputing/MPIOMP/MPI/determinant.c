#include <stdio.h>
#include <mpi.h>

float determinant(float matrix[4][4]);
 
int main(int argc, char* argv[])
{
	int ierror;
	
	float actualval= -2678797333.0/88905600000;
	
	ierror= MPI_Init(&argc, &argv);
	float matrix4[4][4];
	float det=0,totaldet=0;
	int i,j,flag=0;
	int taskid, ntasks;
	
	//Initialization of 5*5 matrix
	float matrix[5][5]={
						{1,-1.0/2,-1.0/3,-1.0/4,-1.0/5},
						{-1.0/2,1.0/3,-1.0/4,-1.0/5,-1.0/6},
						{-1.0/3,-1.0/4,1.0/5,-1.0/6,-1.0/7},
						{-1.0/4,-1.0/5,-1.0/6,1.0/7,-1.0/8},
						{-1.0/5,-1.0/6,-1.0/7,-1.0/8,1.0/9}};
	
   
    /* Get the number of MPI tasks and the taskid of this task.      */
    ierror=MPI_Comm_rank(MPI_COMM_WORLD,&taskid);
    ierror=MPI_Comm_size(MPI_COMM_WORLD,&ntasks);
    MPI_Request request;
	
	//Spliting the 5*5 matrix to its 4*4 cofactor matrix
	for(i=1;i<5;i++){
	flag=0;	
	for(j=0;j<5;j++){
			if(j!=taskid){
				if(flag==0)
						matrix4[i-1][j]=matrix[i][j];
					else
						matrix4[i-1][j-1]=matrix[i][j];
				}
				else
					flag=1;
		}
	}
	
	if(taskid%2==0)
		det=matrix[0][taskid] * determinant(matrix4);
	else
		det=(-1)*matrix[0][taskid] * determinant(matrix4);

	ierror = MPI_Ireduce(&det, &totaldet, 1, MPI_FLOAT, MPI_SUM, 0,MPI_COMM_WORLD,&request);

	// Wait for the MPI_Ireduce to complete
    ierror=MPI_Wait(&request, MPI_STATUS_IGNORE);
	
	// Print the result
	if (taskid == 0) {
		printf("\n The actual value provided in the question is %f\n",actualval);
		printf("The determinant of the given 5*5 matrix using 5 processes is %f which is equal to the actual value mentioned above.\n",totaldet);
	}

	ierror=MPI_Finalize();
	return ierror;
}

//The function is used for calculating the determinant based on Cramer's rule of the splitted 4*4 matrix 
float determinant(float matrix[4][4])
{
	float matrixnew[3][3],array[4],detval[4],totaldeterminant=0;
	int i,j,k,flag=0;
	float num;
	
	for(i=0;i<4;i++){
		if(i%2==0)
			array[i]=matrix[0][i];
		else
			array[i]=(-1)*matrix[0][i];
	}
	
	//3*3 sub matrix and calculating its determinant.
	for(k=0;k<4;k++){
		for(i=1;i<4;i++){
			flag=0;
			for(j=0;j<4;j++){
				if(j!=k){
					if(flag==0)
						matrixnew[i-1][j]=matrix[i][j];
					else
						matrixnew[i-1][j-1]=matrix[i][j];
				}
				else
					flag=1;
			}
		}
		detval[k]= array[k]*( matrixnew[0][0] * ((matrixnew[1][1]*matrixnew[2][2]) - (matrixnew[2][1]*matrixnew[1][2])) 
							-matrixnew[0][1] * (matrixnew[1][0]* matrixnew[2][2] - matrixnew[2][0] * matrixnew[1][2]) 
							+ matrixnew[0][2] * (matrixnew[1][0] * matrixnew[2][1] - matrixnew[2][0] * matrixnew[1][1]));
		totaldeterminant = totaldeterminant + detval[k];
	}
	printf("\n The determinant of the given 4*4 matrix calculated using Cramer's rule of its respective taskID is %f",totaldeterminant);
	return totaldeterminant;

}

/*-------OP-------
[sp227@sciprog Assign2]$ mpicc -o determinant determinant.c
[sp227@sciprog Assign2]$ mpirun -n 5 ./determinant

 The determinant of the given 4*4 matrix calculated using Cramer's rule of its respective taskID is -0.014407
 The determinant of the given 4*4 matrix calculated using Cramer's rule of its respective taskID is -0.007223
 The determinant of the given 4*4 matrix calculated using Cramer's rule of its respective taskID is 0.012464
 The determinant of the given 4*4 matrix calculated using Cramer's rule of its respective taskID is -0.016362
 The determinant of the given 4*4 matrix calculated using Cramer's rule of its respective taskID is 0.019336
 The actual value provided in the question is -0.030131
The determinant of the given 5*5 matrix using 5 processes is -0.030131 which is equal to the actual value mentioned above.


*/
