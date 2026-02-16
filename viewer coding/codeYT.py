import pytchat
import time
import keyboard
import pydirectinput
import pyautogui
import os

video = input("Enter a video id: ")

USER_FILE = "chats.txt"

messages = ""

def getChat(v):
    chat = pytchat.create(video_id=v)
    while chat.is_alive():
        try:
            for c in chat.get().sync_items():
                name = c.author.name
                name = name.replace("@","")
                msg = c.message
                with open(USER_FILE,"a",encoding="utf-8") as f:
                    f.write(name+" "+msg+"\n")
                    print("ADDED USER "+name+" "+msg)
                if "!cmd" in msg.lower():
                    runCMD()
                elif "!code" in msg.lower():
                    msg = msg.lower().replace("!code","").strip()
                    typeMessage(msg)
                elif "!back" in msg.lower():
                    msg = msg.lower().replace("!back","").strip()
                    keyboard.press("backspace")
                    keyboard.release("backspace")
        except AttributeError:
            print("Errorrr ")
            chat = pytchat.create(video_id=v)

def typeMessage(m):
    time.sleep(2)
    typeEnter(m)
    if "!enter" in m.lower():
        clean = m.lower().replace("!enter","").strip()
        if clean:
            keyboard.write(clean)
        keyboard.press("enter")
        keyboard.release("enter")
        return
    keyboard.write(m)
    time.sleep(2)
    keyboard.press("ctrl+s")
    keyboard.release("ctrl+s")

def typeEnter(m):
    if m.lower() == "!enter":
        keyboard.press("enter")
        keyboard.release("enter")
        return
        
def runCMD():
    os.system("start cmd /k") 
    time.sleep(1)
    keyboard.write("python viewer_code.py")
    keyboard.press("enter")
    keyboard.release("enter")
    time.sleep(5)
    keyboard.write("exit")
    keyboard.press("enter")
    keyboard.release("enter")

def restartHour(v):
    while True:
        print("STARTED THE HOUR LOOP")
        start = time.time()
        getChat(v)
        elapsed = time.time()-start
        rem = 3600-elapsed
        if rem>0:
            print("Session ran for "+str(elapsed)+" waiting "+rem+" before")
            time.sleep(rem)
        print("RESTARTING!")

restartHour(video)