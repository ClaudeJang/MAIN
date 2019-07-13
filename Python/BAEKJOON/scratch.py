import urllib.request
import re
import time
import csv
import json
import ssl



from konlpy.tag import Twitter
from collections import Counter




def get_tags(text, ntags=50):
    spliter = Twitter()
    nouns = spliter.nouns(text)
    pp = spliter.pos(text)
    print(pp)

    for temp in pp:
        if temp[1] == "Noun":
            print(temp[0])

    count = Counter(nouns)
    return_list = []
    for n, c in count.most_common(ntags):
        temp = {'tag': n, 'count': c}
        return_list.append(temp)
    return return_list


def navercafe(startpage):
    print(startpage)
    client_id = "OKQPTGKiQf0V3yitzK6o" # 애플리케이션 등록시 발급 받은 값 입력
    client_secret = "uIGSvzveCB" # 애플리케이션 등록시 발급 받은 값 입력
    encText = urllib.parse.quote("20대"+'행복')
    data = urllib.parse.quote(str(startpage * 100 - 99))
    url = "https://openapi.naver.com/v1/search/cafearticle?query=" + encText +"&display=30&sort=date&start="+data

    print(url)
    ssl._create_default_https_context = ssl._create_unverified_context
    request = urllib.request.Request(url)
    request.add_header("X-Naver-Client-Id",client_id)
    request.add_header("X-Naver-Client-Secret",client_secret)
    response = urllib.request.urlopen(request)
    rescode = response.getcode()
    if(rescode==200):
        response_body = response.read()
        temp = response_body.decode('utf-8')
        json_test = json.loads(temp)
        test_temp = []
        print(temp)
        for i in range(1, 30):
            tempdata = json_test['items'][i]
            test_temp.append(tempdata['description'])
        return test_temp

    else:
        print("Error Code:" + rescode)

def naverblog(startpage):
    print(startpage)
    client_id = "OKQPTGKiQf0V3yitzK6o" # 애플리케이션 등록시 발급 받은 값 입력
    client_secret = "uIGSvzveCB" # 애플리케이션 등록시 발급 받은 값 입력
    encText = urllib.parse.quote('소확행')
    data = urllib.parse.quote(str(startpage*100 - 99))
    url = "https://openapi.naver.com/v1/search/blog?query=" + encText +"&display=100&sort=sim&start="+ data
    print(url)
    ssl._create_default_https_context = ssl._create_unverified_context
    request = urllib.request.Request(url)
    request.add_header("X-Naver-Client-Id",client_id)
    request.add_header("X-Naver-Client-Secret",client_secret)
    response = urllib.request.urlopen(request)
    rescode = response.getcode()
    if(rescode==200):
        response_body = response.read()
        temp = response_body.decode('utf-8')
        json_test = json.loads(temp)
        print(json_test)
        test_temp = []
        for i in range(1, 30):
            tempdata = json_test['items'][i]
            test_temp.append(tempdata['description'])
            print(tempdata['description'])
        return test_temp

    else:
        print("Error Code:" + rescode)



def navernews(startpage):
    print(startpage)
    client_id = "OKQPTGKiQf0V3yitzK6o" # 애플리케이션 등록시 발급 받은 값 입력
    client_secret = "uIGSvzveCB" # 애플리케이션 등록시 발급 받은 값 입력
    encText = urllib.parse.quote("행복")
    data = urllib.parse.quote(str(startpage * 100 - 99))
    url = "https://openapi.naver.com/v1/search/news?query=" + encText +"&display=100&sort=date&start="+data
    print(url)
    request = urllib.request.Request(url)
    request.add_header("X-Naver-Client-Id",client_id)
    request.add_header("X-Naver-Client-Secret",client_secret)
    response = urllib.request.urlopen(request)
    rescode = response.getcode()
    if(rescode==200):
        response_body = response.read()
        temp = response_body.decode('utf-8')
        json_test = json.loads(temp)
        test_temp = []
        for i in range(1,100):
            tempdata = json_test['items'][i]
            test_temp.append(tempdata['description'])

        return test_temp
    else:
        print("Error Code:" + rescode)




with open('newsn.csv', 'w' , encoding='UTF-8') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    csvout = csv.DictWriter(csvfile, ['description'])
    csvout.writeheader()

    str1 = ''

    for i in range(10):

            data = navernews((i+1))


            for temp in data:
                str1 = str1+""+temp
                list_data = []
                result_data = temp
                list_data.append(result_data)
                writer.writerow(list_data)

    rdata = get_tags(str1,50)
    print(rdata)