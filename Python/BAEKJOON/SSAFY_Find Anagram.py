'''
문자열 A와 B가 주어진다.
A의 부분문자열 중 문자열 B와 아나그램 관계인 수를 구하여라.
(문자의 순서를 바꾸어 같은 문자열이 될 수 있는 것)
'''

import collections

A = input()
B = input()

answer = 0
check = collections.Counter(B)


for i in range(len(A) - len(B) + 1):

    if check == collections.Counter(A[i:i+len(B)]):
        print(A[i:i + len(B)])
        answer += 1

print(answer)
