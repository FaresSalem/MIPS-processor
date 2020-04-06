'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
*	Project			: 		A GUI MIPS assembler
*	Author 			: 		Fares Salem
*	E-Mail 			: 		faressalem@pm.me
*	Organization 	: 		Faculty of Engineering - Ain Shams University
* 	Date 			:       24-Oct-19
*	Last-Mod		:       
*	
*	Notes			:		1) please adjust the tab size of the editor to 4

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
# Defining Python Source Code Encodings, DO NOT REMOVE.
# ! /usr/bin/env python
# -*- coding: utf-8 -*-

import tkinter as tk
import tkinter.ttk as ttk
import sys
import os
from assembler import *
import subprocess

def create_window():
    global val, w, root
    root = tk.Tk()      # creating a tkinter window
    top = MainFrame(root)
    init(root, top)
    root.mainloop()     # infinte loop
    
def destroy_window():   # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

def init(top, gui, *args, **kwargs):
    global w, top_level, root
    w = gui
    top_level = top
    root = top 

def RUN_button(b1):
    print("RUN BUTTON CLICKED")
    sys.stdout.flush()
    save_text()              # saves text written in the GUI editor to a .txt file
    
    lines = start_assembling()
    instruction_array = parse(lines)
    label = extract_labels(lines)
    assembling(instruction_array, label)
    
    # subprocess.run(["vsim", "-c", "-do", "run 6000",  "work.tb_full", "-c", "-do", "exit"])
    if (MainFrame.step_count == 0):
        MainFrame.step_count = 1
        subprocess.run(["vsim", "-c", "-do", "run 600",  "work.tb_full", "-c", "-do", "test.tcl"])
    # else:                                                     "-c", "-do", "looping.do", "exit"
        # print("bye")
        # subprocess.run(["vsim", "-do", "run 600"])
    
    Import_RegisterFile() 
    Import_DataMemory()

def Import_RegisterFile():
     cwd = os.getcwd()
     file = open('{}/Register_File.txt'.format(cwd))
     w.RegisterFile.configure(state='normal')
     w.RegisterFile.delete('1.0', 'end')
     w.RegisterFile.insert('1.0', file.read())
     w.RegisterFile.configure(state='disabled')

def Import_DataMemory():
     cwd = os.getcwd()
     file = open('{}/Data_Memory.txt'.format(cwd))
     w.DataMemory.configure(state='normal')
     w.DataMemory.delete('1.0', 'end')
     w.DataMemory.insert('1.0', file.read())
     w.DataMemory.configure(state='disabled')
       
def start_assembling():
    file = open('Mips_Assembly.txt', 'r')
    lines = file.readlines()
    print(lines)
    file.close()
    # lable_dict =[]
    return lines
  
def save_text():
    cwd = os.getcwd()
    file = open('{}/Mips_Assembly.txt'.format(cwd), 'w')
    file.write(w.editor.get("1.0","end-1c"))
   
'''This class configures and populates the toplevel window.
   top is the toplevel containing window.'''
class MainFrame:    
    step_count = 0
    def __init__(self, top=None):
        _bgcolor = '#d9d9d9'  # X11 color: 'gray85'
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#d9d9d9' # X11 color: 'gray85'
        _ana1color = '#d9d9d9' # X11 color: 'gray85'
        _ana2color = '#ececec' # Closest X11 color: 'gray92'
        font9 = "-family {Segoe UI} -size 9 -weight normal -slant "  \
            "roman -underline 0 -overstrike 0"
        self.style = ttk.Style()
        if sys.platform == "win32":
            self.style.theme_use('winnative')
        self.style.configure('.',background=_bgcolor)
        self.style.configure('.',foreground=_fgcolor)
        self.style.configure('.',font="TkDefaultFont")
        self.style.map('.',background =[('selected', _compcolor), ('active',_ana2color)])

        top.geometry("820x490+250+113")     # the size and initial position of the window 
        top.minsize(120, 1)
        top.maxsize(2970, 881)
        top.resizable(0, 0)
        top.title("A Bahlool Assembler :D")
      #  top.wm_iconbitmap(r'C:\Users\fares\Desktop\PROJECT OF CO\Pages GUI\first proj\icon.ico')
        top.configure(background="#454545")
        top.configure(cursor="top_left_arrow")
        top.configure(highlightbackground="#d9d9d9")
        top.configure(highlightcolor="#000000")

        self.Separator = ttk.Separator(top)
        self.Separator.place(relx=0.598, rely=0.082, relheight=0.906)
        self.Separator.configure(orient="vertical")

        self.Label = tk.Label(top)
        self.Label.place(relx=0.0, rely=0.0, height=37, width=296)
        self.Label.configure(activebackground="#f9f9f9")
        self.Label.configure(activeforeground="black")
        self.Label.configure(background="#454545")
        self.Label.configure(disabledforeground="#a3a3a3")
        self.Label.configure(font="-family {Segoe UI Black} -size 16 -weight bold -slant italic")
        self.Label.configure(foreground="#ffffff")
        self.Label.configure(highlightbackground="#d9d9d9")
        self.Label.configure(highlightcolor="black")
        self.Label.configure(text='''Write a وبالسمسم حلو code here''')

        self.menubar = tk.Menu(top,font=font9,bg=_bgcolor,fg=_fgcolor)
        top.configure(menu = self.menubar)

        self.style.configure('TNotebook.Tab', background=_bgcolor)
        self.style.configure('TNotebook.Tab', foreground=_fgcolor)
        self.style.map('TNotebook.Tab', background = [('selected', _compcolor), ('active',_ana2color)])
        
        self.TNotebook1 = ttk.Notebook(top)
        self.TNotebook1.place(relx=0.622, rely=0.082, relheight=0.91, relwidth=0.371)
        self.TNotebook1.configure(takefocus="")
        self.TNotebook1_t0 = tk.Frame(self.TNotebook1)
        self.TNotebook1.add(self.TNotebook1_t0, padding=3)
        self.TNotebook1.tab(0, text="Registers", compound="left", underline="-1",)
        self.TNotebook1_t0.configure(background="#d9d9d9")
        self.TNotebook1_t0.configure(highlightbackground="#d9d9d9")
        self.TNotebook1_t0.configure(highlightcolor="black")
        self.TNotebook1_t1 = tk.Frame(self.TNotebook1)
        self.TNotebook1.add(self.TNotebook1_t1, padding=3)
        self.TNotebook1.tab(1, text="Data Memory", compound="left", underline="-1",)
        self.TNotebook1_t1.configure(background="#d9d9d9")
        self.TNotebook1_t1.configure(highlightbackground="#d9d9d9")
        self.TNotebook1_t1.configure(highlightcolor="black")
        
        self.TNotebook2 = ttk.Notebook(top)
        self.TNotebook2.place(relx=0.012, rely=0.082, relheight=0.91, relwidth=0.566)
        self.TNotebook2.configure(takefocus="")
        self.TNotebook2_t0 = tk.Frame(self.TNotebook2)
        self.TNotebook2.add(self.TNotebook2_t0, padding=3)
        self.TNotebook2.tab(0, text="Mips_Assembly.txt", compound="left",underline="-1", )
        self.TNotebook2_t0.configure(background="#d9d9d9")
        self.TNotebook2_t0.configure(highlightbackground="#d9d9d9")
        self.TNotebook2_t0.configure(highlightcolor="black")



        self.RegisterFile = tk.Text(self.TNotebook1_t0)
        self.RegisterFile.place(relx=0.0, rely=0.0, relheight=1.01, relwidth=1.013)
        self.RegisterFile.configure(background="#000040")
        self.RegisterFile.configure(exportselection="0")
        self.RegisterFile.configure(font="-family {Segoe UI} -size 10 -weight bold")
        self.RegisterFile.configure(foreground="#ffffff")
        self.RegisterFile.configure(highlightbackground="#d9d9d9")
        self.RegisterFile.configure(highlightcolor="black")
        self.RegisterFile.configure(insertbackground="#ffffff")
        self.RegisterFile.configure(selectbackground="#c4c4c4")
        self.RegisterFile.configure(selectforeground="black")
        self.RegisterFile.configure(state='disabled')
        self.RegisterFile.configure(wrap="word")
        self.RegisterFile.configure(tabs = ("0.65c"))
    
        cwd = os.getcwd()
        file = open('{}/Register_File.txt'.format(cwd))
        self.RegisterFile.configure(state='normal')     
        self.RegisterFile.insert('end', file.read())
        self.RegisterFile.configure(state='disabled')
        
        
        self.DataMemory = tk.Text(self.TNotebook1_t1)
        self.DataMemory.place(relx=0.0, rely=0.0, relheight=1.01, relwidth=1.013)
        self.DataMemory.configure(background="#000040")
        self.DataMemory.configure(exportselection="0")
        self.DataMemory.configure(font="-family {Segoe UI} -size 10 -weight bold")
        self.DataMemory.configure(foreground="#ffffff")
        self.DataMemory.configure(highlightbackground="#d9d9d9")
        self.DataMemory.configure(highlightcolor="black")
        self.DataMemory.configure(insertbackground="#ffffff")
        self.DataMemory.configure(selectbackground="#c4c4c4")
        self.DataMemory.configure(selectforeground="black")
        self.DataMemory.configure(state='disabled')
        self.DataMemory.configure(wrap="word")
        self.DataMemory.configure(tabs = ("0.65c"))
        
        cwd = os.getcwd()
        file = open('{}/Data_Memory.txt'.format(cwd))
        self.DataMemory.configure(state='normal')
        self.DataMemory.insert('end', file.read())
        self.DataMemory.configure(state='disabled')
        

        self.editor = tk.Text(self.TNotebook2_t0)
        self.editor.place(relx=0.0, rely=0.0, relheight=1.01, relwidth=1.009)
        self.editor.configure(background="#000040")
        self.editor.configure(blockcursor="0")
        self.editor.configure(font="-family {Segoe UI} -size 13 -weight bold")
        self.editor.configure(foreground="#ffffff")
        self.editor.configure(highlightbackground="#d9d9d9")
        self.editor.configure(highlightcolor="#000000")
        self.editor.configure(insertbackground="#ffffff")
        self.editor.configure(selectbackground="#c4c4c4")
        self.editor.configure(selectforeground="black")
        self.editor.configure(wrap="word")

    
        self.RUN_button = tk.Button(self.TNotebook2_t0)
        self.RUN_button.place(relx=0.717, rely=0.762, height=84, width=117)
        self.RUN_button.configure(activebackground="#ececec")
        self.RUN_button.configure(activeforeground="#000000")
        self.RUN_button.configure(background="#3c3c3c")
        self.RUN_button.configure(disabledforeground="#575757")
        self.RUN_button.configure(font="-family {Arial} -size 14 -weight bold")
        self.RUN_button.configure(foreground="#00b72e")
        self.RUN_button.configure(highlightbackground="#d9d9d9")
        self.RUN_button.configure(highlightcolor="black")
        self.RUN_button.configure(pady="0")
        self.RUN_button.configure(takefocus="0")
        self.RUN_button.configure(text='''RUN ME
بشمهندس يا
  :D''')
        self.RUN_button.bind('<Button-1>', lambda b1:RUN_button(b1))
        
if __name__ == '__main__':
    create_window()