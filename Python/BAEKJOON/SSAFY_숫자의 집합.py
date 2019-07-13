import collections

m = list(map(int, input().split()))

m.sort()

print(len(set(m)))
print(len(m))
print(m)

print(collections.Counter(m))

