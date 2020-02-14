//Jingkaihui Wei 81923885
//Yating Liu 10588498


#include <stdio.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int open_clientfd(char *hostname, int port){
    int clientfd;
    struct hostent *hp;
    struct sockaddr_in serveraddr;

    //create socket
    if ((clientfd=socket(AF_INET, SOCK_STREAM, 0))<0){printf("Socket creation error\n");return -1;}//IPv4 protocol, TCP connection

    //fill in the server's IP address and port
    if ((hp=gethostbyname(hostname))==NULL){printf("Can't get hostname\n");return -2;}
    bzero((char*) &serveraddr, sizeof(serveraddr));
    serveraddr.sin_family=AF_INET;
    bcopy((char*)hp->h_addr_list[0], (char*)&serveraddr.sin_addr.s_addr, hp->h_length);
    serveraddr.sin_port=htons(port);//turn into network order to open connection, if different, switch, if the same, do nothing

    //establish a connection with the server
    //the connect system call connects the socket referred to by the file descriptor clientfd to the address specified by addr
    if (connect(clientfd, (struct sockaddr*)&serveraddr, sizeof(serveraddr))<0){printf("Connection failed in open_clientfd function\n");return -1;}
    return clientfd;
}

int main(int argc, char **argv) {
    int clientfd;
    char *host=argv[1];
    int port=atoi(argv[2]);
    clientfd=open_clientfd(host, port);

    while (1) {
        char command[256];
        char message[256];
        char response[256];

        printf("> ");
        gets(command);//read all line, exclude empty line

        if (strcmp(command, "+++")==0)break;
        else{
            message[0]=(unsigned)strlen(command);
            message[1]='\0';
            strcat(message, command);
         

            write(clientfd, message, sizeof(message));
            read(clientfd, response, sizeof(response));

            int i;
            for (i=0;i<(int)response[0];i++)
                printf("%c", response[i+1]);//puts(response[i])
            printf("\n");
           
            
            //not work  
            /**  
            fputs(response, stdout);
            fflush(stdout);
            printf("\n");
            **/
        }

    }
    close(clientfd);
    return 0;
}
