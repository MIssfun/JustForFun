#include<stdio.h>
#include<stdlib.h>
#include<string.h>
/*
 * ���庯����har * fgets(char * s, int size, FILE * stream);
 * ����˵����fgets()�����Ӳ���stream ��ָ���ļ��ڶ����ַ����浽����s
 * ��ָ���ڴ�ռ�, ֱ�����ֻ����ַ��������ļ�β�����Ѷ���size-1 ���ַ�Ϊֹ
 * , �������NULL ��Ϊ�ַ�������.
 *puts(str)  ����ַ���
 *putchar(c) ����ַ�
 */
main()
{
	char inputs[1000];
	char buffer[100];
	while(1)
	{
		puts("Enter some text : ");
		fgets(buffer,100,stdin);
		strcat(inputs,buffer);
		if(strncmp(buffer,"end",3)==0)
		{
			break;
		}
	}
	printf("Your input is: \n%s",inputs);
}
