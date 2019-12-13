#Import necessary packages 
from azure.common.credentials import ServicePrincipalCredentials
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.datafactory import DataFactoryManagementClient
from azure.mgmt.datafactory.models import *
from datetime import datetime, timedelta
import time
import json
from azure.common.client_factory import get_azure_cli_credentials
from azure.mgmt.compute import ComputeManagementClient

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#  Parameters to be used in the Script                                                                                                                                               #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#Read the environment varaibles from the json file
with open('azure_credentials.json') as env_param_file:
    env_param = json.load(env_param_file)

client_id       =   env_param['client_id']
secret          =   env_param['secret']
tenant          =   env_param['tenant']
subscription_id =   env_param['subscription_id']
source          =   env_param['source']
target          =   env_param['target']
client_id       =   client_id[0]
secret          =   secret[0]
tenant          =   tenant[0]
subscription_id =   subscription_id[0]
source          =   source[0]
target          =   target[0]

# This program creates this resource group. If it's an existing resource group, comment out the code that creates the resource group
#rg_name = 'poc-westeurope-gp-data-rg'
rg_name = 'poc-westeurope-gp-data-rg'

# The data factory name. It must be globally unique.
#df_name = 'poc-westeurope-gp-data-df-atradius'        
df_name = 'poc-westeurope-gp-data-df'        


#credentials = ServicePrincipalCredentials(client_id=client_id, secret=secret, tenant=tenant)
credentials = get_azure_cli_credentials()
resource_client = ResourceManagementClient(credentials[0], credentials[1])
adf_client = DataFactoryManagementClient(credentials[0], credentials[1])

rg_params = {'location':'westeurope'}
df_params = {'location':'westeurope'}

# Create database linked service
ls_tgt_name = 'tgtazuresqldb'

# Create an Azure Storage linked service
ls_src_name = 'srcgrpblob'


# Parameter File with list of tables
with open('param_tables.json') as json_param_file:
    table_name = json.load(json_param_file)

table_name = table_name['source_tables']

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Prints information on screen                                                                                                                    #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

def print_item(group):
    """Print an Azure object instance."""
    print("\tName: {}".format(group.name))
    print("\tId: {}".format(group.id))
    if hasattr(group, 'location'):
        print("\tLocation: {}".format(group.location))
    if hasattr(group, 'tags'):
        print("\tTags: {}".format(group.tags))
    if hasattr(group, 'properties'):
        print_properties(group.properties)

def print_properties(props):
    """Print a ResourceGroup properties instance."""
    if props and hasattr(props, 'provisioning_state') and props.provisioning_state:
        print("\tProperties:")
        print("\t\tProvisioning State: {}".format(props.provisioning_state))
    print("\n\n")

def print_activity_run_details(activity_run):
    """Print activity run details."""
    print("\n\tActivity run details\n")
    print("\tActivity run status: {}".format(activity_run.status))    
    if activity_run.status == 'Succeeded':
        print("\tNumber of bytes read: {}".format(activity_run.output['dataRead']))       
        print("\tNumber of bytes written: {}".format(activity_run.output['dataWritten']))           
        print("\tCopy duration: {}".format(activity_run.output['copyDuration']))           
    else:
        print("\tErrors: {}".format(activity_run.error['message']))



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#  Creates Resource Group, Data Factory and Connections                                                                                           #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

def main():

    #create the resource group
    resource_client.resource_groups.create_or_update(rg_name, rg_params)

    Create a data factory
    df_resource = Factory(location='westeurope')
    df = adf_client.factories.create_or_update(rg_name, df_name, df_resource)
    print_item(df)
    while df.provisioning_state != 'Succeeded':
        df = adf_client.factories.get(rg_name, df_name)
        time.sleep(1)



    #Specify the name and key of your Azure Storage account
    source_string = SecureString(source)
    ls_azure_storage = AzureStorageLinkedService(connection_string=source_string)
    ls_source = adf_client.linked_services.create_or_update(rg_name, df_name, ls_src_name, ls_azure_storage)
    print_item(ls_source)

    #Specify the database connection strings for the Azure SQL
    tgt_string = SecureString(target)
    ls_azure_tgt = AzureSqlDatabaseLinkedService(connection_string=tgt_string)
    ls = adf_client.linked_services.create_or_update(rg_name, df_name, ls_tgt_name, ls_azure_tgt)
    print_item(ls)


def srctgt(table_name):
    # Create an Azure blob dataset (input)
    ds_name = 'in_'+table_name
    ds_ls = LinkedServiceReference('Blob')
    blob_path= 'poc-ukwest-nifi-sc'
    blob_filename = table_name
    ds_azure_blob= AzureBlobDataset(ds_ls, folder_path=blob_path, file_name = blob_filename, format=TextFormat(column_delimiter=",", skip_line_count=0, quote_char='"', treat_empty_as_null=True, first_row_as_header=False))
    ds = adf_client.datasets.create_or_update(rg_name, df_name, ds_name, ds_azure_blob)
    print_item(ds)

    # Create an Azure SQL Table dataset (input)
    dsout_name = 'out_stg_'+table_name
    ds_ls = LinkedServiceReference('Oracle')
    tgt_table = table_name
    ds_azure_sql= OracleTableDataset(ds_ls, table_name = 'stg_'+tgt_table)
    dstgt = adf_client.datasets.create_or_update(rg_name, df_name, dsout_name, ds_azure_sql)
    print_item(dstgt)
    
    # Create a copy activity
    act_name        = 'copyBlobtotable'
    source          = BlobSource()
    sink            = BlobSink()
    dsin_ref        = DatasetReference(ds_name)
    dsOut_ref       = DatasetReference(dsout_name)
    copy_activity   = CopyActivity(act_name,inputs=[dsin_ref], outputs=[dsOut_ref], source=source, sink=sink)


    #Create a pipeline with the copy activity
    p_name =  'Load_'+table_name+'_STG_'+table_name
    params_for_pipeline = {}
    p_obj = PipelineResource(activities=[copy_activity], parameters=params_for_pipeline)
    p = adf_client.pipelines.create_or_update(rg_name, df_name, p_name, p_obj)
    print_item(p)
    
    # Create a pipeline run
    # run_response = adf_client.pipelines.create_run(rg_name, df_name, p_name,{})
    # time.sleep(10)
    # pipeline_run = adf_client.pipeline_runs.get(rg_name, df_name, run_response.run_id)
    # print("\n\tPipeline run status: {}".format(pipeline_run.status))
    # activity_runs_paged = list(adf_client.activity_runs.list_by_pipeline_run(rg_name, df_name, pipeline_run.run_id, datetime.now() - timedelta(1),  datetime.now() + timedelta(1)))
    # print_activity_run_details(activity_runs_paged[0])

# Start the main method
#main()

#Start the srctgt method
for i in table_name:
    srctgt(i)
