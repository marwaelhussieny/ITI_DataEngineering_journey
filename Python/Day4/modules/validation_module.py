def is_number(num):
    """Check if a value is an integer or float."""
    if isinstance(num, int) or isinstance(num, float):
        return True
    return False

def is_empty_string(string):
    """Check if a given string is empty or None."""
    if isinstance(string, str) and len(string) > 0:
        return False
    return True


# email


# phone



if __name__ == '__main__':
    """ Test cases """
    print("*************Test is_number() function*************")
    print(is_number(34))
    print(is_number(34.34))
    print(is_number("iti"))
    print(is_number(None))
    print("*************Test is_empty_string() function*************")
    print(is_empty_string(None))
    print(is_empty_string(" "))
    print(is_empty_string("iti"))
