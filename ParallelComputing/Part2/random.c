#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
int *cycle;
int* randomarray(int n,int max);
int chopsearch(int i,int n,int arr[],int amin,int amax);

int* randomarray(int n,int max){
	
	int initialnum = 0,i;
	int* a1= malloc(n * sizeof(int));
	
  for (i = 0; i < n; i++)
  {
    a1[i] = rand()%max + 1;
    printf("%d ", a1[i]);
  }
  printf("\n");
  return a1;
}
int medium(int n,int arr[]){
	printf("\nIn Median");
	int a,b,i,j,k,smaller=0,larger=0,eqnum=1,median=-1;
	
	printf("\n n:%d",n);
	printf("\nThe array in median is:");
	for(i=0;i<n;i++){
		printf("\n%d",arr[i]);
	}
	
	for(i=0;i<n;i++){
		//Skip condition add
		for(j=0;j<n;j++){
			if(arr[i]<arr[j] && i!=j )
				larger=larger +1;
			if(arr[i]>arr[j] && i!=j )
				smaller=smaller +1;	
			
			if(arr[i]==arr[j] && i!=j)
				eqnum=eqnum+1;	
		}
		
		//printf("\n%d",arr[i]);
		//printf("\n L: %d,S :%d Eq:%d ",larger,smaller,eqnum);
		//larger=0;
		//	smaller=0;
		//	eqnum=1 ;
		if(larger==smaller){
			//printf("\nBoth are equal,L: %d,S :%d",larger,smaller);
			median=arr[i];
			break;
		}
		if(smaller!=larger && eqnum>1){
		
		for(k=1;k<=eqnum;k++){
			if((smaller + k)==larger){
			//	printf("\n 1Both are equal after adding eqnum %d,median is %d L: %d,S :%d",k,arr[i],larger,smaller);
			//	median=arr[i];
				if((n%2==0 && (smaller+k)==n/2) || (n%2!=0 && (smaller+k)==n/2)){
				median=arr[i];
				//eqnum=1;
				break;
			}
			}
			if(smaller==(larger+k)){
			//	printf("\n Both are equal after adding eqnum %d,median is %dL: %d,S :%d",k,arr[i],larger,smaller);
				if(n%2==0 && (larger+k)==((n/2) +1) || (n%2!=0 && (larger+k)==n/2)){
				median=arr[i];
				//eqnum=1;
				break;
			}
			}
			
		}
		
		}
		if(smaller!=larger )
		{
		//	printf("\nBoth are not equal,L: %d,S :%d",larger,smaller);
			larger=0;
			smaller=0;
			eqnum=1 ;
		}
		if(median != -1){
			break;
		}
			larger=0;
			smaller=0;
			eqnum=1 ;
		
	}	
//	printf("\nmedianin median func is: %d",median);	
	return median;
}

int mediansort(int m, int *cycle,int arr[],int sorted[]){
	printf("\nIn Median sort");
		int i,j,x,*arr1,mid=0,o,n,*arr2;
		arr1=arr;
		n=7;
		for(i=0;i<n;i++)
	{
		sorted[i] = -1;
	}
	printf("\nThe arr is\n");
		for(i=0;i<n;i++)
	{
		printf("%d",arr[i]);
	}
	printf("\nThe arr1 is\n");
		for(i=0;i<n;i++)
	{
		printf("%d",arr1[i]);
	}
	//	o=sizeof(*arr)/sizeof(arr[0]);
	//	m=sizeof(arr1)/sizeof(arr1[0]);
	//	printf("\nSize m: %d o:%d %d %d %d %d",m,o,sizeof(arr1),sizeof(arr1[0]),sizeof(*arr),sizeof(arr[0]));
		
		
	printf("\nArray arr1 is:");
	for(i=0;i<m;i++){
		printf("\n%d",arr1[i]);
	}
	

	printf("\nLength of M: %d",m);	
		x=medium(m,arr1);
		printf("\nMedian: %d",x);
		
		if(sorted[n/2]==-1){
		sorted[n/2]=x;
		
		printf("\nAssigning n/2 value:%d",x);
		}
		mid=sorted[n/2];
		printf("\nMid value:%d",mid);
	
	if(sorted[n/2]!=-1){
		if(x<mid){
			printf("\nLeft");
			for(i=n/2;i>0;i--){
				if(sorted[i]==-1)
					sorted[i]=x;
			}
		}
		if(x>mid){
			printf("\nRight");
			for(i=n/2;i>n;i++){
				if(sorted[i]==-1)
					sorted[i]=x;
		}
		
	}
	}
	for(i=0;i<n;i++){
			printf("\n%d",sorted[i]);
		}
	//printf("\nArray sorted is:");
	//for(i=0;i<n;i++){
	//	printf("\n%d",sorted[i]);
	//}
	
		
	/*	if(n%2==0){
			sorted[n/2]=x;
			cycle++;
		}
		else{
			sorted[n/2 +1] = x;
			cycle++;
		}
		*/
		//For reducing the array
	/*	for(i=0;i<m;i++){
		if(arr1[i]==x)
			break;
		}
		if(i<m){
			m=m-1;
			for(j=i;j<m;j++){
				arr1[j]=arr1[j+1];
				
			}
	*/		
		
		//	arr1 = (int*)realloc(arr1,m*sizeof(int));
		//	arr1=arr2;
/*		}
		printf("\nm:%d",m);
			printf("\nArray arr1 after reduced is:");
	for(i=0;i<m;i++){
		printf("\n%d",arr1[i]);
	}
	for(i=0;i<m;i++){
		arr2[i]=arr1[i];
	}
	for(i=0;i<m;i++){
		printf("\n%d",arr2[i]);
	}
	x=medium(m,arr2);
	
*/	
	/*arr2 = malloc(m*sizeof(int)); 
	arr2=arr1;
	for(i=0;i<m;i++){
		printf("new array %d",arr2[i]);
	}
       //free(arr1);
        
    
    arr1 = arr2;
    for(i=0;i<m;i++){
		printf("\nhhhhh%d",arr2[i]);
	}*/
		//return(mediansort(m,cycle,arr1,sorted));
	}

void mediansort(int n, int *cycle, int arr[], int sorted[])
{
	int Median, position, i,j,k; 


	//printf("\nCycle: %d\tn:%d\t", *cycle, n); // Commented debug print
	
	
	
		if(n==0){
			for(i=0;i<n;i++){
		printf("%d\t",sorted[i]);
		}
		return;
		} 
			
			
	Median = medium(n, arr); 
	printf("\nMetian:%d",Median);
	if(n % 2 == 1) // If n is odd
        {
                position = (n / 2) + 1; 
	}
	else // If n is even
	{
		position = (n / 2); 
	}

	i = position; 
	if(sorted[position-1] == -1) 
        {
                sorted[position-1] = Median; 
        }
        else 
        {
                while(sorted[i] != -1) 
                {       
                        i++;
                }
                sorted[i] = Median; 
        }
	sorted[-1] = -1;
	//For reducing the array
		for(j=0;j<n;j++){
		if(arr[j]==Median)
			break;
		}
		if(i<n){
			//m=m-1;
			for(k=i;k<n-1;k++){
				arr[k]=arr[k+1];
				
			}
		}

	++*cycle; // Increment cycle pointer

		mediansort(n-1, cycle, arr, sorted); 
}		

int search(int i,int n,int arr[]){
	int j,k,index=0;
	
	for(j=0;j<n;j++){
		if(arr[j]==i){
			index=j;
			break;
		}
		else if(arr[j]>i){
			printf("Count of index is :%d",j);
			break;
		}
	}
	return index;
	
}
int chopsearch(int i,int n,int arr[],int amin,int amax){
	int mid,j;
	if (amax >= amin) { 
       //int mid = low + (high - low) / 2; 
       int mid =rand() % (amax + 1 - amin) + amin;
    	//printf("The random middle index is %d of high index:%d,low index:%d\n",mid,high,low);
        
        if (arr[mid] == i){ 
        //printf("array[mid]:%d==i:%d\n",arr[mid],i);
            for(j=amin;j<=mid;j++){
            if(arr[j] == i){
                mid=j;
                return mid;
                exit(0);
                }
            }
        }
        if (arr[mid] > i) {
		    //printf("the value in middle arr[mid]:%d is > i:%d\n",arr[mid],i);
            return chopSearch(i,n,arr,amin,mid-1); 
  		}else{
  			//printf("the value in middle arr[mid] :%d is < i:%d\n",arr[mid],i);
  			return chopSearch(i,n,arr,mid+1,amax);
		  }
         
    } 
  
    return -1; 
} 

float benchmark_naive(int n, int max, int s, int mult)
{
	// Declare required variables
	struct timeval t0;
   	struct timeval t1;
   	float elapsed;

   	gettimeofday(&t0, 0); // Get current time of day

	// Declarations for median sorting
	int i, j, searchIndex;
	int* sorted = (int*) malloc(n * sizeof(int));
       	int cycount = 0;
       	int *cycle = &cycount;

	for(i=0;i<mult;i++) // Loop mult number of times
	{
		if(i%1000 == 0) // For every 1000 iterations of mult
		{
        		printf("I:%d\n", i); // Printing i
			int *arr = randomarray(n, max); // Generate random array

			for(j = 0; j < n; j++) // Initialize all sorted array elements to 0
        		{
        		        sorted[j] = -1;
        		}
		
        		mediansort(n, cycle, arr, sorted); // Sort the elements in sorted
		}
		searchIndex = search(s, n, sorted); // Search the s element in sorted array with normal search
	}
	
	gettimeofday(&t1, 0); // Get current time of day
  	elapsed = (t1.tv_sec - t0.tv_sec) * 1000.0f + (t1.tv_usec - t0.tv_usec) / 1000.0f; // Calculate time difference

	free(sorted); // Free memory of sorted array

	return elapsed; // Return elapsed time
}

// benchmark_chop
// Takes number of elements n, maximum max, search element s and multiples mult as input.
// Returns time taken as float.
float benchmark_chop(int n, int max, int s, int mult)
{
	// Declaring the variables
        struct timeval t0;
        struct timeval t1;
        float elapsed;
		 int i, j, searchIndex;
        int* sorted = (int*) malloc(n * sizeof(int));
        int cycount = 0;
        int *cycle = &cycount;
        gettimeofday(&t0, 0); 

	        int i, j, searchIndex;
        int* sorted = (int*) malloc(n * sizeof(int));
        int cycount = 0;
        int *cycle = &cycount;

        for(i=0;i<mult;i++) // Loop mult number of times
        {
                if(i%1000 == 0) // For every 1000 iterations of mult
                {
			printf("I:%d\n", i); // Printing i
                        int *arr = randomarray(n, max); // Generate random array

                        for(j = 0; j < n; j++) // Initialize all sorted array elements to 0
                        {
                                sorted[j] = -1;
                        }

                        mediansort(n, cycle, arr, sorted); // Sort the elements in sorted
		}
                searchIndex = chopsearch(s, n, sorted, 0, n-1); // Search the s element in sorted array with chop search
        }

        gettimeofday(&t1, 0); // Get current time of day
        elapsed = (t1.tv_sec - t0.tv_sec) * 1000.0f + (t1.tv_usec - t0.tv_usec) / 1000.0f; // Calculate time difference

        free(sorted); // Free memory of sorted array

        return elapsed; // Return elapsed time
}
int main()
{
	int n=0,max,i,p,*arr,median,m,j,len;
	int index=-1,searchval=0,amin,amax;
	printf("\n Please enter the number of random integers required :");
	scanf("%d",&n);

	printf("\n Please enter the maximum range for generating the random values: ");
	scanf("%d",&max);
		
	//int* a1= malloc(n * sizeof(int));
	int* sorted= malloc(n * sizeof(int));
	srand(time(NULL));
  	arr=randomarray(n,max);
  	for(i=0;i<n;i++){
  		//printf("%d\t",arr[i]);
	  }
//	for(i=0;i<10;i++){
//		printf("\n%d",b[i]);
//	}
	median=medium(n,arr);
//median=medium(7,b);
	for(i=0;i<n;i++){
//  		printf("%d\t",arr[i]);
	  }
	// printf("\nThe median is: %d",median); 
	mediansort(n,cycle,arr,sorted);
	printf("\nThe sorted array is :\n"); 
	for(i=0;i<n;i++){
		printf("%d",sorted[i]);
	}
	printf("Enter the element to search: ");
	scanf("%d",&searchval);
	index= search(searchval,n,sorted);
	if(index!= -1)
		printf("\n The Index of the requested vealue is:%d",index);
	else
		printf("\n The requested number is not available in the array :%d",index);
	chopsearch(searchval,n,sorted,amin,amax);	
	/*
m=7;
printf("\nm:%d",m);
		for(i=0;i<m;i++){
		printf("%d\t",b[i]);
	  }
	//For reducing the array
		for(i=0;i<m;i++){
		if(b[i]==median)
			break;
		}
		if(i<m){
			m=m-1;
			for(j=i;j<m;j++){
				b[j]=b[j+1];
			}
		}
		printf("\nm:%d",m);
		for(i=0;i<m;i++){
		printf("%d\t",b[i]);
	  }
	  len=sizeof(b)/sizeof(b[0]);
	  printf("\nlen%d",len);
	  b=realloc(b, m*sizeof(int));
		median=medium(m,b);*/
	return 0;
}
