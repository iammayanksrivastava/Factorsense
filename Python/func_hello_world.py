def hello_world():
    name = str(raw_input('Enter Your Name:'))
    if name:
        print ("Hello " + str(name))
    else:
        print("Hello World")
    return

hello_world() * 2
