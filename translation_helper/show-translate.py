import tkinter as tk
import requests
import clipboard
from lingua import Language, LanguageDetectorBuilder
import pyautogui
from time import sleep
import pyperclip
import json
import keyboard

def auto_detect_source_language(text):
    languages = [Language.ENGLISH, Language.SPANISH]
    detector = LanguageDetectorBuilder.from_languages(*languages).build()
    
    source_lang = detector.detect_language_of(text)
    
    return "en" if source_lang == Language.ENGLISH else "es"

def make_api_request(text, source_lang, target_lang):
    data = {
    'source_lang': source_lang,
    'target_lang': target_lang,
    'text': text
    }

    headers = {
        'Content-Type': 'application/json'
    }

    try:
        response = requests.post("http://localhost:1188/translate", data=json.dumps(data), headers=headers)
        response.raise_for_status()
        result = response.json()

        if 'data' in result:
            return result['data']
        else:
            raise json.dumps(result)

    except requests.exceptions.RequestException as e:
        raise f"Http Request Error\nHttp Status: {response.status_code}\n{response.text}"

def translate():
    print("Translating...")
          
    # copy the selected text
    # copy_clipboard()
    
    # get the text from clipboard
    text = clipboard.paste()

    # auto detect the source language
    source_lang = auto_detect_source_language(text)
    target_lang = "es" if source_lang == "en" else "en"
    
    print(f"Source Language: {source_lang}")
    print(f"Target Language: {target_lang}")
    
    translation = make_api_request(text, source_lang, target_lang)
    
    print(f"Translation: {translation}")
    
    return translation

def dismiss(event):
    window.destroy()

def translate_and_display():
    translation = translate()

    global window
    
    window = tk.Tk()
    window.overrideredirect(True)  # Remove window borders
    window.attributes('-topmost', True)  # Always on top
    window.configure(bg='black')  # Dark theme background

    screen_width = window.winfo_screenwidth()
    screen_height = window.winfo_screenheight()
    
    widget_width = screen_width // 1.5

    label = tk.Label(window, text=translation, font=("Helvetica", 24), fg="white", bg="black", wraplength=widget_width)
    label.pack(padx=20, pady=20)

    window_width = label.winfo_reqwidth() + 40
    window_height = label.winfo_reqheight() + 40

    x = (screen_width - window_width) // 2
    y = (screen_height - window_height) // 2

    window.geometry(f"{window_width}x{window_height}+{x}+{y}")
    
    # Regain focus to the window
    window.focus_force()

    # Bind event to dismiss the window when focus is lost
    window.bind("<FocusOut>", dismiss)
    
    # Bind ESC key to dismiss the window
    window.bind("<Escape>", dismiss)

    window.mainloop()

translate_and_display()
