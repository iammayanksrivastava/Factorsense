#Import libraries needed for the script
import cx_Oracle
import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
import getpass
import json

#Declare Connection Parameter here
connstr='NLSMAY1/Winter18@sl09.atradiusnet.com:1519/SYMF.atradiusnet.com:ORABUP0'
conn = cx_Oracle.connect(connstr)
cur = conn.cursor()

#Build the Create Statement for all tables from the sources:
def create_query(tname):
    getColNames =[]
    sqlStmt='SELECT * FROM {usertable} where rownum < 2'.format(usertable=tname)
    a=cur.execute(sqlStmt)
    tableSchema=cur.description
    for i in tableSchema:
            columnName=str(i[0])
            getColNames.append(columnName)
    select = ['"select ' ]
    query = (select[0]+' '+','.join(getColNames) +' ,current_timestamp, '+ "'NLSMAY1'" + ' from '  + 'ORABUP0.'+tname +' a '+ ' where lastvalue > to_timestamp(')
    return query
