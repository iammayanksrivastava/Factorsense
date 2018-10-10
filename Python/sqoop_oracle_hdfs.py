import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)

table_name = input('Enter name of Table: ')
tgt_table_name = input('Enter name of Hive Table: ')

# Function to run Hadoop command

def run_unix_cmd(args_list):
    print('Running system command:{0}'.format('     '.join(args_list)))
    proc = subprocess.Popen(args_list, stdout=subprocess.PIPE, stderr=subprocess
.PIPE, universal_newlines=True)
    s_output, s_err = proc.communicate()
    s_return = proc.returncode
    return s_return, s_output, s_err

# Create Sqoop Job

def sqoop_job(table_name):
    cmd = ['sqoop', 'import', '--connect', 'jdbc:oracle:thin:@sl09.atradiusnet.com:1519/SYMF.atradiusnet.com', '--username', 'NLSMAY1','--password', 'Winter18','--table', table_name, '-m', '1', '--hive-import', '--hive-table', tgt_table_name]
    print(cmd)
    (ret, out, err) = run_unix_cmd(cmd)
    print(ret, out, err)
    if ret == 0:
        logging.info('Success.')
    else:
            logging.info('Error.')

if __name__ == '__main__':
 
 sqoop_job(table_name)