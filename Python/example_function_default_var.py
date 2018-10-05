a = int(input("Enter a number :"))
b = int(input("Enter a number :"))

def sum_number(a, b=int(5)):
    c = a+b

    print("The sum of " + str(a) + "and" + str(b) + "is" + str(c))

    return()

sum_number(a)
sum_number(a,b)
