/* textPop
textPop is used for up-popping text's
Fx. damage-values or small info signs

Variables:
   popMode:
     popMode is a String that works as 6 different boolean values.
     Each boolean value is modified by typing 0 = false, and 1 = true.
     If you type anything else that 0 & 1, nothing will happen.
     Each value made true, will add an extra effect to the text:
       1 char = shakePosistion
       2 char = shakeSize
       3 char = sizeIn
       4 char = sizeOut
       5 char = fadeIn
       6 char = fadeOut
     More effects can be added. Make sure to write them in this description.
*/

class TextPop{
  boolean active;

  String t;
  float tSizeX;
  float tSizeY;
  int tLength;
  
  String popMode;
  color col;
  float xStart,yStart,volStart;
  float x,y,vol;
  float transparency;
  float lifeStart;
  float life;

  TextPop(String theText, float x, float y, float volume, int lifeTime, color colour, String popMode){
    active = true;

    t = theText;
    this.x = x;
    this.y = y;
    xStart = x;
    yStart = y;
    volStart = volume;
    lifeStart = float(lifeTime);
    col = colour;
    this.popMode = popMode;

    transparency = 255;
    tLength = theText.length();

    vol = volStart;
    life = lifeStart;
  }

  void draw(){
    life --;
    if(life > 0){
      update();
      render();
    }
    else{
      active = false;
    }
  }

  void update(){
    float a = 0.1; // bace change value
    //shakePosition
    if(popMode.charAt(0) == '1'){
      x = xStart - volStart*(random(-a,a)*1);
      y = yStart - volStart*(random(-a,a)*1);
    }
    //shakeSize
    if(popMode.charAt(1) == '1'){
      vol = volStart*(random(-a,a)+1);
    }
    //popIn
    if(popMode.charAt(2) == '1'){
      if(life > lifeStart/5*4){
        vol = ((1.2-(life/lifeStart)))*volStart*2.5;
      }
    }
    //popOut
    if(popMode.charAt(3) == '1'){
      if(life < lifeStart/3){
        vol = (life/lifeStart)*volStart*3;
      }
    }
    //fadeIn
    if(popMode.charAt(4) == '1'){
      if(life > lifeStart/5*4){
        transparency = ((1.2-(life/lifeStart)))*255*2.5;
      }
    }
    //fadeOut
    if(popMode.charAt(5) == '1'){
      if(life < lifeStart/3){
        transparency = (life/(lifeStart))*255;
      }
    }
  }
  
  void fitText(){
    tSizeX = tLength*vol*0.25*-1;
    tSizeY = vol*0.25;
  }
  
  void render(){
    fitText();
    fill(col,transparency);
    textFont(fontA, vol); // font must be added
    text(t, x+tSizeX, y+tSizeY);
  }
}
