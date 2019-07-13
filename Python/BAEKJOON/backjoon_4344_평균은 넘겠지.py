C = int(input()) # 테스트케이스 수
answer = []
for k in range(C):
    case = list(map(int, input().split()))
    N = case[0]
    point = case[1:]
    avg = sum(point,0.0) / len(point)
    above_list = []
    for i in point:
        if i > avg:
            above_list.append(i)

    result = len(above_list) / len(point)
    answer.append(format(result,".3%"))

for j in answer:
    print(j)