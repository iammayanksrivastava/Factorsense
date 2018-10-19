import pymysql.cursors
import datetime
# Connect to the database
connection = pymysql.connect(host='vps582064.ovh.net',
                             user='fs_stage',
                             password='Residency@18',
                             db='fs_stage',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)



def last_value(table_name):
        try:
                with connection.cursor() as cursor:
                        getlastvalue=[]
                        sql2 = ("select table_name, cast(max(last_load_date) as char) as lval  from sqoop_audit where table_name="+"'"+table_name+"'"+" group by table_name")
                        cursor.execute(sql2)
                        lvalue =cursor.fetchone()
                        lastvalue=lvalue['lval']
                        #tab_lastvalue = lvalue['table_name']
                        #print(lastvalue)
                        #print(tab_lastvalue)
                        getlastvalue.append(lastvalue)
                        #sql = ("insert into sqoop_audit SELECT max(load_date) FROM "+ table_name)
                        #cursor.execute(sql)
                        return lastvalue
        finally:
                connection.close()
