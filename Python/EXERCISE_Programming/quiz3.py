''' 
quiz 3
각 스킬을 배우기 위한 스킬 포인트를 구하시오.

상위 스킬을 배우기 위해서는 하위 스킬을 배워야 한다

예시는 이중리스트 구조
[[상위 스킬, 하위 스킬], [상위 스킬, 하위 스킬], ...], 모든 스킬을 찍기 위한 스킬포인트

예시
total_sp = 121
skills = [[1, 2], [1, 3], [3, 4], [3, 5], [3, 6]]
1 스킬은 2, 3 스킬을 배워야 사용 가능
3 스킬은 4, 5, 6 스킬을 배워야 사용 가능

2, 4, 5, 6 스킬은 자신보다 하위 스킬이 없다
1, 3은 자신보다 하위 스킬이 존재
1스킬: 44point, 2스킬: 11point, 3스킬: 33point, 4스킬: 11point, 5스킬: 11point, 6스킬: 11point

스킬의 상하관계 그림은 카톡방의 사진을 참고하세요.

정답: answer = [44, 11, 33, 11, 11, 11]
다른 예시도 실행해보세요
total_sp = 20
skills = [[1, 2], [1, 3], [3, 4], [3, 5], [3, 6], [4, 7], [4, 8], [4, 9]]
answer = [6, 1, 5, 3, 1, 1, 1, 1, 1]
''' 


total_sp = 20
skills = [[1, 2], [1, 3], [3, 4], [3, 5], [3, 6], [4, 7], [4, 8], [4, 9]]

def solution(skills, total_sp):
        nodes = set()
        for skill in skills:
                nodes.add(skill[0])
                nodes.add(skill[1])
        nodes = list(nodes)
        print(nodes) 

        dict_tree = {}
        for node in nodes:
                dict_tree[node] = 1
        print(dict_tree)

        for skill in skills:
                temp = dict_tree.get(skill[0])
                dict_tree[skill[0]] = temp+1
        print(dict_tree)

        dict_values = list(dict_tree.values())
        base_sp = total_sp // sum(dict_values)
        print(base_sp)

        dict_values = list(map(lambda x: x-1 if x>1 else x, list(dict_tree.values())))
        print(dict_values)

        result_dict = {}
        count = 0 
        for node in nodes:
                result_dict[node] = dict_values[count]
                count += 1
        print(result_dict)

        dict_skill = {}
        for stree in skills:
                if dict_skill.get(stree[0]):
                        temp = dict_skill.get(stree[0])
                        temp.append(stree[1])
                        dict_skill[stree[0]] = temp
                else:
                        temp = []
                        temp.append(stree[1])
                        dict_skill[stree[0]] = temp
        print(dict_skill)

        dict_skill_keys = list(dict_skill.keys())
        print(dict_skill_keys)

        for keys in dict_skill_keys:
                for i in dict_skill[keys]:
                        if i in dict_skill_keys:
                                result_dict[keys] += result_dict[i] - 1
        print(result_dict)

        answer = list(map(lambda x: x* base_sp, list(result_dict.values())))
        print(answer)

solution(skills, total_sp)


