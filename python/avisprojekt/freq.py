

import nltk
import csv
#from nltk.book import text1


def csv2text(file):
    csvfile = open('csvfile.csv', 'r')
    content = csv.reader(file) #, delimiter=",")
    


def clean(name, newName):
    strlist = read_csv(name)
    write_csv(filter(strlist), newName)

def read_csv(name):
    csvfile = open('csvfile.csv', 'r')
    csvcontent=[]
    content = csv.reader(csvfile,delimiter=',')
    for row in content:
        csvcontent.append(row)
    csvfile.close()
    return parser_list(csvcontent)

def parser(strlist):
    tempstr = ''
    for i in range(len(strlist)):
        tempstr = tempstr + strlist[i][0]+'\r\n'
    return tempstr

def parser_list(list):
    templist = []
    for i in range(len(list)):
        templist.append(list[i][0])
    return templist

def filter(strlist):
    templist = []
    for s in strlist:
        if(condition(s)):
            templist.append(s)
    return templist

def averageSentenceLength(strlist):
    sum = 0.0
    for s in strlist:
        sum += len(s.split())
    return sum/len(strlist)

def condition(str):
    if(count_spaces(str) < 3):
        return False
    return True

def count_spaces(str):
    return (len(str.split()) - 1)

def string_to_Text_parser(string):
    nltk.word_tokenize(string)

def write_csv(strlist, name):
    file = open(name, 'w')
    file.write(''.join(strlist))
    file.close()

def print_strlist(strlist):
    for s in strlist:
        print s
