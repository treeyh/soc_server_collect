# -*- coding: utf-8 -*-

#pip install glances
#pip install Bottle 
#pip install netifaces 

import os

#glances 服务端口
glances_port = 61208

#数据库配置
db = {
    'host' : '192.168.36.55', 
    'user' : 'root', 
    'passwd' : 'fXL2bO$RQgaRS^lH', 
    'db' : 'soc_server_monitor',
    'charset' : 'utf8', 
    'port' : 3306,
}

#main脚本间隔时间，s
main_interval = 10

#日志目录
log_floder = '/data/log/soc_server_collect'
log_run_path = os.path.join(log_floder, 'run_collect.log')
log_collect_floder = os.path.join(log_floder, 'collect')

#脚本物理绝对路径
shell_root_path = os.path.split(os.path.realpath(__file__))[0]

#采集进程筛选
collect_process_cmd = 'ps aux|grep [p]ython-soc-server-collect'
#采集脚本名
collect_py = 'server_collect.py'
#采集脚本启动python路径
collect_start_python_path = '/opt/python/bin/python-soc-server-collect'




#采集时间间隔,s
collect_interval = 60
#采集地址
collect_url = 'http://%(ip)s:61208/api/2/all'
#采集数据节点
collect_types = ['load','ip','memswap','processlist','uptime','percpu','system','diskio','fs','mem','now','quicklook','network','processcount','cpu']



#ucmq path
ucmq_path = 'http://192.168.36.55:8803/'

