int c = 5;
int d = 300;
float r = float(d)*0.5;
float rSqrt = sqrt(r);
float startTime;

void setup() {

  size(500, 500);
  background(255);
  ellipseMode(CENTER);
}

void draw() {
  translate(width*0.5,height*0.5);
  stroke(0);
  for(int i=0; i<pow(10,c); i++) {
    float a = random(TWO_PI);
    //float l = r*random(0,1);
    //float l = r-pow(r, random(0,1));
    //float l = r*(1-pow(random(0,1), 2));
    float l = r*sqrt(random(1));

    //if(i < 10) println(l);

    point(cos(a)*l, sin(a)*l);
  }
  fill(255,230);
  noStroke();
  ellipse(0,0,d,d);
}

