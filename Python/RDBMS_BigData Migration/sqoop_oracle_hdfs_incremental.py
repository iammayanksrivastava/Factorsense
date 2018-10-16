#############################################################################################################################################################
# Script Name: SQOOP_ORACLE_HDFS_INITIAL.py
# Purpose of Script: SQOOP Script written in python to load an initial snapshot of the data from RDBMS system into Atradius Data Hub. The Script will select 
#                    all the tables listed in the tables.json parameter file and load the data into hive. The environment parameters are picked from the 
#                    env_variable.json file. The SQOOP script selects all the data from the source tables and dumps them in the form of text files in the     
#                    Native Zone directory. 
# Created by:        Mayank Srivastava
# Created Date:      16-Oct-2018
# Updated Date:      
# Updates:            
#############################################################################################################################################################

import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
import getpass
import json

#Read the source tables to be extracted from the json file
with open('tables.json') as json_param_file:
    table_name = json.load(json_param_file)

table_name = table_name['source_tables']

#Read the environment varaibles from the json file
with open('env_variable.json') as env_param_file:
    env_param = json.load(env_param_file)

oracle_url = env_param['oracle_connection']
username = env_param['username']
source_schema = env_param ['source_schema']
target_schema  = env_param['target_schema']
password_alias = env_param['password_alias']
alias_provider = env_param['alias_provider']
target_dir = env_param['target_dir']
target_dir_incr = env_param['target_dir_incr']
oracle_url = oracle_url[0]
username = username[0]
source_schema = source_schema [0]
target_schema  = target_schema[0]
password_alias = password_alias[0]
alias_provider = alias_provider[0]
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
    cmd = ['sqoop', 'import', '-Dhadoop.security.credential.provider.path='+alias_provider, '--connect', oracle_url, '--username', username,'--password-alias', password_alias,'--table', source_schema+'.'+table_name, '-m', '1', '--as-textfile', '--target-dir', target_dir_incr ]
    print(cmd)

    (ret, out, err) = run_unix_cmd(cmd)
    print(ret, out, err)
    if ret == 0:
        logging.info('Success.')
    else:
        logging.info('Error.')

for i in table_name:
    sqoop_job(i)


# Create target table in Hive using schema from Oracle 


