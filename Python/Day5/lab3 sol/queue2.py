class QueueOutOfRangeException(Exception):
    pass

class AnotherQueue:
    all_queues = {}

    def __init__(self, name, size):
        self.name = name
        self.size = size
        self.items = []
        AnotherQueue.all_queues[name] = self


    def size_queue(self):
        return len(self.items)

    @classmethod
    def get_queue_by_name(cls, name):
        return cls.all_queues.get(name)

    @classmethod
    def save(cls, filename="queues.txt"):
        with open(filename, "w") as f:
            for name, queue in cls.all_queues.items():
                line = f"{name}|{queue.size}|{','.join(queue.items)}\n"
                f.write(line)

    @classmethod
    def load(cls, filename="queues.txt"):
        cls.all_queues = {}
        try:
            with open(filename, "r") as f:
                for line in f:
                    line = line.strip()
                    if not line:
                        continue
                    name, size, items_str = line.split("|")
                    q = AnotherQueue(name, int(size))
                    if items_str:
                        q.items = items_str.split(",")
        except FileNotFoundError:
            print(f"File {filename} not found. No queues loaded.")


q1 = AnotherQueue("first", 3)
q1.insert("A")
q1.insert("B")

q2 = AnotherQueue("second", 2)
q2.insert("X")

print("Size of q1:", q1.size_queue())

q = AnotherQueue.get_queue_by_name("second")
print("Items in second queue:", q.items)

AnotherQueue.save("queues.txt")

AnotherQueue.load("queues.txt")
print("Loaded queues:", AnotherQueue.all_queues.keys())
