'''
숫자 세기 5. 1~N의 수를 나열할 때, 숫자 M이 나오는 횟수를 구하여라(M의 범위는 0~9)
예시) N = 22 , M = 1
답) 13
'''

# 빈 리스트를 하나 만든다.
temp = [0,0,0,0,0,0,0,0,0,0] # 0 ~ 9 까지

for num in range(1, 99726): # 1부터 22까지 숫자 나열
    # print(num)
    for i in str(num):
        temp[int(i)] += 1

# print(temp)

for k in range(0,10):
    print(k, ":", temp[k], "개")
