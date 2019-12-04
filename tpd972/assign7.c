#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<stdarg.h>

typedef struct {
 char courseName [64];
 char courseSched [4];
 unsigned int courseHours ;
 unsigned int courseSize ;
    
} Course;


void create(FILE *jfile, Course course);
void read(FILE *jfile, Course course);
void update(FILE *jfile, Course course);
void Deletes(FILE *jfile, Course course);
void promptText();

int main() {

    char szInputBuffer[20];
    char userInput[20];
    FILE *jfile;
    Course course;
    course.courseHours=0;
    course.courseSize=0;
    course.courseName[0]= '\0';
    course.courseSched[0]= '\0';

    promptText();
        while(fgets(szInputBuffer, 19, stdin) != NULL) {
            sscanf(szInputBuffer, "%s", userInput);

        if(strcmp(userInput, "C") == 0 || strcmp(userInput, "c") == 0) {
            create(jfile, course);
           
        }

        else if(strcmp(userInput, "R") == 0 || strcmp(userInput, "r") == 0) {
            read(jfile, course);
        
        }

        else if(strcmp(userInput, "U") == 0 || strcmp(userInput, "u") == 0) {
            update(jfile, course);
        }

        else if(strcmp(userInput, "D") == 0 || strcmp(userInput, "d") == 0){
            Deletes(jfile, course);

        } else {
            printf("ERROR: invalid option\n");
        }
        strcpy(userInput, " ");
        promptText();

    }
    return 0;
}


void create(FILE *jfile, Course course) {
    int CourseNum;
    int seeking;
    int reading;
    int writing;

    printf("Enter a CS course number: ");
    scanf("%d", &CourseNum);
    getchar();

    jfile = fopen("courses.dat", "rb+");
    if(jfile == NULL) {
        jfile = fopen("courses.dat", "wb");
        fclose(jfile);
        jfile = fopen("courses.dat", "rb+");
    }
    seeking = fseek(jfile, ((CourseNum)*sizeof(Course)), SEEK_SET);  //seek for position in file
    reading = fread(&course, sizeof(course), 1L, jfile);  //check and if it is non-zero, mean item already exists in that position

    if(course.courseHours > 0) {
        printf("ERROR: course already exists\n");
    } else {

        printf("Course name: [It may include spaced]: ");
        scanf("%[^\n]", course.courseName);
        getchar();

        printf("Course schedule: ");
        scanf("%s", course.courseSched);
        getchar();
        

        printf("Course credit hours: ");
        scanf("%d", &course.courseHours);
        getchar();
    
        printf("Course enrollment: ");
        scanf("%d", &course.courseSize);
        getchar();

        seeking = fseek(jfile, ((CourseNum)*sizeof(Course)), SEEK_SET);
        writing = fwrite(&course, sizeof(course), 1L, jfile);
        if(writing != 1) {
            printf("Error writing course to file\n");
            exit(1);
        }

        fclose(jfile);     
    }
}

void read(FILE *jfile, Course course) {
    int CourseNum;
    int seeking;
    int reading;
    int writing;

    printf("Enter a CS course number: ");
    scanf("%d", &CourseNum);
    getchar();

    jfile = fopen("courses.dat", "rb"); 
    if(jfile == NULL) {
        jfile = fopen("courses.dat", "ab+");
        fclose(jfile);
        jfile = fopen("courses.dat", "rb");
    }

    seeking = fseek(jfile, ((CourseNum)*sizeof(Course)), SEEK_SET); 
    reading = fread(&course, sizeof(course), 1L, jfile);
    if(reading != 1) {
        printf("ERROR: course not found\n");
    }

    else if(course.courseHours > 0) {
        printf("\nCourse number: %d\n",CourseNum );
        printf("Course name: %s\n",course.courseName );
        printf("Scheduled days: %s\n", course.courseSched);
        printf("Credit hours: %d\n", course.courseHours);
        printf("Enrolled Students: %d\n\n", course.courseSize);
    } else {
        printf("ERROR: course not found\n");
    }   
    fclose(jfile);
}

void update(FILE *jfile, Course course) {
    Course course2;
    char curr[11];
    char max[11];
    int CourseNum;
    int seeking;
    int reading;
    int writing;
     

    printf("Enter a CS course number: ");
    scanf("%d", &CourseNum);
    getchar();

    jfile = fopen("courses.dat", "rb+"); 
    if(jfile == NULL) {
        jfile = fopen("courses.dat", "wb");
        fclose(jfile);
        jfile = fopen("courses.dat", "rb");
    }

    seeking = fseek(jfile, ((CourseNum)*sizeof(Course)), SEEK_SET); 
    reading = fread(&course, sizeof(course), 1L, jfile); 

    if(course.courseHours == 0) {
        printf("ERROR: course  not found\n");
    } else {

        printf("Course name[may contain spaces]: ");
        fgets(course2.courseName, 63, stdin);

        printf("Course schedule: ");
        fgets(course2.courseSched, 5, stdin);

        printf("Course credit hours: ");
        fgets(curr, 10, stdin);
       
        printf("Course enrollment : ");
        fgets(max, 10, stdin);
       
        if(strlen(max) != 0) {
            sscanf(max, "%d", &course.courseSize);
        }
        
        if(strlen(curr) != 0) {
            sscanf(curr, "%d", &course.courseHours);
        }
       
        if(strlen(course2.courseName) != 0) {
            sscanf(course2.courseName, "%[^\n]", course.courseName);
        }

        if(strlen(course2.courseSched) != 0) {
            sscanf(course2.courseSched, "%s", course.courseSched);
        }
        

       seeking = fseek(jfile, (CourseNum)*sizeof(Course), SEEK_SET);
       writing = fwrite(&course, sizeof(course), 1L, jfile);
       

    }

     fclose(jfile);
}

void Deletes(FILE *jfile, Course course){
    int CourseNum;
    int seeking;
    int reading;
    int writing;

    printf("Enter a CS course number: ");
    scanf("%d", &CourseNum);
    getchar();

    jfile = fopen("courses.dat", "rb+");
    if(jfile == NULL){
        jfile = fopen("courses.dat", "rb+");
        fclose(jfile);
        jfile = fopen("courses.dat", "rb+");
    }

    seeking = fseek(jfile, (CourseNum)*sizeof(Course), SEEK_SET); 
    reading = fread(&course, sizeof(course), 1L, jfile);

    if(reading == 0) {
        printf("ERROR: course  not found\n");
    } 
    else if(course.courseHours > 0) {
        course.courseHours  = 0;
        course.courseSize=0;
        memset(course.courseName,'\0',sizeof(course.courseName));
        memset(course.courseSched,'\0',sizeof(course.courseSched));
        


        seeking = fseek(jfile, (-1)*sizeof(Course),SEEK_CUR);
        writing = fwrite(&course , sizeof(course),1L,jfile);
        printf("\ncourse %d  was successfully deleted\n", CourseNum);
    }


    fclose(jfile);
}



void promptText() {
    printf("Enter one of the following actions or press CTRL-D to exit.\n");
    printf("C - create a new Course\n");
    printf("R - read an existing Course\n");
    printf("U - update an existing Course\n");
    printf("D - delete an existing Course\n");
    printf("User, enter your command: "); 

}
