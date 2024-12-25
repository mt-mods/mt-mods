#!/usr/bin/python

# simple python file to convert minetest description.txt and depends.txt files to mod.conf files
# takes one argument for mod folder path
# license: MIT wsor

import sys
import os.path

if len(sys.argv) == 1:
    print("filepath not provided")
    exit()
elif not os.path.exists(sys.argv[1]):
    print("invalid file path")
    exit()
elif os.path.exists(os.path.join(sys.argv[1], "mod.conf")):
    print("mod.conf already exists!")
    exit()

descpath = os.path.join(sys.argv[1], "description.txt")
deppath = os.path.join(sys.argv[1], "depends.txt")

conffile = open(os.path.join(sys.argv[1], "mod.conf"), "a")

if os.path.exists(descpath):
    descfile = open(descpath, "r")

    if len(open(descpath).readlines(  )) == 1:
        conffile.write("description = " + descfile.readline())
    else:
        conffile.write('description = """\n')

        desclines = descfile.readlines()
        for i in desclines:
            conffile.write(i)
        
        conffile.write('"""\n')
    print("[mt_convert]: description.txt converted")

if os.path.exists(deppath):
    depfile = open(deppath, "r")
    deplines = depfile.readlines()

    depends = []
    odepends = []

    for i in deplines:
        i = i.strip()

        if i.endswith("?"):
            odepends.append(i.rstrip("?"))
        else:
            depends.append(i)
    
    if depends != "":
        conffile.write("depends = " + ", ".join(depends) + "\n")
    if odepends != "":
        conffile.write("optional_depends = " + ", ".join(odepends) + "\n")
    print("[mt_convert]: depends.txt converted")

conffile.close()
