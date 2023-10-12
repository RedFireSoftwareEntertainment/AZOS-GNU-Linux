import os
import tkinter as tk
root = tk.Tk()
screenwidth = root.winfo_screenwidth()
screenheight = root.winfo_screenheight()

os.system('pip install screeninfo --break-system-packages&')
os.system('pip install pywebview --break-system-packages&')

import webview
import webview.menu as wm

xpos = screenwidth

homepage = "https://duckduckgo.com"

def home():
    window.load_url(homepage)

def read_cookies(window):
    cookies = window.get_cookies()
    for c in cookies:
        print(c.output())

def contact_us():
    window.load_url('https://docs.google.com/forms/d/e/1FAIpQLSel3_55JQoM4nj1tf4JfudZHA9ERMi13SUcGT688aCINJj-cA/viewform')

def protondb():
    window.load_url('https://www.protondb.com/explore')

def do_nothing():
    pass

if __name__ == '__main__':
    window = webview.create_window(
        'AZOS GNU/Linux Hub', homepage, frameless=True, easy_drag=False, on_top=True, width=450, height=screenheight, x=xpos, y=100
    )

    menu_items = [
        wm.Menu(
            'Menu',
            [
                wm.MenuAction('Home', home),
                wm.MenuAction('ProtonDB', protondb),
                wm.MenuSeparator(),
                wm.MenuAction('Contact Us', contact_us),
            ],
        ),
    ]

    webview.start(read_cookies, window, private_mode=False, menu=menu_items)




