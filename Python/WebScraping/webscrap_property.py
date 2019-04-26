#testing the jenkins integration with GitHub
#Import Necessary Libraries
import requests
from bs4 import BeautifulSoup
import pandas
from user_agent import generate_user_agent


#URL from where you want to scrap the data from 
base_url = "https://www.apartments.com/cincinnati-oh/"
headers = {'User-Agent': generate_user_agent(device_type="desktop", os=('mac', 'linux'))}


#Get Html contents

r = requests.get(base_url, timeout=5, headers=headers)
c = r.content

#Parse the html content

soup = BeautifulSoup(c, "html.parser")


#Extract the first and last page numbers

paging = soup.find("div", {"id":"placardContainer"}).find("div", {"id":"paging"}).find_all("a")
start_page = paging[1].text
last_page = paging[len(paging)-2].text


#Empty list to append the content
web_content_list = []


for page_number in range(int(start_page, int(last_page)+1)):
    url = base_url+str(page_number)+"/.html"
    r = requests.get(base_url+str(page_number)+"/")
    c = r.content
    soup = BeautifulSoup(c, "html_parser")


#extract Title and Location 
placard_header = soup.find_all("header", {"class":"placardheader"})

#Extract Rent and other details 
placard_content = soup.find_all("header", {"class":"placardContent"})

#Process property by looping
for item_header, item_content in zip(placard_header, placard_content):
    web_content_dict = {}
    web_content_dict["Title"]= item_header.find("a", {"class":"placardTitle js-placardTitle"}).text.replace("\r", "").replace("\n", "")
    web_content_dict["Address"]= item_header.find("div", {"class":"location"}).text
    web_content_dict["Price"]= item_header.find("div", {"class":"altRentDisplay"}).text
    web_content_dict["Beds"]= item_header.find("span", {"class":"unitLabel"}).text
    web_content_dict["Phone"]= item_header.find("span", {"class":"Phone"}).text
    web_content_list.append(web_content_dict)


#make a dataframe with the list 
df = pandas.DataFrame(web_content_list)
df.to_csv("Output.csv")
