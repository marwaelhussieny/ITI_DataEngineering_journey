class queue:
    def __init__(self):
        self.items=[]

    def insert(self, value):
        self.items.append(value)

    def isEmpty(self):
        return len(self.items) == 0    

    def pop(self):
        if self.isEmpty():
            print("queue is empty")
            return None
        return self.items.pop(0) 
    

    def size(self):
        return len(self.items) 
    
    # testing
myQueue = queue()

myQueue.insert('A')
myQueue.insert('B')
myQueue.insert('C')

print("Is Empty:", myQueue.isEmpty())
print("Size before dequeue:", myQueue.size())
print("Dequeue:", myQueue.pop())
print("Is Empty after pop:", myQueue.isEmpty())
print("Size after dequue:", myQueue.size())