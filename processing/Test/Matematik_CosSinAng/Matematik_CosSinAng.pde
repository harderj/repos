float x = 0;
float y = 0;

PFont font;

void setup(){
  size(500,200);
  
  font = loadFont("Courier-12.vlw");
}

void draw(){
  background(255);
  
  //grid
  float tmpSize = 40;
  stroke(125);
  strokeWeight(1);
  for(int i=0; i<20; i++){
    line(i*tmpSize, 0, i*tmpSize, height);
  }
  for(int i=0; i<20; i++){
    line(0, i*tmpSize, width, i*tmpSize);
  }
  
  //mouse
  noFill();
  stroke(0);
  strokeWeight(2);
  ellipse(mouseX,mouseY,10,10);
  
  //streg
  float angle = atan2(mouseY-y, mouseX-x);
  noFill();
  strokeWeight(3);
  stroke(0);
  line(x,y,x+(cos(angle)*100),y+(sin(angle)*100));
  
  //0-streg
  stroke(255,0,0,150);
  strokeWeight(1);
  line(x,y,width,y);
  
  //vinkel streg
  stroke(0,255,0,150);
  strokeWeight(2);
  arc(x,y,50,50,0,angle);
  
  //tekst
  fill(0,0,255);
  textFont(font, 12);
  
  //enheder
  text("Relative Mouse X: ",width/30,height/10*1);
  text("Relative Mouse Y: ",width/30,height/10*2);
  text("Processing Radians: ",width/30,height/10*3);
  text("Processing Degrees: ",width/30,height/10*4);
  text("Perfected Radians: ",width/30,height/10*5);
  text("Perfected Degrees: ",width/30,height/10*6);
  text("Cosinus: ",width/30,height/10*7);
  text("Sinus: ",width/30,height/10*8);
  //værdier
  text((mouseX-x),width/10*9,height/10*1);
  text((mouseY-y),width/10*9,height/10*2);
  text(angle,width/10*9,height/10*3);
  text(degrees(angle),width/10*9,height/10*4);
  angle = inbound(angle + TWO_PI,0, TWO_PI);
  text(angle,width/10*9,height/10*5);
  text(degrees(angle),width/10*9,height/10*6);
  text(cos(angle),width/10*9,height/10*7);
  text(sin(angle),width/10*9,height/10*8);
}

void fade(){
  fill(255);
  noStroke();
  rect(-1,-1,width+2,height+2);
}

void keyPressed(){
  if(key == 'p'){
    save("Matematik_CosSinAng_Screen_" + second() + "_" + minute() + "_" + hour() + "_" + day() + "_" + month() + "_" + year() + ".JPEG");
  }
}

void mousePressed(){
  x = mouseX;
  y = mouseY;
}

float inbound(float value, float minimum, float maximum){

  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}
