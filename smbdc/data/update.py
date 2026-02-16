import keyboard

with open("count.txt","w") as f:
    f.write("0")

count = 0

def updateCount():
    global count
    print("RUNNING!")
    keyboard.wait("f")
    count+=1
    print("UPDATED COUNT! "+str(count))
    with open("count.txt","w") as f:
        f.write(str(count))

while True:
    updateCount()