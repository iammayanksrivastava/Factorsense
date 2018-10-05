string = 'Mayank'
running = True

while running:
    guess = raw_input("Enter a Name: ")

    if guess == 'quit':
        break

    if guess == 'Mayank':
        running = False
        print ("Wahh jee wahh...")


    elif guess != 'Mayank':
        print ("Lage Raho Bhai...")

else:
    print ("While Loop is over")

print ("Exiting...")
