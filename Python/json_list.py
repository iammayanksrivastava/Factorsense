import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
import getpass
import json


#Read the Table names from the json file 
with open('tables.json') as table_param_file:
    table_name = json.load(table_param_file)

src_tables = table_name['source_tables']

print(src_tables)