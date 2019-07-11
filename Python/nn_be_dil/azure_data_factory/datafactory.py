#Import necessary packages
from azure.common.credentials import ServicePrincipalCredentials
from azure.common.credentials import get_azure_cli_credentials
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.datafactory import DataFactoryManagementClient
from azure.mgmt.datafactory.models import *
from datetime import datetime, timedelta
import time
import json


#Azure subscription ID
subscription_id = '13b24a64-e37d-4738-8f65-7bdd1be541ed'
source = "solife"

#Name of the resource group
rg_name = 'nnbe_dil_dev_internal_rg'
rg_params = {'location':'west europe'}

# Name of Data Factory
df_name = 'nnbedildev'
df_params = {'location':'west europe'}

# Name for Azure Storage linked service
ls_name='storageLinkedService'

# Name for Azure Storage linked service
ls_sqldb_name='AzureSqlDB'

#Specify your Active Directory client ID, client secret, and tenant ID
credentials = ServicePrincipalCredentials(client_id='583e7f11-ccc0-41c9-b0f1-02c20d9c90ad', secret='Y6b[w[8GOa5FN8Ov/KUtaI=.7UoUs5bK', tenant='57bd9703-6df7-4ee9-b4c7-6b372615965c')
resource_client = ResourceManagementClient(credentials, subscription_id)
adf_client = DataFactoryManagementClient(credentials, subscription_id)

# Parameter File with list of tables from source
with open('param_landing.json') as json_param_file:
    file_name = json.load(json_param_file)
file_name = file_name['source_tables']
srcdata=[x.encode('utf-8') for x in file_name]

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
    print("\n")

def print_properties(props):
    """Print a ResourceGroup properties instance."""
    if props and hasattr(props, 'provisioning_state') and props.provisioning_state:
        print("\tProperties:")
        print("\t\tProvisioning State: {}".format(props.provisioning_state))
    print("\n")

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

def main():
    # Specify the name and key of your Azure Storage account
    #storage_string = SecureString('DefaultEndpointsProtocol=https;AccountName=<storage account name>;AccountKey=<storage account key>')
    ls_azure_storage = AzureStorageLinkedService(connection_string='DefaultEndpointsProtocol=https;AccountName=nnbedildevblob;AccountKey=/RTjdbdzRIwKf5uzZa7f4RiJOX5p3ZM1eFA2IaPMXoyydtd5l+0lX+j8khKGjn29UrrU8AiB2XWQlwlNd7tQfQ==;EndpointSuffix=core.windows.net')
    ls = adf_client.linked_services.create_or_update(rg_name, df_name, ls_name, ls_azure_storage)
    print_item(ls)

    #Specify the details of AzureSQL Database to create linked Service for Azure SQL Database
    ls_azure_sql = AzureSqlDatabaseLinkedService(connection_string="Data Source=nnbedil.database.windows.net;Initial Catalog=nnbedildbdev;Persist Security Info=False;User ID=hk59cb;Password=Residency@18;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;")
    ls_sqldb = adf_client.linked_services.create_or_update(rg_name, df_name, ls_sqldb_name, ls_azure_sql)
    print_item(ls_sqldb)

# Creates the Source Datasets from landing, T
def landing_datasets(srcdata):
    ds_name = 'landing_'+srcdata
    print (ds_name)
    ds_ls = LinkedServiceReference(reference_name="storageLinkedService")
    blob_path= 'srcdevdil'
    blob_filename = srcdata+'.csv'
    blob_filename = blob_filename.lower()
    ds_azure_blob= AzureBlobDataset(linked_service_name=ds_ls, folder_path=blob_path, file_name=blob_filename, format=TextFormat(column_delimiter=";", skip_line_count=0, quote_char='"', treat_empty_as_null=True, first_row_as_header=True))
    ds = adf_client.datasets.create_or_update(rg_name, df_name, ds_name, ds_azure_blob)
    print_item(ds)

#Creates arget Datasets from AzureSQLDB, Copy Activity and Pipeline to load data from landing to Ingestion
    dsout_name = 'I_SOLIFE_'+srcdata
    print(srcdata)
    ds_ls = LinkedServiceReference(reference_name='AzureSqlDB')
    tgt_table = dsout_name
    ds_azure_sql= AzureSqlTableDataset(linked_service_name=ds_ls, table_name = tgt_table)
    dstgt = adf_client.datasets.create_or_update(rg_name, df_name, dsout_name, ds_azure_sql)
    print_item(dstgt)
    
    #Create a Copy activity to load data from Landing to Ingestion 
    act_name        = 'landingtoingestion'+srcdata
    source          = BlobSource()
    sink            = BlobSink()
    dsin_ref        = DatasetReference(reference_name=ds_name)
    dsOut_ref       = DatasetReference(reference_name=dsout_name)
    copy_activity   = CopyActivity(name=act_name,inputs=[dsin_ref], outputs=[dsOut_ref], source=source, sink=sink)

    #Create a pipeline with the copy activity to load data from landing to Ingestion
    p_name =  'Landing_'+srcdata+'_ingestion'
    params_for_pipeline = {}
    p_obj = PipelineResource(activities=[copy_activity], parameters=params_for_pipeline)
    p = adf_client.pipelines.create_or_update(rg_name, df_name, p_name, p_obj)
    print_item(p)

    
# Start the main method
main()

#Start the Landing method
for i in srcdata:
    landing_datasets(i)
