int c = 5;
int d = 500;
float r = float(d)*0.5;
float rSqrt = sqrt(r);
size(d, d);
background(255);
stroke(0);
float startTime;


startTime = millis();

for(int i=0; i<pow(10,c); i++){
  float a = random(TWO_PI);
  //float l = r*random(0,1);
  //float l = r-pow(r, random(0,1));
  //float l = r*(1-pow(random(0,1), 2));
  float l = r*sqrt(random(1));

  //if(i < 10) println(l);

  point(cos(a)*l + r, sin(a)*l + r);
}
println( millis()- startTime );


startTime = millis();

for(int i=0; i<pow(10,c); i++){
  float x = random(width);
  float y = random(height);

  while((x-width*0.5)*(x-width*0.5) + (y-height*0.5)*(y-width*0.5) > r*r){
    x = random(width);
    y = random(height);
  }
  
  point(x, y);
}

println( millis()- startTime );
