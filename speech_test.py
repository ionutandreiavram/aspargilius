import speech_recognition as sr

recognizer = sr.Recognizer()

# Use the default microphone as the audio source
with sr.Microphone() as source:
    print("Adjusting for ambient noise...")
    recognizer.adjust_for_ambient_noise(source)
    print("Please say something...")
    audio = recognizer.listen(source)

# Recognize speech using Google's speech recognition
try:
    print("You said: " + recognizer.recognize_google(audio))
except sr.UnknownValueError:
    print("Sorry, I could not understand that.")
except sr.RequestError:
    print("Sorry, the service is down.")
