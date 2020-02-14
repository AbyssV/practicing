//Jingkaihui Wei 81923885
//Yating Liu 10588498

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>
#include <math.h>
#include <sys/wait.h>


//front is front index, end is end index
void search(int* numArray,int front, int end, int given_integer,int main_pid, int fd[2])
{
    pid_t first_half, second_half;

    int middle = (front+end)/2;

    if (front==end)
    {
        printf("pid %d, value: %d\n",getpid(),numArray[front]);
        if (numArray[front]==given_integer)
        {
            int buf=front;
            close(fd[0]); //close unused read end
            //printf("Search output: %d\n" , front);
            write(fd[1],&buf,sizeof(buf));
            exit(0); //exit normally
        }
    }

    else{

        first_half=fork();

        if (first_half==0)
        {
            search(numArray,front,middle,given_integer,main_pid,fd);
        }
        else //if (first_half>0)
        {

            second_half=fork();
            if (second_half==0)
            {
                search(numArray,middle+1,end,given_integer,main_pid,fd);
            }
        }
    }

    //waitpid(pid_t pid, int *wstatus, int options)
    waitpid(first_half, NULL, 0);
    waitpid(second_half, NULL, 0);

    exit(0);
}




int main(int argc, char *argv[])
{
    int given_integer = atoi(argv[2]);
    //printf("searching integer: %d with size %d\n",given_integer, sizeof(given_integer));

    FILE *file;

    file = fopen(argv[1], "r");
    if (file == NULL) perror ("Error opening file");


    //load file into array
    //assume input file format correct
    int numArray[10];
    char line[100]={0};
    char *new_line;
    int index=0;
    int array_size=0;


    if ((fgets(line,sizeof(line),file)) != NULL)
    {
        new_line = strtok(line," \n"); //remove "\n" character

        while (new_line!=NULL)
        {
            int temp;
            sscanf(new_line, "%d", &temp);
            new_line = strtok(NULL," ");
            numArray[index]=temp;
            index++;
            array_size++;
        }
    }

    //int len=sizeof(numArray)/sizeof(int);

    /**
    int len=array_size;
    printf("length is %d\n",len);
    printf("the element in numArray: ");
    int d=0;
    for (d=0; d<array_size; d++) {

        printf("%d ",numArray[d]);
    }
    printf("\n");
    
    **/
    
    int fd[2];
    pipe(fd);
    int buf,result,flag=0;


    pid_t pid;
    int main_pid = getpid();

    //search(numArray,0,array_size-1,given_integer, main_pid,fd);
    if ((pid=fork())==0)
    {
        search(numArray,0,array_size-1,given_integer, main_pid,fd);
    }
    else
    {
        waitpid(-1, NULL, 0);
    }

    close(fd[1]);//close unused write end


    while ((result=read(fd[0],&buf,sizeof(buf)))>0){
        printf("Search output: %d\n" , buf);
        flag=1;
    }


    if (flag==0)
        printf("Search output: -1\n");

    close(fd[0]);
   
    //printf("Program stops here");
    return 0;
}

