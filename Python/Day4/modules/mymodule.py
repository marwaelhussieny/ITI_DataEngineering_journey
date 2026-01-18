""" any .py file is considered to be python module """

name = 'ahmed'

def greet_user():
    """Display a simple greeting."""
    username = input("What is your name? ")
    print(f"Hello!, {username}")


print("I am in Mymodule file")

# restrict that some lines will be executed unless the called from this file / module
if __name__ == "__main__":
    """ Test """
    print(name)
    greet_user()
