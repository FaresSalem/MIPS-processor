from data import instruction_table, register_table
from binHex_converter import hex2bin,dec2bin

file = open('testfile.txt', 'r')
lines = file.readlines()
print(lines)
file.close()
new_label=[]
news_num=[]
liness =(list(enumerate(lines)))

for n in range(len(liness)):
    if ':' in liness[n][1]:
        new_label.append(liness[n][1].split(':')[0])
        news_num.append(n)
instruction_array=[]

def parse(lines):
    for line_i, line in enumerate(lines):
        if':' in line:
            line=line[line.index(':')+1:]
        instruction = line.strip().replace(' ', ',', 1).replace(')', '').replace('(', ',').replace('\n', '')
        instruction = instruction.replace(' ', '').split(',')
        instruction_array.append(instruction)
        print(line)
    return instruction_array


parse(lines)
print(instruction_array)


# the excution  every_list means every line but cut into  list elemnts
c=0
for every_list in instruction_array:
    if str(every_list[0]) == "add":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("add").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[3]), 5)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + shamt + str(
            hex2bin(instruction_table.get("add").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "and":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("and").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[3]), 5)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + shamt + str(
            hex2bin(instruction_table.get("and").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "or":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("or").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[3]), 5)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + shamt + str(
            hex2bin(instruction_table.get("or").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "sub":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("sub").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[3]), 5)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + shamt + str(
            hex2bin(instruction_table.get("sub").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "slt":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("slt").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[3]), 5)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + shamt + str(
            hex2bin(instruction_table.get("slt").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "nor":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("nor").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[3]), 5)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + shamt + str(
            hex2bin(instruction_table.get("nor").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "sll":
        shamt = str(dec2bin(every_list[3], 5))
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("sll").get("opcode"), 6)) + "00000" + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + shamt + str(
            hex2bin(instruction_table.get("sll").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "srl":
        shamt = str(dec2bin(every_list[3], 5))
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("srl").get("opcode"), 6)) + "00000" + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + shamt + str(
            hex2bin(instruction_table.get("srl").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "beq":
        for k in range(len(news_num)):
            if every_list[3] == new_label[k]:
                Mc_file = open("output.txt", "a")
                address =news_num[k]-(c+1)
                Mc_file.write(str(hex2bin(instruction_table.get("beq").get("opcode"), 6)) + str(
                    hex2bin(register_table.get(every_list[1]), 5)) + str(
                    hex2bin(register_table.get(every_list[2]), 5)) + str(dec2bin(address, 16)) + "\n")
                Mc_file.close()
                c = c + 1

    elif str(every_list[0]) == "bne":
        for k in range(len(news_num)):
            if every_list[3] == new_label[k]:
                Mc_file = open("output.txt", "a")
                address = news_num[k]-(c+1)
                Mc_file.write(str(hex2bin(instruction_table.get("bne").get("opcode"), 6)) + str(
                    hex2bin(register_table.get(every_list[1]), 5)) + str(
                    hex2bin(register_table.get(every_list[2]), 5)) + str(dec2bin(address, 16)) + "\n")
                Mc_file.close()
                c = c + 1

    elif str(every_list[0]) == "addi":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("addi").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[1]), 5)) + str(
            dec2bin(every_list[3], 16)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "ori":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("ori").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[1]), 5)) + str(
            dec2bin(every_list[3], 16)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "andi":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("andi").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[2]), 5)) + str(hex2bin(register_table.get(every_list[1]), 5)) + str(
            dec2bin(every_list[3], 16)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "lw":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("lw").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[3]), 5)) + str(hex2bin(register_table.get(every_list[1]), 5)) + str(
            dec2bin(every_list[2], 16)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "sw":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("sw").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[3]), 5)) + str(hex2bin(register_table.get(every_list[1]), 5)) + str(
            dec2bin(every_list[2], 16)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "jr":
        shamt = "00000"
        Mc_file = open("output.txt", "a")
        Mc_file.write(str(hex2bin(instruction_table.get("jr").get("opcode"), 6)) + str(
            hex2bin(register_table.get(every_list[1]), 5)) + "00000" + "00000" + shamt + str(
            hex2bin(instruction_table.get("jr").get("func"), 6)) + "\n")
        Mc_file.close()
        c = c + 1

    elif str(every_list[0]) == "j":
        for k in range (len(news_num)):
            if every_list[1] == new_label[k]:
                Mc_file = open("output.txt", "a")
                address=news_num[k]
                Mc_file.write(str(hex2bin(instruction_table.get("j").get("opcode"), 6)) + str(dec2bin(address,26)) + "\n")
                Mc_file.close()
                c = c + 1


    elif str(every_list[0]) == "jal":
        for k in range(len(news_num)):
            if every_list[1] == new_label[k]:
                Mc_file = open("output.txt", "a")
                address = news_num[k]
                Mc_file.write(
                    str(hex2bin(instruction_table.get("jal").get("opcode"), 6)) + str(dec2bin(address, 26)) + "\n")
                Mc_file.close()
                c = c + 1




