n = int(input())
m = str(input())

n = list(map(str, range(1,n+1)))
count = 0

for j in n:
    for i in j:
        if m in i: count+=1


print(count)