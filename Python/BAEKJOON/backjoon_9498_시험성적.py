'''
시험 점수를 입력받아 90 ~ 100점은 A, 80 ~ 89점은 B, 70 ~ 79점은 C,
60 ~ 69점은 D, 나머지 점수는 F를 출력하는 프로그램을 작성하시오.
'''

pt = int(input())

if pt >= 90 and pt <= 100 :
    print('A')
elif pt >= 80 and pt <= 89 :
    print('B')
elif pt >= 70 and pt <= 79 :
    print('C')
elif pt >= 60 and pt <= 69 :
    print('D')
else :
    print('F')

