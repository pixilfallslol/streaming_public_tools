from twitchAPI.chat import Chat, EventData, ChatMessage, ChatSub, ChatCommand
from twitchAPI.type import AuthScope, ChatEvent
from twitchAPI.oauth import UserAuthenticator
from twitchAPI.twitch import Twitch
import creds
import asyncio
import keyboard
import pydirectinput
import pyautogui
import time
import os

APP_ID = creds.APP_ID
APP_SECRET = creds.APP_SECRET
USER_SCOPE = [AuthScope.CHAT_READ, AuthScope.CHAT_EDIT, AuthScope.CHANNEL_MANAGE_BROADCAST]
TARGET_CHANNEL = "pixilfalls"

messages = ""

BACKUP_FILE_NAME = "chats.txt"

twitch = None

async def on_message(msg: ChatMessage):
    author = msg.user.display_name.strip()
    messages = msg.text.strip()
    with open(BACKUP_FILE_NAME,"a+") as f:
        f.write(author+" "+messages+"\n")
    print(author+" said: "+messages)
    if "!cmd" in messages.lower():
        runCMD()
    else:
        typeMessage(messages)

async def on_ready(ready_event: EventData):
    global TARGET_CHANNEL
    await ready_event.chat.join_room(TARGET_CHANNEL)
    print("Listening!")
    
async def run_bot():
    global twitch
    twitch = await Twitch(APP_ID,APP_SECRET)
    auth = UserAuthenticator(twitch,USER_SCOPE,force_verify=False,port=17563)
    token,refresh = await auth.authenticate()
    await twitch.set_user_authentication(token,USER_SCOPE,refresh)
    chat = await Chat(twitch)
    chat.register_event(ChatEvent.READY,on_ready)
    chat.register_event(ChatEvent.MESSAGE,on_message)
    chat.start()
    print("Listening to chat")
    try:
        while True:
            await asyncio.sleep(1)
    except:
        pass
    finally:
        chat.stop()
        await twitch.close()

def typeMessage(m):
    time.sleep(2)
    typeEnter(m)
    if "enter" in m.lower():
        clean = m.lower().replace("enter","").strip()
        if clean:
            keyboard.write(clean)
        keyboard.press("enter")
        return
    keyboard.write(m)

def typeEnter(m):
    if m.lower() == "enter":
        keyboard.press("enter")
        return
            
def runCMD():
    os.system("start cmd /k") 
    time.sleep(1)
    keyboard.write("python viewer_code.py")
    keyboard.press("enter")
    time.sleep(5)
    keyboard.write("exit")
    keyboard.press("enter")

def run():
    print("\n\nRunning\n\n")
    asyncio.run(run_bot())

if __name__ == "__main__":
    run()