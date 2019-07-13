# 세 정수 A, B, C가 주어진다. 이때, 두 번째로 큰 정수를 출력하는 프로그램을 작성하시오.
def cntnumber():
    N = list(map(int,input().split()))
    N = sorted(N)
    cnt = int(len(N)/2)
    return print(N[cnt])

cntnumber()





