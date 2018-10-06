a = "how are you?"

a = a.replace(" ", "")

def count_occur(a):
    for x in set(a):
        print(x, a.count(x))

count_occur(a)
