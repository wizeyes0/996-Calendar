import datetime, calendar
import requests
import json

m_h = ['01','02','03','04','05','06','07','08','09','10','11','12']
year = 2019
date_table = []

print("归档所有日期")

for m in m_h:
    month_range = calendar.monthrange(year, int(m))
    for n in range(0, month_range[1]):
        day = datetime.datetime.strptime('%s-%s-%s' % (str(year), m, '01'), '%Y-%m-%d') + \
              datetime.timedelta(days  =+ n)
        date_name = str(day)[0: 10]
        date_table.append(date_name)
        # print(date_name)
    # print('\n')

result_info = {}

for day in date_table:
    print("正在处理", day)
    # if day.startswith("2019-01-05"):
    #     break
    url = 'http://holiday-api.leanapp.cn/api/v1/work?date={day}'.format(day=day)
    resp = requests.get(url)
    result = resp.content
    result_dict = json.loads(s=result)
    if result_dict['code'] == 200:
        result_info[day] = {
            "should_work": result_dict['data']['shouldWork'] == 'Y',
            "info": "双休日" if result_dict['data']['shouldWork'] == 'N' else "工作日",
        }

# print(result_info)
json_result = json.dumps(obj=result_info)

print("请求完成,写文件")

with open('/Users/gua/Desktop/App/996/ICU996/{year}.json'.format(year=year), 'w') as f:
    f.write(json_result)

print("已完成")