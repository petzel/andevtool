import pickle
from GUI import Application, ScrollableView, Document, \
Window, Cursor, rgb, Button, Row, TextField, TextEditor
import subprocess

class MyApp(Application):

    def __init__(self):
        Application.__init__(self)

    def open_app(self):
        self.make_window(None)

    def make_window(self, document):
        win = Window(size = (400, 400), document = document)
        win.set_title("HEY")
        button = Button(title = "ONE", style = 'default', action = 'default_action')
        win.place(button)

        items = []
        items.append(Button(title = "2", style = 'default', action = 'default_action1'))
        items.append(Button(title = "3", style = 'default', action = 'default_action2'))
        items.append(Button(title = "4", style = 'default', action = 'default_action3'))

        row = Row(items, spacing=10, padding=(2,2), align='c', equalize='wh', expand=None)
        win.place(row, top=button)
        text = TextEditor()
        win.place(text, top=row, scrolling='hv')

        p = subprocess.Popen('adb logcat -d -v threadtime', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        for line in p.stdout.readlines():
          text.paste_cmd()
        retval = p.wait()

        win.show()

MyApp().run()
