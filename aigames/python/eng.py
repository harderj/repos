import shlex, subprocess

#subprocess.call(["ls", "-l"])

def fct1 () : # just for test
    subprocess.call(["pwd"])

p = subprocess.Popen("./hello", stdout=PIPE)

s = p.communicate()

print s


