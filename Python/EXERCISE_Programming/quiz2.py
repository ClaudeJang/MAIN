
#%%
foods = ['alex pizza rice hamburger', 'bob pasta salad', 'alex rice noodle', 'tom salad rice pizza meat']
#%%
dict = {}
cnt = 0

for i in foods:
    element = i.split(' ')
    if element[0] not in dict.keys():
        dict[element[0]] = element[1:]
    else:
        dict[element[0]].extend(element[1:])
# key와 value 나눔. 
# print(dict)
# 각 사람별 먹은 음식 개수 세기

#%%
name = list(dict.keys())
food = list(dict.values())

for x in range(len(food)):
    if len(set(food[x])) > cnt:
        answer = []
        answer.append(name[x])
        cnt = len(set(food[x]))
        # 먹은 음식이 cnt보다 크면, 가장 많이 먹은 사람 이름을 추가
        # cnt는 1위 기록으로 갱신 
    
    elif len(set(food[x])) == cnt:
        answer.append(name[x])
        # 먹은 음식 개수가 동일할 때 이름만 추가. 

answer.sort() # 이름 정렬

#%%
def quiz2(foods):
    dict = {}

    for i in foods:
        element = i.split(' ')
        if element[0] not in dict.keys():
            dict[element[0]] = element[1:]
        else:
            dict[element[0]].extend(element[1:])

    have_name = list(dict.keys())   
    have_food = list(dict.values())
    answer = []
    cnt = 0 

    for x in range(len(have_food)):
        
        if len(set(have_food[x])) > cnt:
            answer.append(have_name[x])
            cnt = len(set(have_food[x]))
        elif len(set(have_food[x])) == cnt:
            answer.append(have_name[x])
    
    answer.sort()

    return print(answer)


#%% 
quiz2(foods)