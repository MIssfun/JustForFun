#include<stdio.h>
/*
 *a[] ���ڴ洢�ʺ�����꣨�±�Ϊ������ֵΪ������
 *b[] ���ڴ洢�����еı�ռ�����
 *c[] ���ڴ洢�������Խ��ߵı�ռ�����
 *d[] ���ڴ洢���̸��Խ��ߵı�ռ�����
 *main() �ݹ���������n�ʺ����������
 */

int a[20],b[20],c[40],d[40],n,t=0,k;

void output()
{
	for(k=1;k<=n;k++)
	{
		printf("%d,",a[k]);
	}
	printf("\nNo. %d \n",++t);
}

void try(int i)
{
	int j;
	for(j=1;j<=n;j++)
	{
		if(b[j]==0&&c[i+j]==0&&d[i-j+n]==0)
		{//�ж��Ƿ����жԽ��߶�û��ռ��
			a[i]=j;
			b[j]=c[i+j]=d[i-j+n]=1;
			if(i<n)
			{
				try(i+1);
			}
			else
			{
				output();
			}
			b[j]=c[i+j]=d[i-j+n]=0;
		}
	}
}
main()
{
	int i;
	printf("Please input the number of Queen:\n");
	scanf("%d",&n);
	for(i=1;i<=n;i++)
	{
		b[i]=0;
		c[i]=0;c[n+1]=0;
		d[i]=0;d[n+1]=0;
	}
	try(1);
}
