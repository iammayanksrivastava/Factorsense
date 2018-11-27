#Guess Number by the user
import random

true_number = random.randint(1,49)


user_input = int(input("Enter a number: "))


while True:
    if user_input == true_number:
        print ("You are Right !! Good Job")
        break

    elif user_input < true_number:
        print("Your Guess is lower than the number. Try Again")
        user_input = int(input("Enter a number: "))

    elif user_input > true_number:
        print("Your Guess is greater than the number. Try Again")
        user_input = int(input("Enter a number: "))
