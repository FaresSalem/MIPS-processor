import sys
import os
from assembler import *
import subprocess
import filecmp

def check_RegisterFile(i):
     cwd = os.getcwd()
     output = open('{}/Register_File.txt'.format(cwd))
     correct = open('{}/correct_RegisterFile{}.txt'.format(cwd,i))
     report = open('{}/automation_Report.txt'.format(cwd), "a")
     if(output.read() == correct.read()):
        report.write("RegisterFile of test{} passed successfuly \n".format(i))
     else:
        report.write("RegisterFile of test{} failed the test \n".format(i))


def check_DataMemory(i):
     cwd = os.getcwd()
     output = open('{}/Data_Memory.txt'.format(cwd)) 
     correct = open('{}/correct_DataMemory{}.txt'.format(cwd,i))
     report = open('{}/automation_Report.txt'.format(cwd), "a")
     if(output.read() == correct.read()):
        report.write("DataMemory of test{} passed successfuly \n\n".format(i))
     else:
        report.write("DataMemory of test{} failed the test \n\n".format(i))
     

def start_assembling():
    file = open('Mips_Assembly.txt', 'r')
    lines = file.readlines()
    print(lines)
    file.close()
    lable_dict =[]
    return lines
    
    
for i in range(10):
    os.rename("test{}.txt".format(i), "Mips_Assembly.txt")
  
    lines = start_assembling()
    instruction_array = parse(start_assembling())
    label = extract_labels(lines)
    assembling(instruction_array, label)
    
    subprocess.run(["vsim", "-c", "-do", "run 6000", "work.tb_full", "-c", "-do", "exit"])
    check_RegisterFile(i)
    check_DataMemory(i)
    
    os.rename( "Mips_Assembly.txt", "test{}.txt".format(i))
    