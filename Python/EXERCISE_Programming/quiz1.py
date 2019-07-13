#%% [markdown]
# ## 풀이1

#%%
cameras = [[60,1],[110,2],[170,5],[3220,6]]
limit_speed = 60


#%%
def quiz1(limit_speed, cameras):
    answer = 0
    
    for i in range(0, len(cameras)-1, 1):
        if (cameras[i+1][0]-cameras[i][0]) / (cameras[i+1][1]-cameras[i][1]) >= limit_speed:
            answer +=1 
    return answer


#%%
quiz1(limit_speed, cameras)

#%% [markdown]
# ## 풀이2: map, lambda 사용 

#%%
cameras = [[60,1],[110,2],[170,5],[3220,6]]
limit_speed = 60
var = []
var2 = []
for i in cameras:
    var.append(i[0])
    var2.append(i[1])


#%%
def quiz2(limit_speed, cameras):
    answer = 0
    
    for i in range(len(var)-1):
        if (list(map(lambda x: x, var))[i+1]-list(map(lambda x: x, var))[i]) / (list(map(lambda x: x, var2))[i+1]-list(map(lambda x: x, var2))[i]) >= limit_speed:
            answer +=1 
    return answer


#%%
quiz2(limit_speed, cameras)


