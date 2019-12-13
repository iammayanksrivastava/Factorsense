words = input("Enter words seperated by comma: ")

def len_name(words):
    for x in words.split(','):
        print(x.strip(), len(x.strip()))

len_name(words)
