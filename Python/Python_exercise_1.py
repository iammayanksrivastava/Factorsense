#Exercise from https://www.practicepython.org/exercise/2014/01/29/01-character-input.html
#Takes Your name and age as input and will tell you when you will turn 100

import datetime

now = datetime.datetime.now()

Name = raw_input("Enter Your Name: ")
Age  = int(input("Enter Your Age: "))
PrintTime = int(input("Enter the number of times you want to print: "))

Year_when_100 = str((now.year - Age)+100)

for Year_when_100 in range(PrintTime):
    print(Name + ",you will turn 100 in " + Year_when_100)
