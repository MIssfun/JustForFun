#include<stdio.h>
/*
 *w h �����������̵Ŀ�Ⱥͳ���
 *go[8][2] �洢���ߵ�8����������ı仯��
 *main ������������̴�С������������̣������·������������
 */
int count=0;
int w,h;
int chess[20][20];
int go[8][2]={{1,2},{1,-2},{-1,2},{-1,-2},{2,1},{2,-1},{-2,-1},{-2,1}};

int check(int x,int y)
{
	int flag=1;
	if(chess[x][y]!=0||x<1||x>w||y<1||y>h)
	  flag=0;
	return flag;
}

void output()
{
	int i,j;
	for(i=1;i<=w;i++)
	{
		for(j=1;j<=h;j++)
		  printf("%3d ",chess[i][j]);
		printf("\n");
	}
	printf("\n");
	count++;
}

void find(int x,int y,int dep)
{
	int i,xx,yy;
	for(i=0;i<8;i++)
	{
		xx=x+go[i][0];
		yy=y+go[i][1];
		if(check(xx,yy)==1)
		{
			chess[xx][yy]=dep;
			if(dep ==w*h )
			  output();
			else
			  find(xx,yy,dep+1);
			chess[xx][yy]=0;
		}
	}
}


main()
{
	int i,j;
	printf("Please input the width and heigth of chesspane:\n");
	scanf("%d%d",&w,&h);
	if(w>20||h>20||w<1||h<1)
	{
		printf("Input Error!\n");
	}
	for(i=1;i<=w;i++)
	{
		for(j=1;j<=h;j++)
		{
			chess[i][j]=0;
		}
	}
	chess[1][1]=1;
	find(1,1,2);
	if(count == 0)
	{
		printf("Non solution!\n");
	}
	else
	  printf("Total kind:  %d\n",count);
}
