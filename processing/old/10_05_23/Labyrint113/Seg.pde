class Seg{

  final float RESIST_RADIUS = 40;
  final float SEEK_RADIUS = 50;
  final float LINK_RADIUS = 30;

  Vect2 pos;
  Vect2 vel = new Vect2();
  Vect2 acc = new Vect2();
  Seg linked = null;

  //print(vel + ":" + acc + ":" + a + ":" + b + ":" + c);

  Seg(Vect2 pos){
    this.pos = pos.copy();
    //segs.add(this);
  }

  void update(){
    if(repulse_segs) repulseSegs();
    repulseScreen();
    basicCalc();
    if(linked == null) seekLink();
    else keepLinkClose();
    render();
  }
  
  void keepLinkClose(){
    Vect2 tDelta = pos.subtracted(linked.pos);
    float tAngle = atan2(tDelta.y, tDelta.x);
    
    float FACTOR = 0.05;
    
    acc.x -= cos(tAngle)*FACTOR;
    acc.y -= sin(tAngle)*FACTOR;
    linked.acc.x += cos(tAngle)*FACTOR;
    linked.acc.y += sin(tAngle)*FACTOR;
    
    /*
    Vect2 tDelta = pos.subtracted(linked.pos);
    float tAngle = atan2(tDelta.y, tDelta.x);
    linked.pos.x = pos.x+cos(tAngle)*LINK_RADIUS;
    linked.pos.y = pos.y+sin(tAngle)*LINK_RADIUS;
    */
    /*
    Vect2 tDelta = linked.pos.subtracted(pos);
    float tAngle = atan2(tDelta.y, tDelta.x);
    pos.x = linked.pos.x+cos(tAngle)*LINK_RADIUS;
    pos.y = linked.pos.y+sin(tAngle)*LINK_RADIUS;
    */
  }

  void seekLink(){
    println(random(0,1));
    for(int i=0; i<segs.size(); i++){
      Vect2 tPos = ((Seg) segs.get(i)).pos;
      Seg tLinked = ((Seg) segs.get(i)).linked;
      if(insideCircle(pos, tPos, SEEK_RADIUS) && !theSame(pos, tPos) && tLinked == null && linked == null){
        linked = ((Seg) segs.get(i));
      }
    }
  }

  void repulseScreen(){
    if(!insideScreen(pos)){
      if(!insideInterval(pos.x, 0, width)){
        pos.x = constrain(pos.x, 0, width);
        vel.x *= -1;
      }
      else{
        pos.y = constrain(pos.y, 0, height);
        vel.y *= -1;
      }
    }
  }

  void repulseSegs(){
    for(int i=0; i<segs.size(); i++){
      Vect2 tPos = ((Seg) segs.get(i)).pos;
      if(insideCircle(pos, tPos, RESIST_RADIUS) && !theSame(pos, tPos)){
        Vect2 tDelta = pos.subtracted(tPos);
        float tAngle = atan2(tDelta.y, tDelta.x);
        float tDist = sqrt(sq(tDelta.x) + sq(tDelta.y)); //HEAVY!!!
        acc.x += cos(tAngle)*(1/tDist);
        acc.y += sin(tAngle)*(1/tDist);
      }
    }
  }

  void basicCalc(){
    vel.add(acc);
    acc.setZero();
    vel.scale(DRAG);
    pos.add(vel);
  }

  void render(){
    if(linked == null){ 
      stroke(0);
      point(pos.x, pos.y);
    }
    else {
      stroke(0);
      line(pos.x, pos.y, linked.pos.x, linked.pos.y);
    }
  }
}



