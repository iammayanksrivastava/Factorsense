#Import Necessary Libraries
from bs4 import BeautifulSoup
import urllib.request
import csv
import pandas

#Specify the url of the page to be scrapped
urlpage = "http://www.fasttrack.co.uk/league-tables/tech-track-100/league-table/"


#Query the website and return the html to the variable page. 
page = urllib.request.urlopen(urlpage)
#parse the html using Beautiful Soup and store in variable soup
soup = BeautifulSoup(page,'html.parser')

#find results within the table
table = soup.find('table', attrs={'class': 'tableSorter'})
results = table.find_all('tr')
#print(results)
#print(len(results))

#Create and write headers to a list
rows = []
rows.append(['Rank', 'Company Name', 'Webpage', 'Description', 'Location', 'Year end', 'Annual sales rise over 3 years', 'Sales £000s', 'Staff', 'Comments'])
#print(rows)

#loop over results
for result in results:
    data = result.find_all('td')
    if len(data) == 0:
        continue
    #Output the data to variables
    rank = data[0].getText()
    company = data[1].getText()
    location = data[2].getText()
    yearend = data[3].getText()
    salesrise = data[4].getText()
    sales = data[5].getText()
    staff = data[6].getText()
    comments = data[7].getText()

    #Extract company name, description
    companyname = data[1].find('span', attrs={'class':'company-name'}).getText()
    description = company.replace(companyname, '')

    #Strip unwanted characters from the sales data. 
    sales = sales.strip('*').strip('†').replace(',', '')

    #Extract url of the webpage
    url = data[1].find('a').get('href')
    page = urllib.request.urlopen(url)

    #parse the html
    soup = BeautifulSoup(page, 'html.parser')

    try:
        tablerow = soup.find('table').find_all('tr') [-1]
        webpage = tablerow.find('a').get('href')
    except:
        webpage = None

    
    # write each result to rows
    rows.append([rank, companyname, webpage, description, location, yearend, salesrise, sales, staff, comments])
    #print(rows)

    #Output the data from the rows to a panda data frame
    League100 = pandas.DataFrame(rows)

    #print the output to a csv file. 
    League100.to_csv("tech_track_100.csv")