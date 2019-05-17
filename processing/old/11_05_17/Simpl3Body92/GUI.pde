
void GUI(){
  showPlanets();
  showSlides();
  showInfo();
}

void showPlanets(){
  float offY = height*0.92;
  float offX = width*0.03;
  float offP = height*0.04;
  
  noStroke();
  fill(colS);
  ellipse(offX, offY - offP*0, 10,10);
  fill(colE);
  ellipse(offX, offY - offP*1, 10,10);
  fill(colM);
  ellipse(offX, offY - offP*2, 10,10);
  
  strokeWeight(2);
  stroke(colG);
  noFill();
  if(view == 1) ellipse(offX, offY - offP*0, 15,15);
  if(view == 0) ellipse(offX, offY - offP*1, 15,15);
  if(view == 2) ellipse(offX, offY - offP*2, 15,15);
  
  if(insideRect(mouseX, mouseY, offX, offY-offP*0,10)){
    showPlanetInfo(1);
    if(mousePressed){
      if(mouseButton == LEFT) view = 1;
      else{
        if(view==0) p2.trace =1;
        if(view==2) p3.trace =1;
      }
    }
  }
  if(insideRect(mouseX, mouseY, offX, offY-offP*1,10)){
    showPlanetInfo(2);
    if(mousePressed){
      if(mouseButton == LEFT) view = 0;
      else{
        if(view==0) p2.trace =0;
        if(view==2) p3.trace =2;
      }
    }
  }
  if(insideRect(mouseX, mouseY, offX, offY-offP*2,10)){
    showPlanetInfo(3);
    if(mousePressed){
      if(mouseButton == LEFT) view = 2;
      else{
        if(view==0) p2.trace =0;
        if(view==2) p3.trace =0;
      }
    }
  }
}

void showPlanetInfo(int v){
  float offY = height*0.92;
  float offX = width*0.06;
  float offP = height*0.04;
  
  Part p = new Part();
  if(v==1) p=p1;
  if(v==2) p=p2;
  if(v==3) p=p3;
  
  float vel = dist(0,0,(float)p.vx,(float)p.vy)*GmDay_KmSec;
  float dist0 = dist(0,0,(float)p.x,(float)p.y);
  
  fill(colT);
  stroke(colT);
  if(v==1) text("'Sun'",offX,offY-offP*0);
  if(v==2) text("'Earth' - rightclick on other planets to toggle trace mode",offX,offY-offP*0);
  if(v==3) text("'Moon' - rightclick on other planets to toggle trace mode",offX,offY-offP*0);
  text("Velocity: " + vel + " km/s",offX,offY-offP*1);
  text("Position: " + dist0 + " Gm",offX,offY-offP*2);
  
}

void showSlides(){
  showScaleSlider();
  showTimeSlider();
}

boolean timeSliderGrab = false;

void showTimeSlider(){
  float factor = 0.02; // scale slider factor
  float offS=width*0.1;
  float offX = width*0.02;
  float offY = height*0.05;
  float offXText = width*0.04;
  float ballSize = width*0.02;
  
  float tmpX = -log((float)dt)/factor+offX+offS; //1/(pow((dt*pow(factor,4)),0.25)+offX;
  if(mousePressed){
    if(insideRect(mouseX, mouseY, tmpX, height-offY,ballSize)) timeSliderGrab = true;
  }
  else timeSliderGrab=false;
  if(timeSliderGrab){
    dt = exp(-factor*(mouseX-offX-offS)); // exp((mouseX-offX)*factor);
  }
  
  float tmpW = abs(tmpX-offX);
  fill(colT);
  text("dt: " + (float)dt*24 + " hours", tmpW + offXText, height-offY+5);
  
  noFill();
  stroke(colG);
  strokeWeight(3);
  line(offX, height-offY, tmpX, height-offY);
  stroke(colG);
  ellipse(tmpX,height-offY,ballSize*.5,ballSize*.5);
}

boolean scaleSliderGrab = false; // scale slider 'grabbed'

void showScaleSlider(){
  float factor = 0.05; // scale slider factor
  float offS=width*0.4;
  float offX = width*0.02;
  float offY = height*0.02;
  float offXText = width*0.04;
  float ballSize = width*0.02;
  
  float tmpX = (factor*offX+log(scale))/factor+offS;
  if(mousePressed){
    if(insideRect(mouseX, mouseY, tmpX, height-offY,ballSize)) scaleSliderGrab = true;
  }
  else scaleSliderGrab=false;
  if(scaleSliderGrab){
    scale = exp(factor*(mouseX-offX-offS)); // exp((mouseX-offX)*factor);
  }
  
  float tmpW = abs(tmpX-offX);
  float tmpV = tmpW*1000000/scale;
  fill(colT);
  text(tmpV + " m", tmpW + offXText, height-offY+5);
  
  noFill();
  stroke(colG);
  strokeWeight(3);
  line(offX, height-offY, tmpX, height-offY);
  stroke(colG);
  ellipse(tmpX,height-offY,ballSize*.5,ballSize*.5);
}

void showInfo(){
  fill(colT);
  text("Days: " + (int)time, width*0.02, height*0.04);
  pushMatrix();
  translate(width*0.99, height*0.99);
  rotate(-PI*0.5);
  textFont(font, 12);
  text("Simulation by Jacob Harder dec 2010", 0, 0);
  popMatrix();
  textFont(font, 12);
}

void keyPressed(){
  if(key=='g') showGUI = !showGUI;
  if(key=='p') saveFrame();
}

