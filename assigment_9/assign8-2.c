/*
Name : Noor Alaskari
Class :  System  programming 
Profesor : Dr. Sam Silvestro 
Date : 29/11/2019
Assigment:  Process Control-2 Extra Credit
*/
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <stdlib.h>

#define commands 2 // Declaring const

int main(int argc, char *argv[])
{
  long lForkPidLs, lForkPidSort;
  int iExitStatus = 0;
  long lWaitPid;
  int iReadFd, iWriteFd;
  int fdM[2];
  char CMD[commands][69];
  int numOfCommands = 0;
  char *currentarg[999];
  char *ptr;
  char curr[64];

  memset(&curr, 0, sizeof(curr)); // Clearing The Array for later Usage
  memset(&CMD, 0, sizeof(CMD));   // Clearing The Array for later Usage

  for (int i = 1; i < argc; i++)
  {
    if (numOfCommands > 2)
    {
      printf("Too many arguments supplied.\n");
      break;
    }

    if (strcmp(strtok(argv[i], " "), ",") != 0)
    {
      strcat(curr, strtok(argv[i], " "));
      strcat(curr, " ");
    }

    if (strcmp(strtok(argv[i], "  "), ",") == 0 || i + 1 == argc)
    {
      strcat(CMD[numOfCommands], curr);
      memset(&curr, 0, sizeof(curr));
      numOfCommands++;
    }
  }

if(pipe(fdM) == -1) {
  perror("pipe failed");
}
 
 switch (lForkPidLs = fork())
  {
  case -1:
    perror("fork failed: ");
  case 0:

    if (dup2(fdM[1], STDOUT_FILENO) == -1)
      perror("Failed to rediect stdout for: ");
      close(fdM[0]);
      close(fdM[1]);
      ptr = strtok(CMD[0], " ");
      int count = 0;

        while (ptr != NULL)
        {
          currentarg[count] = ptr;
          ptr = strtok(NULL, " ");
          count++;
        }

        currentarg[count] = NULL;

        //printf("Child Process: PID=%ld, PPID=%ld , Command:%s \n", (long)getpid(), (long)getppid(), currentarg[0]);
        if (execvp(currentarg[0], currentarg) == -1)
        {
          exit(1);
        }
        break;
  default: // parent
    switch (lForkPidSort = fork())
    {
    case -1:
      perror("fork of second child failed: ");
    case 0:
      if (dup2(fdM[0], STDIN_FILENO) == -1)
          perror("Failed to rediect stdin : ");
      close(fdM[0]);
      close(fdM[1]);

      ptr = strtok(CMD[1], " ");
      int count =0;
       

      while (ptr != NULL)
      {
        currentarg[count] = ptr;
        ptr = strtok(NULL, " ");
        count++;
        printf(ptr);
      }

      currentarg[count] = NULL;

      //printf("Child Process: PID=%ld, PPID=%ld , Command:%s \n", (long)getpid(), (long)getppid(), currentarg[0]);
      if (execvp(currentarg[0], currentarg) == -1)
      {
        exit(1);
      }

      break;
      perror("Failed to exec '");
    default: 
      close(fdM[0]);
      close(fdM[1]);
    }
  }
  
   for (int j = 0; j < numOfCommands; j++)
  {
    if (lForkPidLs > 0){
      iExitStatus =0;
      lWaitPid= wait(&iExitStatus);
      if(lWaitPid == -1){
        perror("Waiterro");
      }
    }
  }
  return 0;
}