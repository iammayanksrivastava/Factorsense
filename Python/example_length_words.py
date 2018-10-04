list = []

Firstword = raw_input("Enter a name: ")
Secondword = raw_input("Enter a name: ")
Thirdword = raw_input("Enter a name: ")

list.append(Firstword)
list.append(Secondword)
list.append(Thirdword)

def len_name(list):
    for x in list:
        print(x, len(x))

len_name(list)
