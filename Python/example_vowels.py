word = list(input("Enter a word: "))

print (word)


for i in word:
    if word in ("a", "e", "i", "o", "u"):
        print("Accepted")
    else:
        print("Rejected")
