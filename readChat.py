import pytchat
from pytchat import LiveChat, SpeedCalculator
import pyttsx3
import time

VIDEO_ID = input("Enter a live steam video id to get the chats: ")

def tts(text):
    engine = pyttsx3.init()
    engine.say(text)
    engine.runAndWait()

def readChat():
    chat = pytchat.create(video_id = VIDEO_ID)
    sChat = pytchat.create(video_id = VIDEO_ID, processor = SpeedCalculator(capacity = 20))
    
    while chat.is_alive():
        for c in chat.get().sync_items():
            print(f"\n{c.datetime} [{c.author.name}]- {c.message}\n")
            message = c.message
            author = c.author.name
            tts(author)
            tts(message)
            
            """if sChat.get() >= 20:
                chat.terminate()
                sChat.terminate()
                return"""
            
            #time.sleep(15)
            
readChat()