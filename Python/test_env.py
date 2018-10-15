import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
import getpass
import json

#Read the environment varaibles from the json file 
with open('env_variable.json') as env_param_file:
    env_param = json.load(env_param_file)

oracle_url = env_param['oracle_connection']
username = env_param['username']
source_schema = env_param ['source_schema']
target_schema  = env_param['target_schema']

oracle_url = oracle_url[0]
username = username[0]
source_schema = source_schema [0]
target_schema  = target_schema[0]

print(oracle_url)
print(username)
print(source_schema)
print(target_schema)