import cx_Oracle
import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
import getpass
import json


#tableslist="Tableslist.txt"

#tname = "ORABUP0.TBBU_POLICIES"

#Declare Connection Parameter here
connstr='NLSMAY1/Winter18@sl09.atradiusnet.com:1519/SYMF.atradiusnet.com:ORABUP0'
conn = cx_Oracle.connect(connstr)
cur = conn.cursor()

#Build the Create Statement for all tables from the sources:
def max_load_date(tname):
        sqlStmt='SELECT max(last_update_dat) as last_update_dat FROM {usertable}'.format(usertable=tname)
        cur.execute(sqlStmt)
        lvalue = cur.fetchone()
        last_date = lvalue[0]
        return last_date

