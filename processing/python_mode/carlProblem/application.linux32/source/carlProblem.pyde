
camx = 200.0
camy = 350.0
camd = (PI/2)*3.0
cams = PI/3.0
circx = 150.0
circy = 100.0
circd = 120.0

def setup():
    size(400,400)
    return
    ## background(255)

def draw():
    background(255)
    global camx, camy, camd
    if mousePressed:
        camx = mouseX
        camy = mouseY
    rendCam(camx, camy, camd, cams)
    noFill(); stroke(0); ellipse(circx,circy,circd,circd)
    method() #green : distance squared, sqrt
    
def method():
    dx = camx - circx
    dy = camy - circy
    ang = atan2(-dy,-dx)
    stroke(0,30); ray(camx, camy, ang)
    r = circd/2
    d2 = dx*dx + dy*dy
    alph = asin(r/sqrt(d2))
    stroke(255,0,0); ray(camx, camy, ang + alph); ray(camx, camy, ang - alph)
    l = r/(sqrt(1 - r*r/d2))
    if mousePressed : println(l)
    stroke(0,255,0);
    line(circx + cos(ang + PI/2)*l,
         circy + sin(ang + PI/2)*l,
         circx + cos(ang - PI/2)*l,
         circy + sin(ang - PI/2)*l)
    
def ray(x,y,a):
    line(x,y,x+cos(a)*10000, y+sin(a)*10000)

def rendCam(x, y, d, s):
    pushMatrix()
    translate(x,y)
    rotate(d)
    noFill(); stroke(0); ellipse(0,0,10,10)
    #stroke(0,30); ray(0,0,s/2); ray(0,0,-s/2)
    popMatrix()