import pytchat
from pytchat import LiveChat, SpeedCalculator
import pyttsx3
import time
import pygame
import threading

BG_COLOR = (0,0,0)

WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

pygame.init()
screen = pygame.display.set_mode((WINDOW_WIDTH,WINDOW_HEIGHT))

fontTiny = pygame.font.Font("OpenSans-CondLight.ttf", 18)
fontSmall = pygame.font.Font("OpenSans-CondLight.ttf", 23)
font18 = pygame.font.Font("OpenSans-CondLight.ttf", 19)
font36 = pygame.font.Font("OpenSans-CondLight.ttf", 38)

reading = True

VIDEO_ID = input("Enter a live steam video id to get the chats: ")

currentMessage = ""
currentMessager = ""

engine = pyttsx3.init()

def refreshCanvas():
    canvassy = pygame.surface.Surface((WINDOW_WIDTH, WINDOW_HEIGHT))
    canvassy.fill(BG_COLOR)
    print("Canvas refreshed!")

def tts(text):
    engine.say(text)
    engine.runAndWait()
    refreshCanvas()

def readChat(chat):
    global currentMessage
    global currentMessager
    while chat.is_alive() and reading:
        for c in chat.get().sync_items():
            print(f"\n{c.datetime} [{c.author.name}] - {c.message}\n")
            currentMessage = c.message
            currentMessager = c.author.name
            tts(c.author.name)
            tts(c.message)

def drawMessage(m,m2):
    message_surf = font36.render(m2+": "+m,1,(255,255,255))
    screen.blit(message_surf,(100,200))
    pygame.display.flip()

if __name__ == "__main__":
    chat = pytchat.create(video_id=VIDEO_ID)
    ct = threading.Thread(target=readChat,args=(chat,),daemon=True)
    ct.start()
    
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    running = False
                    reading = False



        screen.fill(BG_COLOR)
        drawMessage(currentMessage,currentMessager)
        pygame.display.flip()