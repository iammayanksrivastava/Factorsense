import cx_Oracle
import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
import getpass
import json


tableslist="Tableslist.txt"

tname = open(tableslist, 'r')

#Declare Connection Parameter here
connstr='password/userid@address_of_database:port/service_name:dbname'
conn = cx_Oracle.connect(connstr)
cur = conn.cursor()

#Decleare arraylist for getting ColumnNames and Types as well as Column Names
getColNames=[]


#Build the Create Statement for all tables from the sources:
for tablename  in tname:
    sqlStmt='SELECT * FROM {usertable} where rownum < 2'.format(usertable=tname)
    a=cur.execute(sqlStmt)
    tableSchema=cur.description

    for i in tableSchema:
        columnName=str(i[0])
        getColNames.append(columnName)
    select = ['"select ' ]
    query = (select[0]+' '+','.join(getColNames) +' ,current_timestamp, '+ "'NLSMAY1'" + ' from '  + tablename +' a '+ ' where $CONDITIONS"')
    getColNames=[]
print(query)
