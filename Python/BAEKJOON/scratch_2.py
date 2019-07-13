
def subarraysDivByK():
    A = [4,5,0,-2,-3,1]
    K = 5
    summ = 0
    res = 0
    dic = {0:1}
    for a in A:
        summ = (summ + a) % K
        # print(summ)
        if summ in dic:
            res += dic[summ]
            dic[summ] += 1
        else:
            dic[summ] = 1
    return print(res)

subarraysDivByK()
