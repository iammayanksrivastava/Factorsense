n = 23

guess = int(input('Enter a Number of your Choice: '))


if guess == n:
    print('You guessed it Right!!')
elif guess < n:
    print('The number is little higher than your guess')
else:
    print('The number is lower than your guess')

print ('Done')
