import pymysql.cursors
import datetime
# Connect to the database

connection = pymysql.connect(host='lthdp003.atradiusnet.com',
                             user='dh_audit',
                             password='Residency@18',
                             db='atr_data_hub',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)


def last_value(table_name):
        try:
                with connection.cursor() as cursor:
                        getlastvalue=[]
                        sql2 = ("select table_name, max(load_date) as lval  from sqoop_audit where table_name="+"'"+table_name+"'"+" group by table_name")
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
                pass

