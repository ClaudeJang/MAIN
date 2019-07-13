N = int(input())
pt = list(map(int,input().split()))
pt.sort()
M = pt[-1] # 최대값
Newpt = []
for i in pt:
    new = i/M*100
    Newpt.append(new)

result = sum(Newpt, 0.0) / len(Newpt)
# sum(리스트명, 0.0) 이렇게 해서 리스트 요소의 합계를 구함.

print(result)

