import pymysql.cursors
import datetime
# Connect to the database
connection = pymysql.connect(host='vps582064.ovh.net',
                             user='fs_stage',
                             password='Residency@18',
                             db='fs_stage',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

f = '%Y-%m-%d %H:%M:%S'
result =()

try:
    with connection.cursor() as cursor:
            sql = "insert into sqoop_audit SELECT max(load_date) FROM `employee`"
            sql2 = "select cast(max(last_load_date) as char)  from sqoop_audit"
            cursor.execute(sql)
            cursor.execute(sql2)
            result =cursor.fetchone()
            print (result)
finally:
    connection.close()
    
        
