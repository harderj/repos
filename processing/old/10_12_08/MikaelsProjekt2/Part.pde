class Part{

  PVector p;
  float r, a, av, aa, drag, speed;
  char l;

  Part(PVector _p, float _r, float _a, char _l){
    p = _p;
    a = _a;
    l = _l;

    r = _r;
    drag = 1-DRAG*0.01;
    speed = PI*0.01*SPEED;
  }

  void update(){

    aa = sin(a + HALF_PI) * speed;
    av += aa;
    a += av;
    av *= drag;

  }

  void draw(){
    float x = p.x + r*cos(a);
    float y = p.y + r*sin(a);
    
    if(showLines){
      
      stroke(125);
      strokeWeight(3);
      
      line(p.x, p.y, x, y-100);
      
    }
    
    fill(255);
    text(l, x, y);
  }

  void drawCircles(){
    float x = p.x + r*cos(a);
    float y = p.y + r*sin(a);

    fill(255, 30);
    strokeWeight(2);
    noStroke();
    ellipse(x, y-40, 130, 130);

  }

}

