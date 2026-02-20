import speech_recognition
from rich import print
import time

recognizer = speech_recognition.Recognizer()
rT = ""
def listenToMic():
    global rT, recognizer
    while True:
        try:
            with speech_recognition.Microphone() as mic:
                recognizer.dynamic_energy_threshold = False
                recognizer.energy_threshold = 200
                recognizer.adjust_for_ambient_noise(mic,duration=0.5)
                recognizer.pause_threshold = 0.8
                print("[blue]Listening")
                audio = recognizer.listen(mic)
                text = recognizer.recognize_google(audio).lower()
                print("[blue]Heard:", text)
                with open("data.txt","w") as f:
                    f.write(text+"\n")
                with open("draw.txt","w") as f:
                    f.write("yes")
                time.sleep(5)
                with open("draw.txt","w") as f:
                    f.write("no")

        except speech_recognition.UnknownValueError:
            print("[red]Didn’t understand, try again.")
        except speech_recognition.RequestError as e:
            print(f"[red]Speech recognition API error: {e}")
        except Exception as e:
            print(f"[red]Error: {e}")
            recognizer = speech_recognition.Recognizer()
            continue

listenToMic()