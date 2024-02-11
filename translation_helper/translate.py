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

def copy_clipboard():
    pyautogui.hotkey('ctrl', 'c')
    
    sleep(.01)  # ctrl-c is usually very fast but your program may execute faster
    return pyperclip.paste()

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
    
    clipboard.copy(translation)
    sleep(.01)
    keyboard.send('ctrl+v')
    
    return translation

translate()