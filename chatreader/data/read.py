import pyttsx3

# https://www.youtube.com/watch?v=jfKfPfyJRdk

import pytchat
import time

video = input("Enter a video id: ")

USER_FILE = "users.txt"

open(USER_FILE,"w").close()

def speak(t):
    e = pyttsx3.init('sapi5')
    e.setProperty('rate', 180)
    e.setProperty('volume', 1)
    e.say(t)
    e.runAndWait()
    e.stop()

def getChat(v):
    chat = pytchat.create(video_id=v)
    while chat.is_alive():
        try:
            for c in chat.get().sync_items():
                name = c.author.name
                name = name.replace("@","")
                msg = c.message
                speak(name+" "+msg)
                with open(USER_FILE,"a",encoding="utf-8") as f:
                    f.write(name+": "+msg+"\n")
                    print("ADDED USER "+name+" "+msg)
        except AttributeError:
            print("Errorrr ")
            chat = pytchat.create(video_id=v)

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