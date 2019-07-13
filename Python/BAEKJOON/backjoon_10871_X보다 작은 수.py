N, X = map(int,input(). split())
A = list(map(int, input().split()))
B = []


for i in A:
    if i < X:
        B.append(i)
    else:
        continue

for result in B:
    print(result)


