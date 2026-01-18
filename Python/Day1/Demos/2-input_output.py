grade = int(input("Enter your grade: "))
if 100 >= grade >= 85:
    print("Exellant")
elif grade < 85 and grade >= 75:
    print("Very Good")
elif grade < 75 and grade >= 65:
    print("Good")
elif grade < 65 and grade >= 50:
    print("Fair")
elif grade < 50 and grade >= 0:
    print("------")
else:
    print("Enter Valid Grade")
