/*
// another way of aplicating the Button modes

if(keyPressed && key == order){
  if(flag){
    mode = "on";
  }
  else{
    mode = "press";
    flag = true;
  }
} 
else{
  if(flag){
    mode = "release";
    flag = false;
  } 
  else{
    mode = "off";
  }
}

// key tests

void keyTmp1(){
  char tmpFind = 'a';
  String tmpMode = "";
  boolean tmpPressed = false;
  
  for(int i=0; i<buttons.size(); i++) if(tmpFind == ((Button) buttons.get(i)).order){
    tmpMode = ((Button) buttons.get(i)).mode;
    tmpPressed = ((Button) buttons.get(i)).pressed;
  }
  
  if(tmpPressed) stroke(255,255,255);
  if(!tmpPressed) stroke(0,0,0);
  strokeWeight(10);
  ellipse(width/5,height/2,width/10,height/10);
}

void keyTmp2(){
  char tmpFind = 'b';
  String tmp = "";
  for(int i=0; i<buttons.size(); i++) if(tmpFind == ((Button) buttons.get(i)).order) tmp = ((Button) buttons.get(i)).mode;
  if(tmp == "off") fill(0,0,0);
  if(tmp == "on") fill(255,255,255);
  if(tmp == "press") fill(255,0,0);
  if(tmp == "release") fill(0,255,0);
  noStroke();
  ellipse(width/5*4,height/2,width/10,height/10);
}
*/
