C = int(input())  # 테스트 케이스 수
answer = []
for i in range(C):  # 1 2 3 4 5
    case = list(map(int, input().split()))
    case_avg = sum(case[1:]) / case[0]  # 케이스 당 평균
    above_list = []  # 평균 상위인 사람을 담을 리스트

    for j in case[1:]:
        if j > case_avg:
            above_list.append(j)
    answer.append("%0.3f"%round(len(above_list) / len(case[1:])*100,3))

for t in answer:
    print("%s%%"%t)
    # %s:문자열 출력, %% : '%'문자 자체를 출력