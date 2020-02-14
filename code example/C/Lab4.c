//Jingkaihui Wei 81923885
//Yating Liu 10588498


#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define HEAP_SIZE 127

//block number, mask. pointer to block number, 1 byte
void set_block_num(int n, unsigned char *p){
    *p=(unsigned char)n;
}
int get_block_num(unsigned char *p){
    return (int)*p;
}
//block size&allocation. pointer to block size, 1 byte, the last bit is allocation bit
//the 7 bits store the size as a literal unsigned integer. right shift by 1 and convert to numeric type. to get allocation status, mask off the least significant bit
int get_block_size(unsigned char *p){
    return (int)((unsigned char)*p >> 1);
}
void set_block_size(int n, unsigned char *p){
    *p=((unsigned char)n << 1)|(*p & 0x1); //set block size, will not change allocation bit
}
//allocation status example
int check_allocated(unsigned char *p){
    return (int)(*p & 0x1);
}
int set_allocated(unsigned char *p){
    *p=(*p|0x1);
}
void reset_allocated(unsigned char *p){
    *p=(*p & 0xFE); //0x11111110
}


int main() {
    unsigned char *heap=(unsigned char*)malloc(HEAP_SIZE);
    int block_num=0;
    unsigned int i;

    //initialize a 127 size block
    set_block_num(block_num,heap);
    set_block_size(127, heap+1);
    reset_allocated(heap+1);

    while (1){
        char command[100];
        printf("> ");
        gets(command);//read all line, exclude empty line

        char *c1;
        char *c2;
        char *c3;
        char *c4;

        c1=strtok(command," ");
        //printf("command: %s", c1);
        //printf("hello");
        if (strcmp(c1, "quit")==0)break;
        else if (strcmp(c1,"allocate")==0){
            c2=strtok(NULL, " ");
            int a_block;
            a_block=atoi(c2);

            unsigned char *p=heap;
            while (p<(heap+126) && (check_allocated(p+1) || get_block_size(p+1)<a_block+2))
                p=p+get_block_size(p+1);


            /**
            printf("%d\n", get_block_num(heap));
            printf("%d\n", get_block_size(heap+1));
            printf("%d\n", check_allocated(heap+1));
            **/


            if (p<(heap+126)){
                //if exactly the same size
                if (get_block_size(p+1)==a_block+2){
                    block_num++;
                    set_block_num(block_num,p);
                    set_allocated(p+1);
                }
                //we do split here
                else if (get_block_size(p+1)>a_block+2){
                    block_num++;
                    set_block_num(block_num,p);
                    set_allocated(p+1);
                    int new_block_size=get_block_size(p+1)-2-a_block;

                    if (new_block_size>2){
                        set_block_size(a_block+2,p+1);

                        set_block_size(new_block_size, p+a_block+3);
                        reset_allocated(p+a_block+3);

                    }

                }
            }
            else{
                printf("There is no available block for block size %d\n",a_block);
            }
            printf("%d\n",block_num);
        }

        else if (strcmp(c1,"free")==0){
            c2=strtok(NULL, " ");
            int f_blocknum;
            f_blocknum=atoi(c2);

            unsigned char *p;
            for (p=heap;p<heap+126;){
                if (check_allocated(p+1)==1){
                    if (get_block_num(p)==f_blocknum){
                        reset_allocated(p+1);
                        break;
                    }
                }
                p=p+get_block_size(p+1);
            }
            if (p>heap+125){
                printf("Block number not found.\n");
            }

        }

        else if (strcmp(c1,"writeheap")==0){
            c2=strtok(NULL, " ");
            int w_blocknum;
            w_blocknum=atoi(c2);

            c3=strtok(NULL, " ");
            c4=strtok(NULL, " ");
            int copies;
            copies=atoi(c4);

            unsigned char *p;
            for (p=heap;p<heap+126;){
                if (check_allocated(p+1)==1){
                    if (get_block_num(p)==w_blocknum){
                        if (copies>get_block_size(p+1)-2)
                            printf("Write too big\n");
                        else{
                            for (i=0;i<copies;i++){
                                *(p+2+i)=(unsigned char)*c3;
                            }
                        }
                        break;
                    }
                }
                p=p+get_block_size(p+1);
            }

            if (p>heap+125){
                printf("Block number not found.\n");
            }

        }

        else if (strcmp(c1,"blocklist")==0){
            int start_count=0;
            int end_count;
            printf("Size Allocated Start          End\n");

            unsigned char *p;
            for (p=heap;p<heap+126;){
                printf("%-5d", get_block_size(p+1));
                if (check_allocated(p+1)==1){
                    printf("%-10s", "yes");
                }
                else{
                    printf("%-10s", "no");
                }
                end_count=start_count+get_block_size(p+1)-1;
                printf("%-15d%-15d\n", start_count,end_count);

                start_count=end_count+1;
                p=p+get_block_size(p+1);
            }
        }

        else if (strcmp(c1,"printheap")==0){
            c2=strtok(NULL, " ");
            int blocknum;
            blocknum=atoi(c2);

            c3=strtok(NULL, " ");
            int num_bytes;
            num_bytes=atoi(c3);

            unsigned char *p;
            for (p=heap;p<heap+126;){
                if (check_allocated(p+1)==1){
                    if (get_block_num(p)==blocknum){
                        if (num_bytes>get_block_size(p+1)-2)num_bytes=get_block_size(p+1)-2;
                        for (i=0;i<num_bytes;i++){
                            printf("%c", (char)(*(p+2+i)));
                        }
                        printf("\n");

                        break;
                    }
                }
                p=p+get_block_size(p+1);
            }
            if (p>heap+125){
                printf("Block number not found.\n");
            }

        }

        else if (strcmp(c1,"printheader")==0){
            c2=strtok(NULL, " ");
            int blocknum;
            blocknum=atoi(c2);

            unsigned char *p;
            for (p=heap;p<heap+126;){
                if (check_allocated(p+1)==1){
                    if (get_block_num(p)==blocknum){
                        printf("%02X%02X\n",*p, *(p+1));
                        break;
                    }
                }
                p=p+get_block_size(p+1);
            }
            if (p>heap+125){
                printf("Block number not found.\n");
            }

        }

    }

    free(heap);
    return 0;

}
