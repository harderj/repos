class Button{
  boolean active;

  char order;
  boolean flag;
  boolean pressed;
  String mode;

  Button(char order){
    active = true;

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
