# 첫째 줄에는 별 1개, 둘째 줄에는 별 2개,
# N번째 줄에는 별 N개를 찍는 문제.

N = int(input())

for i in range(N):
    print("*"*(i+1))