N = int(input())
number = str(input())
num_list = list(number)
# list(number) # 붙은 문자 한 글자씩 나누기.
result = 0 # 초기값 0

for each in num_list:
    result += int(each)

print(result)