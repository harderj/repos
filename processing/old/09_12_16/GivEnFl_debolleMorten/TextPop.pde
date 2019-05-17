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
  boolean is;

  String t;
  float tSizeX;
  float tSizeY;
  int tLength;

  String popMode;
  color col;
  float xStart,yStart,volStart;
  float vol;
  float transparency;
  float lifeStart;
  float life;
  float vel = 0;

  Vect2 pos;
  String owner = " ";

  TextPop(String theText, Vect2 pos, float volume, int lifeTime, color colour, String popMode){
    is = true;

    t = theText;
    this.pos = new Vect2(pos);
    xStart = pos.x;
    yStart = pos.y;
    volStart = volume;
    lifeStart = float(lifeTime);
    col = colour;
    this.popMode = popMode;

    transparency = 255;
    tLength = theText.length();

    vol = volStart;
    life = lifeStart;
  }

  TextPop(String theText, Vect2 pos, float volume, int lifeTime, color colour, String popMode, String owner){
    is = true;

    t = theText;
    this.pos = new Vect2(pos);
    xStart = pos.x;
    yStart = pos.y;
    volStart = volume;
    lifeStart = float(lifeTime);
    col = colour;
    this.popMode = popMode;

    transparency = 255;
    tLength = theText.length();

    vol = volStart;
    life = lifeStart;

    this.owner = owner;
  }

  void draw(){
    life --;
    if(life > 0){
      update();
      render();
    }
    else{
      is = false;
    }

    if(!owner.equals(" ")) stack();
    
    vel += 0.5;
    pos.y += vel;
  }
  
  void stack(){
  /* BUGGED
    float hitDistance = stackDistance;
    for(int i=0; i<textPops.size(); i++){
      if(((TextPop) textPops.get(i)).owner.equals(owner)){
        Vect2 tmpPos = new Vect2(((TextPop) textPops.get(i)).pos);
        Vect2 tmpDelta = new Vect2(pos);
        tmpDelta.sub(tmpPos);
        if(tmpDelta.magnitude2() != 0 && ((TextPop) textPops.get(i)).is){
          if(tmpDelta.x*tmpDelta.x + tmpDelta.y*tmpDelta.y < hitDistance*hitDistance){
            int tmpA = int(t);
            int tmpB = int(((TextPop) textPops.get(i)).t);
            tmpA += tmpB;
            println(tmpA);
            textPops.add(new TextPop(str(tmpA), new Vect2(lerp(pos.x, tmpPos.x, 0.5), lerp(pos.y, tmpPos.y, 0.5)), int(lerp(volStart,((TextPop) textPops.get(i)).volStart, 0.5)), int(lerp(lifeStart, ((TextPop) textPops.get(i)).lifeStart, 0.5)), 255, "001100", owner));
            ((TextPop) textPops.get(i)).is = false;
            is = false;
          }
        }
      }
    }
  */
  }

  void update(){
    float a = 0.1; // bace change value
    //shakePosition
    if(popMode.charAt(0) == '1'){
      pos.x += volStart*(random(-a,a)*0.2);
      pos.y += volStart*(random(-a,a)*0.2);
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
    textFont(font, vol); // font must be added
    text(t, pos.x+tSizeX, pos.y+tSizeY);
  }
}



