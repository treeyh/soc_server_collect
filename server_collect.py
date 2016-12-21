# -*- coding: utf-8 -*-


import sys
import os
import time
import traceback
import datetime

import config
from helper import log_helper, mysql_helper, str_helper, date_helper, file_helper, http_helper


def logger():
    global _id, _ip
    logPath = os.path.join(config.log_collect_floder, str(_id)+'_'+_ip+'py.log')
    # logPath = os.path.join(config.log_collect_floder, 'py.log')
    return log_helper.get_logger(logPath)


def send_mq(mqName, collectInfo, nowTime):
    global _ip, _id
    ''' 保存到消息队列 '''
    url = config.ucmq_path
    params = {
        'name' : mqName,
        'opt' : 'put',
        'ver' : 2,
    }
    data = {
        'id' : _id,
        'ip' : _ip,
        'time' : nowTime,
        'info' : collectInfo,
    }

    d = str_helper.json_encode(data)
    re = http_helper.post(url, params = params, data = d)
    if 200 == re.status_code:
        re.encoding = 'utf-8'
        log = 'collect_server_info:%s;data:%s;result:%s' % (re.url, d, re.text)
        logger().info(log)
        return re.text

    log = 'collect_server_info:%s;data:%s;resultcode:%d' % (re.url, d, re.status_code)
    logger().info(log)
    return None



def collect_server_info():
    ''' 采集服务器信息 '''
    global _ip, _id
    url = config.collect_url % {'ip': _ip}
    params = {
        'id' : _id,        
        'time' : date_helper.get_now_datetimestr3(),
    }

    re = http_helper.get(url, params = params)
    if 200 == re.status_code:
        re.encoding = 'utf-8'
        log = 'collect_server_info:%s;result:%s' % (re.url, re.text)
        logger().info(log)
        return str_helper.json_decode(re.text)

    log = 'collect_server_info:%s;resultcode:%d' % (re.url, re.status_code)
    logger().info(log)
    return None





def main():
    global _id, _ip
    while True:
        now = datetime.datetime.now()        

        data = collect_server_info()

        nowTime = date_helper.datetime_to_str(now)
        for k in config.collect_types:
            send_mq(k, data[k], nowTime)

        old = now + datetime.timedelta(seconds = config.collect_interval)
        now2 = datetime.datetime.now()
        inv = date_helper.datetime_to_time(old) - date_helper.datetime_to_time(now2)

        if inv > 0:
            time.sleep(inv)


    pass



_id = ''
_ip = ''

if __name__ == '__main__':
    import sys
    reload(sys)
    sys.setdefaultencoding('utf-8')        
    if len(sys.argv) == 3:
        _id = sys.argv[1]
        _ip = sys.argv[2]
        main()
        
