n = int(input()) # 피보나치 개수 n
list = [0] *(n+2)
list[0] = 0
list[1] = 1

for i in range(2,n+1,1): # 2번째 인덱스부터 n개까지
    list[i] = list[i-1] + list[i-2]

print(list[n])


'''
n=int(input())

if n==0:
    print(0)
elif n==1:
    print(1)
else :
    list = [0]*(n+2) #0과 1을 대입하기 위하여 리스트 공간이 최소 2칸은 존재함.

    list[0] = 0
    list[1] = 1

    for i in range(2,n+1):
        list[i] = list[i-1]+list[i-2]

    print(list[n])
'''

