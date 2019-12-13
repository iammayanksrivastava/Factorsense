list = []

Firstword = input("Enter a name: ")
Secondword = input("Enter a name: ")
Thirdword = input("Enter a name: ")

list.append(Firstword)
list.append(Secondword)
list.append(Thirdword)

def len_name(list):
    for x in list:
        print(x, len(x))

len_name(list)
