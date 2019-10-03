import cx_Oracle
import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
import getpass
import json
from datetime import datetime
import time

#tableslist="Tableslist.txt"

#tname = "ORABUP0.TBBU_POLICIES"

#Declare Connection Parameter here
connstr=''
conn = cx_Oracle.connect(connstr)
cur = conn.cursor()

#Build the Create Statement for all tables from the sources:
def max_load_date(tname):
        #sql ='SELECT  to_date(max(LAST_UPDATE_DAT),'+"'DD/MM/YYYY HH:MI:SS'"+')'+ 'as last_update_dat FROM '+ tname
        sql ='SELECT  max(LAST_UPDATE_DAT) as last_update_dat FROM '+ tname
        sqlStmt = sql
        #print(sqlStmt)
        #sqlStmt='SELECT  max(to_timestamp(LAST_UPDATE_DAT,'''+YYYY-MM-DD hh24:mi:ss+''')) as last_update_dat FROM {usertable}'.format(usertable=tname)
        cur.execute(sqlStmt)
        lvalue = cur.fetchone()
        last_date = lvalue[0]
        last_date_a = str(last_date)
        last_date_b = datetime.strptime(last_date_a,"%Y-%m-%d %H:%M:%S")
        last_date = last_date_b.strftime('%d/%m/%Y %H:%M:%S')
        return last_date
        #print(sql)
        #print(last_date)
        #print(last_date_t)

#max_load_date(tname)

