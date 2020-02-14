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

int open_listenfd(int port){
    int listenfd, optval=1;
    struct sockaddr_in serveraddr;

    if ((listenfd=socket(AF_INET, SOCK_STREAM, 0))<0){printf("Socket creation error\n");return -1;}

    //so you don't need to wait for the next connection. helps in reuse of address and port
    if (setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, (const void*)&optval, sizeof(int))<0){printf("Fail to set socket option\n");return -1;}

    bzero((char *)&serveraddr, sizeof(serveraddr));

    //after creation of the socket, bind function binds the socket to the address and port number specified in addr
    serveraddr.sin_family=AF_INET;
    serveraddr.sin_addr.s_addr=htonl(INADDR_ANY);//listenfd will be an endpoint for all requests to port on any IP address for this host
    serveraddr.sin_port=htons((unsigned short)port);
    //associates the socket with the socket address we just create
    if (bind(listenfd, (struct sockaddr*)&serveraddr, sizeof(serveraddr))<0){printf("Bind failed\n");return -1;}

    //waits for the client. the queue of pending connection can grow up to 5
    if (listen(listenfd, 5)<0){printf("Listen failed\n");return -1;}
    return listenfd;
}

int main(int argc, char **argv) {
    int listenfd, connfd, port;
    struct sockaddr_in clientaddr;
    int clientlen;
    //struct hostent *hp;
    //char *haddrp;
    //unsigned short client_port;

    port=atoi(argv[1]);
    listenfd=open_listenfd(port);

    char message[256];
    char response[256];
    char buf[256];

    while (1) {
        clientlen=sizeof(clientaddr);
        //fill in client port and IP address
        //accept returns a connected descriptor with the same properties as the listening descriptor

        //printf("Start to accept\n");
	if ((connfd=accept(listenfd, (struct sockaddr *)&clientaddr, &clientlen))<0){printf("Fail to accept\n");return -1;};

        //hp=gethostbyaddr((const char *) &clientaddr.sin_addr.s_addr, sizeof(clientaddr.sin_addr.s_addr), AF_INET);
        //haddrp = inet_ntoa(clientaddr.sin_addr);
        //client_port = ntohs(clientaddr.sin_port);
        printf("Address server started\n");

        while (read(connfd, message, 255)>0){
            int i;
            for (i=0;i<(int)message[0];i++){
                buf[i]=message[i+1];
            }
            buf[i]='\0';
            printf("%s\n", buf);

            if (strcmp(buf,"+++")==0)break;
            else if (strcmp(buf, "harris@ics.uci.edu")==0)
            {
                response[0] =(unsigned)strlen("Ian G. Harris");
                response[1]='\0';
                strcat(response, "Ian G. Harris");
            }
            else if (strcmp(buf, "joe@cnn.com")==0)
            {
                response[0] = (unsigned)strlen("Joe Smith");
                response[1]='\0';
                strcat(response, "Joe Smith");
            }
            else if (strcmp(buf, "jane@slashdot.org")==0)
            {
                response[0] = (unsigned)strlen("Jane Smith");
                response[1]='\0';
                strcat(response, "Jane Smith");
            }
            else{
                response[0]=(unsigned)strlen("unknown");
                response[1]='\0';
                strcat(response, "unknown");

            }
            write(connfd, response, strlen(response)*sizeof(char));
            read(connfd, message, 1);
        }
        close(connfd);

    }
    return 0;
}
