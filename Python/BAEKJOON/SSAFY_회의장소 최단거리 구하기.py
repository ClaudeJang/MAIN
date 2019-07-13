'''
일차원 직선 상에서 여러 사람의 집이 있고, 집의 위치는 정수로 표현된다.
이 사람들이 회의를 위해 한 위치(그 곳에 집이 없어도 된다)에
모이고자 할 때, 모든 사람의 이동거리 합의 최소를 구하여라.
예시) 1 6
답) 5
'''


homes = list(map(int, input().split()))
homes.sort()

answer = 999999999999999999999999999999
pos = 0

for i in range(homes[0], homes[-1]+1):
    tmp = 0
    for home in homes:
        tmp += abs(home - i)

    if tmp <= answer:
        answer = tmp
        pos = i

print(answer, pos)