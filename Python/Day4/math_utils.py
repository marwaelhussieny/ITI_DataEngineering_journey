
def add(a, b):
    result = a + b
    return result


def subtract(a, b):
    result = a - b
    return result


def multiply(a, b):
    result = a * b
    return result


def division(a, b):
    try:
        result = a / b
        return result
    except ZeroDivisionError:
        return "You cannot divide by zero"



import math_utils

print(math_utils.add(5, 3))
print(math_utils.subtract(10, 4))
print(math_utils.multiply(2, 6))
print(math_utils.division(10, 0))

import math_utils as mu

print(mu.add(4, 2))
print(mu.subtract(8, 3))
print(mu.multiply(3, 3))
print(mu.division(9, 3))

