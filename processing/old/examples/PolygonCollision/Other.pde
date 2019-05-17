
Point[] polygon; 
Circle circle; // x,y,r 
 
void setup () 
{ 
    size( 200, 200, P3D ); // just for the per vertex coloring 
    generateNewLines(); 
    circle = new Circle(0,0,0); 
    frameRate( 24 ); 
} 
 
void draw () 
{ 
    background(Colors.white); 
 
    if (mousePressed ) { 
        circle = new Circle(mouseX,mouseY,5); 
    } 
 
    fill( Colors.grey ); 
    stroke( Colors.black ); 
 
    beginShape(POLYGON); 
    int i = 0; 
    boolean inside = insidePolygon(circle.x, circle.y, polygon); 
    while (true) 
    { 
        boolean intersect = inside || lineIntersectsCircle( polygon[i], polygon[(i+1)%polygon.length], circle); 
        stroke( intersect ? Colors.blue : Colors.black ); 
        fill( intersect ? Colors.blue : Colors.grey ); 
        vertex( polygon[i].x, polygon[i].y ); 
        i ++; 
        if ( i % polygon.length == 0 ) break; 
    } 
    endShape(CLOSE); 
 
    circle.drawCircle(); 
} 
 
void keyReleased () 
{ 
    generateNewLines(); 
} 
 
void generateNewLines() 
{ 
    //int count = ((int)random(3,10)); 
    int count = 4;
    polygon = new Point[count]; 
    for( int i = 0; i<polygon.length; i++ ) 
    { 
        polygon[i] = new Point(random(width),random(height)); 
    }      
} 
 
boolean lineIntersectsCircle ( Point p1, Point p2, Circle c ) 
{ 
    float ldx = p2.x-p1.x; 
    float ldy = p2.y-p1.y; 
    float lk = ldy / ldx; 
    float ld = p1.y - p1.x * lk; 
    /* 
   // draw parallel line 
     float cd = c.y - c.x * lk; // parallel line thru circle center 
     stroke( Colors.blue ); 
     float cyy = (c.x+ldx) * lk + cd; 
     line (c.x,c.y,c.x+ldx,cyy); 
     */ 
    float cd2 = c.y - c.x * (-1.0/lk); // parallel line thru circle center 
 
    /* 
   // draw perpendicular line 
     stroke( Colors.green ); 
     float cyyy =  (c.x+ldx) * (-1.0/lk) + cd2; 
     line (c.x,c.y,c.x+ldx,cyyy); 
     */ 
 
    // how this is solved: 
    // left side: c.y = c.x * (-1.0/lk) + cd2 
    // right side: p1.y = p1.x * lk + ld 
    // where c.y = p1.y = y and c.x = p1.x = x 
    // x * (-1.0/lk) + cd2 = x * lk + ld 
    // x * ((-1.0/lk)-lk) = ld - cd2 
    // x = (ld - cd2) / ((-1.0/lk)-lk) 
 
    float xx = (ld - cd2) / ((-1.0/lk)-lk); 
    float yy = xx * lk + ld; 
 
    /* 
   // draw connection 
     stroke( Colors.red ); 
     line( xx,yy,c.x,c.y ); 
     */ 
 
    if ( !(xx >= min( p1.x, p2.x ) & xx <= max( p1.x, p2.x ) & yy >= min( p1.y, p2.y ) & yy <= max( p1.y, p2.y )) ) return false; 
 
    float rr = sqrt((c.x-xx)*(c.x-xx)+(c.y-yy)*(c.y-yy)); 
 
    return c.rad >= rr; 
} 
 
boolean insidePolygon ( float x, float y, Point [] p) 
{ 
    // aaron steed 
    // http://processing.org/discourse/yabb_beta/YaBB.cgi?board=Programs;action=display;num=1189178826;start=4#4 
    int i, j, c = 0;  
    for (i = 0, j = p.length-1; i < p.length; j = i++) {  
        if ((((p[i].y <= y) && (y < p[j].y)) ||  
            ((p[j].y <= y) && (y < p[i].y))) &&  
            (x < (p[j].x - p[i].x) * (y - p[i].y) / (p[j].y - p[i].y) + p[i].x))  
            c = (c+1)%2;  
    }  
    return c==1;  
} 
 
class Circle 
{ 
    float x,y,rad, dia; 
     
    Circle ( float _x, float _y, float _rad ) 
    { 
        x = _x; 
        y = _y; 
        rad = _rad; 
        dia = 2.0 * _rad; 
    } 
 
    void drawCircle () 
    { 
        fill( Colors.white ); 
        stroke( Colors.red ); 
        ellipse( x, y, dia, dia ); 
    } 
} 
 
static class Point {  
    float x,y;  
    Point(float x, float y){  
        this.x = x;  
        this.y = y;  
    }  
} 
 
class Colors 
{ 
    final static int red   = 0xFFFF0000; 
    final static int green = 0xFF00FF00;  
    final static int blue  = 0xFF0000FF;    
    final static int black = 0xFF000000;     
    final static int grey  = 0xFFAAAAAA;      
    final static int white = 0xFFFFFFFF;  
} 
