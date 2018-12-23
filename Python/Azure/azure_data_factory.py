#Import Libraries
from azure.common.credentials import ServicePrincipalCredentials
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.datafactory import DataFactoryManagementClient
from azure.mgmt.datafactory.models import *
from datetime import datetime, timedelta
import time


def print_item(group):
    """Print an Azure Object Instance"""
    print("\tName: {}".format(group.name))
    prinr("\Id: {}".format(group.Id)
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

def main():
    #Azure Subscription ID
    subscription_id = ''

    #Name of the resource Group
    rg_name  = 'fs-resourcegroup'

    #Name of the datafactory
    df_name = 'fsentdwh'

    #Specify active directory client id, client secret and tenant ID 
    credentials = ServicePrincipalCredentials(client_id='', secret='', tenant='')
    resource_client = ResourceManagementClient(credentials, subscription_id)
    adf_client = DataFactoryManagementClient(credentials, subscription_id)

    rg_params = {'location': 'eastus'}
    df_params = {'location': 'eastus'}


    #Create a Data Factory 

    df_resource = Factory(location='eastus')
    df = adf_client.factories.create_or_update(rg_name, df_name, df_resource)
    print_item(df)

    while df.provisioning_state != 'Succeeded':
        df = adf_client.factories.get(rg_name, df_name)
        time.sleep(1)

    #Cretae an Azure Storage Linked Service 

    ls_name = 'storageLinkedService'

    storage_string = SecureString('DefaultEndpointsProtocol=https;AccountName=<storage account name>;AccountKey=<storage account key>')

    ls_azure_storage = AzureStorageLinkedService(connection_string=storage_string)

    ls = adf_client.linked_services.create_or_update(rg_name, df_name, ls_name, ls_azure_storage)

    




#Start the main method 
main()



