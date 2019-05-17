void keyPressed(){
  for(int i=0; i<buttons.size(); i++){
    if(key == ((Button) buttons.get(i)).order){
      ((Button) buttons.get(i)).mode = "press";
    }
  }
}

void keyReleased(){
  for(int i=0; i<buttons.size(); i++){
    if(key == ((Button) buttons.get(i)).order){
      ((Button) buttons.get(i)).mode = "release";
    }
  }
}

class Button{
  boolean act = true;

  char order;

  boolean flag;
  boolean pressed;
  String mode;

  Button(char order){
    act = true;

    this.order = order;

    flag = false;
    pressed = false;
    mode = "off";
  }

  void draw(){
    //Press
    if(mode == "press"){
      if(flag){
        mode = "on";
      }
      else{
        flag = true;
        pressed = true;
      }
    }

    //Release
    if(mode == "release"){
      if(flag){
        flag = false;
        pressed = false;
      }
      else{
        mode = "off";
      }
    }
  }
}
