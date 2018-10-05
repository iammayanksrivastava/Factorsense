number = 23
running = True

while running:
    guess = int(input("Enter a number: "))

    if guess==number:
        print("Congratulations you guess it right !!")
        running = False

    elif guess < number:
        print ("The number is little higher than that")

    else:
        print ("The number is little lower than that")

else:
    print ("The while loop is over")

print ("Done")
