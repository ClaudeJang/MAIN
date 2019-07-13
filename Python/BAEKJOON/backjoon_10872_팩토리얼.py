'''
0보다 크거나 같은 정수 N이 주어진다. 이때, N!을 출력하는 프로그램을 작성하시오.
첫째 줄에 정수 N(0 ≤ N ≤ 12)가 주어진다.
첫째 줄에 N!을 출력한다.
'''
N = int(input()) # 12
# 12! = 1 * 2 * 3...*12

if N ==0:
    result = 1

else:
    list = []
# print(list)
    result = 1
    for i in range(1,N+1,1):
        list.append(i)
    # print(list)

    for j in list:
        result *= j

print(result)



