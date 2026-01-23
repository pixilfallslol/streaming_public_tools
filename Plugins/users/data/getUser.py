from twitchAPI.chat import Chat, EventData, ChatMessage, ChatSub, ChatCommand
from twitchAPI.type import AuthScope, ChatEvent
from twitchAPI.oauth import UserAuthenticator
from twitchAPI.twitch import Twitch
import creds
import asyncio

APP_ID = creds.APP_ID
APP_SECRET = creds.APP_SECRET
USER_SCOPE = [AuthScope.CHAT_READ, AuthScope.CHAT_EDIT, AuthScope.CHANNEL_MANAGE_BROADCAST]
TARGET_CHANNEL = "pixilfalls"

CMD = "!add"

author = ""

seenUsers = set()

USER_FILE_NAME = "users.txt"

twitch = None

def loadUsers():
    global seenUsers
    with open(USER_FILE_NAME,"r") as f:
        for line in f:
            name = line.strip()
            if name:
                seenUsers.add(name.lower())

async def on_message(msg: ChatMessage):
    author = msg.user.display_name.strip()
    key = author.lower()
    if key in seenUsers:
        return
    seenUsers.add(key)
    with open(USER_FILE_NAME,"a+") as f:
        f.write(author+"\n")
    print("ADDED "+author)

async def on_ready(ready_event: EventData):
    global TARGET_CHANNEL
    await ready_event.chat.join_room(TARGET_CHANNEL)
    print("Listening!")
    
async def run_bot():
    global twitch
    loadUsers()
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

def run():
    print("\n\nRunning\n\n")
    asyncio.run(run_bot())

if __name__ == "__main__":
    run()