#!/usr/bin/python

import re
import subprocess
import os
import time
import json

def run_command(cmd):
    cmd = "/bin/bash -c '"+cmd+"'"
    subprocess.call([cmd], shell=True)


def get_value(cmd):
    return subprocess.check_output(cmd,shell = True).decode("utf-8").strip()

# check if script alread running
if get_value("ps -ef | grep -v grep | grep -c "+os.path.basename(__file__)) != "1":
    exit()


home_dir = os.path.expanduser("~")
curr_wall = home_dir+"/.config/awesome/themes/custom/wall.jpg"
notes = home_dir+"/.config/awesome/notes.json"

curr_dir = os.path.dirname(os.path.realpath(__file__))

text_color = "white"   # text color
# text size (real size depends on the scale factor of your wallpaper)
size = "20"
border = 120           # space around your text blocks
columns = 2          # (max) number of columns
n_lines = 20          # (max) number of lines per column
font = 'Caskaydia-Cove-Nerd-Font-Complete-Light'





def read_text(file):
    with open(file) as src:
        data = json.load(src)
        arr = []
        s = "To-Do Tasks"
        arr.append(s)
        for count, item in enumerate(data["todo_items"]):
            if item["status"]:
                s = "URGENT " + str(count+1) + ". " + str(item["todo_item"])
            else:
                s = "\t\t\t\t\t\t\t" + \
                    str(count+1) + ". " + str(item["todo_item"])
            arr.append(s)
        return arr


def slice_lines(lines, n_lines, columns):
    markers = [i for i in range(len(lines)) if i % n_lines == 0]
    last = len(lines)
    markers = markers+[last] if markers[-1] != last else markers
    textblocks = [lines[markers[i]:markers[i+1]]
                  for i in range(len(markers)-1)]
    filled_blocks = len(textblocks)
    if filled_blocks < columns:
        for n in range(columns - filled_blocks):
            textblocks.insert(len(textblocks), [])
    for i in range(columns):
        textblocks[i] = ("\n").join(textblocks[i])
    return textblocks[:columns]


def create_section(psize, text, layer):
    run_command("convert -background none -font "+font+" -fill "+text_color+" -border "+str(border) +
                " -bordercolor none -pointsize "+size+" -size "+psize +
                " caption:"+'"'+text+'" '+layer)


def set_overlay():
    boxes = slice_lines(read_text(notes), n_lines, columns)
    resolution = get_value('identify -format %wx%h '+curr_wall).split("x")
    w = str(int(int(resolution[0])/columns)-2*border)
    h = str(int(resolution[1])-2*border)
    layers = []
    for i in range(len(boxes)):
        layer = curr_dir+"/"+"layer_"+str(i+1)+".png"
        create_section(w+"x"+h, boxes[i], layer)
        layers.append(layer)
    run_command("convert "+(" ").join(layers)+" " +
                "+append "+curr_dir+"/"+"layer_span.png")
    wall_img = curr_dir+"/"+"walltext.jpg"
    run_command("convert "+curr_wall+" "+curr_dir+"/" +
                "layer_span.png"+" -background None -layers merge "+wall_img)
    run_command("feh --bg-fill "+wall_img)
    for img in [img for img in os.listdir(curr_dir) if img.startswith("layer_")]:
        os.remove(curr_dir+"/"+img)


wall_img = curr_dir+"/"+"walltext.jpg"
run_command("feh --bg-fill "+wall_img)
while True:
    text_1 = read_text(notes)
    time.sleep(5)
    text_2 = read_text(notes)
    if text_2 != text_1:
        set_overlay()
