p = "_"

q = "a"

j = 5

for i in range(1,11,2):
    stringtoprint = p*j + q*i + p*j
    j = j-1
    print(stringtoprint)
    if j == 0:
        j = 1
        for x in range(7, 0, -2):
            j = j+1
            stringtoprint = p*j + q*x + p*j
            print(stringtoprint)
