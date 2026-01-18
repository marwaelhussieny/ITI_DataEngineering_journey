class Student:
    """comment"""
    count = 0

    def __init__(self, fname, lname, age):
        self.fname = fname
        self.lname = lname
        self.age = age
        # Student.count += 1
        self.__class__.count += 1
        self.id = Student.count

    def print_info(self):
        print(f"fname {self.fname} lname {self.lname} age {self.age}")

    @classmethod
    def count_std(cls):
        print(cls.count)


std = Student("Mona", "Ali", 28)
std.print_info()


std2 = Student("Julian", "Julian", 22)


std3 = Student("Julian", "Julian", 22)

Student.count_std()



