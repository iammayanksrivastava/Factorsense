import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
import getpass
import json
import pymysql.cursors
from read_last_value import last_value
import cx_Oracle
from create_incr_query import create_query
from read_max_load_date import max_load_date

#Connect to the database in mysql for auditing the changes. Currently only last date is added into the audit table.
mysql = pymysql.connect(host='',
                             user='',
                             password='',
                             db='',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

#Read the source tables to be extracted from the json file
with open('param_tables.json') as json_param_file:
    table_name = json.load(json_param_file)

table_name = table_name['source_tables']

#Read the environment varaibles from the json file
with open('param_env_variable.json') as env_param_file:
    env_param = json.load(env_param_file)

oracle_url = env_param['oracle_connection']
username = env_param['username']
source_schema = env_param ['source_schema']
password_alias = env_param['password_alias']
alias_provider = env_param['alias_provider']
target_dir = env_param['target_dir']
target_dir_incr = env_param['target_dir_incr']
oracle_url = oracle_url[0]
username = username[0]
source_schema = source_schema [0]
password_alias = password_alias[0]
alias_provider = alias_provider[0]
target_dir = target_dir[0]
target_dir_incr = target_dir_incr[0]

# Function to run Hadoop command
def run_unix_cmd(args_list):
    print('Running system command:{0}'.format('     '.join(args_list)))
    proc = subprocess.Popen(args_list, stdout=subprocess.PIPE, stderr=subprocess .PIPE, universal_newlines=True)
    s_output, s_err = proc.communicate()
    s_return = proc.returncode
    return s_return, s_output, s_err

# Create Sqoop Job to load data from source into HDFS Target Directory

def sqoop_job(table_name):
    #The last value which was loaded into the Data Hub is picked from the SQOOP Audit Table which holds the details from the last run.
    lastvalue =last_value(table_name)
    #Last Update Date is fetched from the source and this is also updated into the SQOOP Audit Table.
    last_update_date = max_load_date(table_name)
    #print(last_update_date)
    init_query = create_query(table_name)
    final_query = init_query+"'"+lastvalue+"'"+','+"'"+"DD/MM/YYYY HH24:MI:SS""'"+')'+' AND $CONDITIONS'
    print(final_query)
    #print(final_query)
    #cmd = ['sqoop', 'import', '-Dhadoop.security.credential.provider.path='+alias_provider, '--connect', oracle_url, '--username', username,'--password-alias', password_alias, '-m', '1', '--as-textfile','--target-dir', target_dir_incr+'/'+table_name, '--query',query, '--incremental', 'append', '--check-column', 'last_update_dat','--last-value', "'"+lastvalue+"'"]
    cmd = ['sqoop', 'import', '-Dhadoop.security.credential.provider.path='+alias_provider, '--connect', oracle_url, '--username', username,'--password-alias', password_alias,'-m', '1', '--as-textfile','--target-dir', target_dir_incr+'/'+table_name, '--query',final_query]
    #cmd2 = ['hdfs', 'dfs', '-rm',  target_dir+'/'+table_name+'/'+'_SUCCESS']
    print(cmd)
    #print('Removing Success Flag from ' +target_dir+'/'+table_name)
    #print(cmd2)
    (ret, out, err) = run_unix_cmd(cmd)
    print(ret, out, err)
    #(ret, out, err) = run_unix_cmd(cmd2)
    print(ret, out, err)
    try:
        with mysql.cursor() as cursor:
            sql = ("insert into sqoop_audit values ('"+str(last_update_date)+"'"+" , "+"'"+table_name+"'"+',' +'current_timestamp'+")")
            print(sql)
            cursor.execute(sql)
            mysql.commit()
    finally:
        pass

    if ret == 0:
        logging.info('Success.')
    else:
        logging.info('Error.')


#Run sqoop job for each table in the parameter file.
for i in table_name:
    sqoop_job(i)

mysql.close()
