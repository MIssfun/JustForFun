#include <stdio.h>
#include <stdlib.h>

int a[20],n,sum=0;

void output(int n)
{
    int i;
    for(i=1;i<=n;i++)
        printf("%d, ",a[i]);
    printf("\n");
    sum++;
}

bool check(int k)
{
    int i;
    for(i=1;i<=k-1;i++)
    {
        if(abs(a[i]-a[k]) == abs(i-k) || a[i] == a[k])
            return false;
    }
    return true;
}
void backdate(int n)
{
    int k;
    a[1]=0;
    k=1;
    while(k>0)
    {
        a[k]=a[k]+1;
        while(a[k]<=n&&!check(k))
        {
            a[k]++;
        }
        if(a[k]<=n)
        {
            if(k == n) //�ҵ�һ��⣬���
                output(n);
            else
            {
                k++;
                a[k]=0;//�¸��ʺ��ͷ��ʼ����
            }
        }
        else
        {
            k--;
        }
    }
}

int main()
{
    printf("Please input the number of Queen:");
    scanf("%d",&n);
    printf("Start backdating and output the result:\n");
    backdate(n);
    printf("All backdate completed!\n");
    printf("Total kind: %d",sum);
    return 0;
}
