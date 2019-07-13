
'''
# 재귀 함수 
# 함수 안에서 함수 본인을 실행하여 반복하는 방법 

def recursion_print():
    print('함수 실행') 
    return recursion_print()

def a(n):
    if n == 1:
        return 0 
    return a(n-1) + 2 

print(a(1))
print(a(2))
print(a(3))
print(a(10))

def fib(n):
    if n == 0:
        return 0 
    elif n == 1:
        return 1        

def fib(n):
     if n < 2:
        return n
     return fib(n-1) + fib(n-2) 

print(fib(10))
'''
# personal_info = {
#     'name' : 'aldonza',
#     'age' : 20,
#     'nickname' : 'dulcinea'
# }

# print(personal_info['name'])
# print(personal_info['age'])
# print(personal_info['nickname'])

# a = {'x': 1, 'y': 2}
# a
# a['x']
# a['z']

# dict 객체 또한 dict 클래스로 생성가능 

# help(dict)

# dict 클래스를 통해 생성하면 다음과 같다. 
# personal_info2 = dict(name = 'aldonza', age= 20, nickname = 'dulcinea')

# print(personal_info2['name'])
# print(personal_info2['age'])
# print(personal_info2['nickname'])
# # personal_info2['name'] = 'john'
# for key in personal_info2:
#     print(key)
    
# for key in personal_info2:
#     print(personal_info2[key])

a = {'x' : 1, 'y' : 2}
b = {'z' : 3}
a.update(b)
print(a) 

