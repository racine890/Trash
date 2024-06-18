from ch2 import ch_data
from tkinter import messagebox

def restoreApp(projectFold):
    appName = ch_data('Title:', projectFold+'home.ch')
    appCore = ch_data('use', projectFold+'home.ch', alt='win32')
    appIcon = ch_data('AppIcon', projectFold+'home.ch', alt='win32')
    file = open('C:\\GC\\installed\\installed.dat','r')
    lines = file.read().split('#END')[0]
    file.close()
    lines+=appName+';'+projectFold+';'+appCore+';'+appIcon+'\n#END'
    file = open('C:\\GC\\installed\\installed.dat', 'w')
    file.write(lines)
    file.close()

USE_MODULE_FUNCS = {
    'ra' : restoreApp
}