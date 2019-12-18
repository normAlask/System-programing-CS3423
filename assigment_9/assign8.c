/*
Name : Noor Alaskari
Class :  System  programming 
Profesor : Dr. Sam Silvestro 
Date : 29/11/2019
Assigment:  Process Control
*/
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <stdlib.h>

#define commands 6 // Declaring const


// Passing argument to C 
int main(int argc, char *argv[])
{
  char CMD[commands][600]; // 2D Array to store the Cmmands and its Arguemnt 
  char curr[64]; // Array to Cheack the Current Value
  int numOfCommands = 0; // Number of Command Passed after Spliting 
  long forkPid; // Forking the Procces Id 
  long waitPid; // Wait the Prosses Id
  int iExitStatus = 0; // Exit Statse for cheacking 
  char *currentarg[999];
  char *ptr;
  memset(&curr, 0, sizeof(curr)); // Clearing The Array for later Usage 
  memset(&CMD, 0, sizeof(CMD)); // Clearing The Array for later Usage 

  for (int i = 1; i < argc; i++)
  {
    if (numOfCommands > 5)
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

 
  for (int i = 0; i < numOfCommands; i++)
  {
    switch (forkPid = fork())
    {
    case -1:
      perror("fork failed: ");
      exit(1);
      break;

    case 0:
      ptr = strtok(CMD[i], " ");
      int count = 0;

      while (ptr != NULL)
      {
        currentarg[count] = ptr ;
        ptr = strtok(NULL, " ");
        count++;
      }

      currentarg[count]=NULL;

      printf("Child Process: PID=%ld, PPID=%ld , Command:%s \n",  (long)getpid(), (long)getppid(), currentarg[0]);
      if(execvp(currentarg[0],currentarg) == -1){
        exit(1);
      }   
      break;
    }
  }

  for (int j = 0; j < numOfCommands; j++)
  {
    if (forkPid > 0){
      iExitStatus =0;
      waitPid = wait(&iExitStatus);
      if(waitPid == -1){
        perror("Waiterro");
      }
    }
  }

  return 0;
}
