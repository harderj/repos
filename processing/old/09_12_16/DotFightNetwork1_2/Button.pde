// button

// call

String getButtonState(char button){
  char tmpFind = button;
  String tmpButtonState = "";

  for(int i=0; i<buttons.size(); i++){
    if(tmpFind == ((Button) buttons.get(i)).order){
      tmpButtonState = ((Button) buttons.get(i)).state;
    }
  }

  return tmpButtonState;
}

boolean getButtonBinary(char button){
  char tmpFind = button;
  boolean tmpButtonBinary = false;

  for(int i=0; i<buttons.size(); i++){
    if(tmpFind == ((Button) buttons.get(i)).order){
      tmpButtonBinary = ((Button) buttons.get(i)).pressed;
    }
  }

  return tmpButtonBinary;
}

// add multiple buttons

void addButtons(String buttonList){
  for(int i=0; i<buttonList.length(); i++){
    buttons.add(new Button(buttonList.charAt(i)));
  }
}

// input

void keyPressed(){
  for(int i=0; i<buttons.size(); i++) if(key == ((Button) buttons.get(i)).order && ((Button) buttons.get(i)).state != "on") ((Button) buttons.get(i)).state = "press";
}

void keyReleased(){
  for(int i=0; i<buttons.size(); i++) if(key == ((Button) buttons.get(i)).order) ((Button) buttons.get(i)).state = "release";
}

// class

class Button{
  boolean is;

  char order;

  boolean flag;
  boolean pressed;
  String state;

  Button(char order){
    is = true;

    this.order = order;

    flag = false;
    pressed = false;
    state = "off";
  }

  void update(){
    //Press
    if(state == "press"){
      if(flag){
        state = "on";
      }
      else{
        flag = true;
        pressed = true;
      }
    }

    //Release
    if(state == "release"){
      if(flag){
        flag = false;
        pressed = false;
      }
      else{
        state = "off";
      }
    }
  }
}

/*

 // button class test
 noFill();
 if(getButtonState('a') == "press") fill(0,255,0);
 if(getButtonState('a') == "on") fill(100);
 if(getButtonState('a') == "release") fill(255,0,0);
 if(getButtonBinary('a')) stroke(255); 
 else{ 
 noStroke();
 }
 ellipse(50,50,50,50);
 
 */


