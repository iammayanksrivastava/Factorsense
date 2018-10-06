a = "Hello how are you , what are you doing"

b = a.split(' ')


def len_str(b):
    for x in b:
        if(len(x)%2 ==0):
            print(x)

        ##print(x, len(x))

len_str(b)
