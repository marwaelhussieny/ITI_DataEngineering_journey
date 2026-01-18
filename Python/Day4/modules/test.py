""" Importing another module """

print("******************** Import the entire module ********************")
import mymodule

print(mymodule.name)  # Accessing variable from mymodule
mymodule.greet_user()  # Calling function from mymodule

print("******************** Import Module with alias ********************")
import mymodule as namemodule
print(namemodule.name)
namemodule.greet_user()

print("********** Import specific functions and variables from module *********")
from mymodule import name, greet_user
print(name)
greet_user()

print("******************** Import function from module with alias ********************")
from mymodule import greet_user as greet, name as fullname
greet()
print(fullname)

############################################################################

print("******************** Using a validation module ********************")
from modules.validation_module import is_number as check_number, is_empty_string

print(check_number(10))   # True
print(is_empty_string(""))  # True

############################################################################

""" This condition is a fundamental concept in Python that 
    helps differentiate between when a script is run directly and 
    when it is imported as a module in another script.
- Python file (script) has a built-in variable called __name__
- When a script is executed directly, Python sets __name__ to "__main__".
- If the script is imported as a module, __name__ is set to the name of the module instead.    
"""


if __name__ == "__main__":
    print("Executing test.py as the main script")

############################################################################

""" Importing from a package """

# Importing from a submodule
import iti
iti.greeting.greet_user()

# Direct function import
from iti.greeting import greet_user
greet_user()




