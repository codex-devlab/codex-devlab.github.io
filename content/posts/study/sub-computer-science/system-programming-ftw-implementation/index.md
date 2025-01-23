---
title: "시스템프로그래밍 FTW 구현"
date: 2018-08-10T10:25:23+06:00
description: 알고리즘 문제풀이시 참고 할 수 있는 Tip 모음입니다.
menu:
  sidebar:
    name: 시스템프로그래밍 FTW 구현
    identifier: system-programming-ftw-implementation
    parent: sub-computer-science
    weight: 10
tags:
- Study
- System-Programming
- C
---

## FTW() 란?

ftw함수는 해당 경로안의 모든 디렉토리들을 탐색하여 보여준다.
## SYNOPSIS


`#include <ftw.h>`

int ftw(const char *path, int (*fn)(const char *, const struct sta *ptr, int flag),int depth);

int nftw(const char *path, int (*fn)(const char *, const struct stat *ptr, int flag, struct FTW *), int depth, int flags);

ftw는 path, fn, depth의 3가지 인자가 필요하다.

path : 탐색될 대상이 되는 경로.

fn : 탐색중 발견된 파일의 정보를 받는 콜백 포인터.

depth : 탐색중 몇개의 하위디렉토리를 탐색할것인지 설정.

return : 성공하면 0, 실패하면 0이외의 값, 에러가 검출되면 -1리턴

=>(C에서는 리턴값에 대한 정확한 이해가 필요합니다. 성공시 0을 리턴하며 실패시 0이외의 값을 리턴합니다.)

## Description
`FTW_F`  A regular file.

`FTW_D`    A directory being visited in pre-order.

`FTW_DNR`  A directory which cannot be read. The directory will not be descended into.

`FTW_DP`  A directory being visited in post-order (nftw() only).

`FTW_NS`   A file for which no stat(2) information was available.  The contents of the stat structure are undefined.

`FTW_SL`  A symbolic link.

`FTW_SLN` A symbolic link with a non-existent target (nftw() only)

## Source Code

```c
/*authored by Edward Son
 * 
 * 20161103
 * */
#include <sys/types.h>
#include <dirent.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>
void Myftw(char* path){
    DIR *dirptr; //탐색할 경로를 담을 디렉토리포인터
    struct dirent *dir; //디렉토리의 정보를 읽어올 포인터
    struct stat file_att; //디렉토리와 파일의 정보를 읽어올 구조체
    int i;
    //이것도 nuff해 보시지!
    char nuff[255]=" ";
    char space[]="----->";
    static int num =0;
   //opendir 로 포인터 개방
    if((dirptr = opendir(path))==NULL){
        printf("NO Such a directory");
        return; // Base step for Recursive call
    }
    if(chdir(path)<0){
        perror("No such path");
        exit(1);
    } 
        while((dir=readdir(dirptr))!=NULL){
            stat(dir -> d_name, &file_att);
               getcwd(nuff,1024);
            if(strcmp(".",dir->d_name)==0||strcmp("..",dir->d_name)==0)
                continue;
          //현재 경로안에 파일들 출력  
           if(S_ISREG(file_att.st_mode)){
              printf("Path : %s \n",nuff);
               if(num==1){
                   printf("file : %s %s\n",space,dir->d_name);
               }
               else{
                   printf("file : %s\n",dir->d_name);
               }
            }

          //하위 디렉토리가 있을때 해당 디렉토리로 이동
         else if(S_ISDIR(file_att.st_mode)){ //디렉토리 인지 확인
                printf("Path : %s \n",nuff);
                if(dir->d_ino !=0){  //디렉토리 안의 i_node #를 확인하여 순서대로 포인터 이동
                printf("directory : %s  %s\n",space,dir->d_name);
                }
                num++;
                Myftw(dir->d_name);
                num=0;
            }
        }

    chdir("..");
printf("************************\n");
}

int main(int argc, char** argv){
    if(argv[1]<0){
    perror("Not exist");
    exit(1);
    }
    else
        Myftw(argv[1]);
}
```


## Result

공부한지 얼마 안되어서 코딩실력이 많이 부족합니다. 어떤 의견이든 코드에 대해 수정할 부분이나 추가 의견 있으시면 댓글로 달아주세요~