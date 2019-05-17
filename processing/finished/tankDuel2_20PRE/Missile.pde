class Missile{

  String name;
  float x,y,dir,spe,dmg;
  int dieTimer,eventTimer,eventTimerReset;
  int owner = 0;
  boolean act = true;


  Missile(String name, float x, float y, float dir, float spe, int owner){
    if(name == "astroid Piece"){
      this.name = name;
      this.spe = Variate(spe)*2; //frames/sec
      dieTimer = int(random(8,15)); //frames
      eventTimerReset = dieTimer + 1;
      dmg = 5;
    }
    if(name == "frozen orb Piece1"){
      this.name = name;
      this.spe = spe; //frames/sec
      dieTimer = int(random(10,30)); //frames
      eventTimerReset = dieTimer + 1;
      dmg = 23;
    }
    if(name == "frozen orb Piece2"){
      this.name = name;
      this.spe = spe; //frames/sec
      dieTimer = int(random(35,50)); //frames
      eventTimerReset = dieTimer + 1;
      dmg = 35;
    }
    if(name == "chance bomb Piece"){
      this.name = name;
      this.spe = spe; //frames/sec
      dieTimer = int(random(60,100)); //frames
      eventTimerReset = dieTimer + 1;
      dmg = 55; 
    }
    if(name == "tree bomb Piece"){
      this.name = name;
      this.spe = spe; //frames/sec
      dieTimer = int(random(10,40)); //frames
      eventTimerReset = dieTimer + 1;
      dmg = 25;
    }
    if(name == "tree bomb Piece Piece"){
      this.name = name;
      this.spe = spe*1.2; //frames/sec
      dieTimer = int(random(10,30)); //frames
      eventTimerReset = dieTimer + 1;
      dmg = 19;
    }
    if(name == "hotshooting missile Piece"){
      this.name = name;
      this.spe = spe*0.5; //frames/sec
      dieTimer = int(random(20,30)); //frames
      eventTimerReset = 2;
      dmg = 5;
    }
    if(name == "sixcored special Piece"){
      this.name = name;
      this.spe = spe;
      dieTimer = int(random(50,70)); //frames
      eventTimerReset = dieTimer/8+1;
    }
    if(name == "nova Piece"){
      this.name = name;
      this.spe = spe*0.5; //frames/sec
      dieTimer = int(random(10,25)); //frames
      eventTimerReset = 3;
      dmg = 17;
    }
    if(name == "breath Piece"){
      this.name = name;
      this.spe = spe*1.5; //frames/sec
      dieTimer = int(random(10,15)); //frames
      eventTimerReset = dieTimer+1;
      dmg = 16;
    }
    if(name == "frozen orb"){
      this.name = name;
      this.spe = spe*1.5; //frames/sec
      this.dieTimer = int(random(60,80)); //frames
      eventTimerReset = 2;
      dmg = 90;
    }
    if(name == "chance bomb"){
      this.name = name;
      this.spe = spe; //frames/sec
      dieTimer = int(random(1,3000)); //frames
      dmg = 30;
    }
    if(name == "tree bomb"){
      this.name = name;
      this.spe = spe*1.1; //frames/sec
      dieTimer = int(random(2,20)); //frames
      eventTimerReset = dieTimer + 1;
      dmg = 35;
    }
    if(name == "shot"){
      this.name = name;
      this.spe = spe*0.7; //frames/sec
      dieTimer = 300; //frames
      eventTimerReset = 3;
      dmg = Critmize(Critmize(random(1,100)));
    }
    if(name == "sixcored bomb"){
      this.name = name;
      this.spe = spe; //frames/sec
      dieTimer = 50; //frames
      eventTimerReset = dieTimer + 1;
      dmg = 100;
    }
    if(name == "hotshooting missile"){
      this.name = name;
      this.spe = spe; //frames/sec
      dieTimer = int(random(70,80)); //frames
      eventTimerReset = 0;
      dmg = 28;
    }
    if(name == "mine"){
      this.name = name;
      this.spe = spe*0; //frames/sec
      dieTimer = int(random(150,200)); //frames
      eventTimerReset = dieTimer+1;
      dmg = 100;
    }
    if(name == "nova"){
      this.name = name;
      this.spe = spe*5; //frames/sec
      dieTimer = 0; //frames
      eventTimerReset = dieTimer+1;
      dmg = 80;
    }
    if(name == "breath"){
      this.name = name;
      this.spe = spe; //frames/sec
      dieTimer = 10; //frames
      eventTimerReset = 1;
      dmg = 20;
    }
    this.x = x;//xPixel
    this.y = y; //yPixel
    this.dir = dir; //radians
    this.owner = owner;

    eventTimer = eventTimerReset;
  }

  void draw(){
    updateTimers();
    move();
    event();
    render();
  }

  void updateTimers(){
    if(dieTimer > 0) dieTimer--;
  }

  void move(){
    x += cos(dir)*spe;
    y += sin(dir)*spe;
  }

  void event(){
    checkHitWall();
    if(eventTimer<=0){
      frameEvent();
      eventTimer = eventTimerReset;
    } 
    else {
      eventTimer --;
    }
    if(dieTimer <= 0){
      explode();
      act = false;
    }
  }

  void checkHitWall(){
    if(x<0 || y<0 || x>width || y>height){
      act = false;
    }
  }

  void frameEvent(){
    if(name == "frozen orb"){
      for(int i=0; i<3; i++){
        missiles.add(new Missile("frozen orb Piece1",x,y,random(PI*2),spe*0.8,owner));
      }
    }
    if(name == "shot"){
      spe = spe*1.1;
    }
    if(name == "sixcored special Piece"){
      missiles.add(new Missile("nova",x,y,0,spe,owner));
    }
    if(name == "hotshooting missile"){
      float tmp = 0;
      if(owner == 0){
        float tmpY = ((Player) players.get(1)).y+(((Player) players.get(1)).speY*(dist(x,y,((Player) players.get(1)).x,((Player) players.get(1)).y)/6.7));
        float tmpX = ((Player) players.get(1)).x+(((Player) players.get(1)).speX*(dist(x,y,((Player) players.get(1)).x,((Player) players.get(1)).y)/6.7));
        //fill(255);
        //ellipse(tmpX,tmpY,10,10);
        tmp = atan2(tmpY-y,tmpX-x);
      }
      if(owner == 1){
        float tmpY = ((Player) players.get(0)).y+(((Player) players.get(0)).speY*(dist(x,y,((Player) players.get(0)).x,((Player) players.get(0)).y)/6.7));
        float tmpX = ((Player) players.get(0)).x+(((Player) players.get(0)).speX*(dist(x,y,((Player) players.get(0)).x,((Player) players.get(0)).y)/6.7));
        //fill(255);
        //ellipse(tmpX,tmpY,10,10);
        tmp = atan2(tmpY-y,tmpX-x);
      }
      missiles.add(new Missile("hotshooting missile Piece",x,y,random(PI/50)-PI/100+tmp,spe*2,owner));
    }
    if(name == "hotshooting missile Piece"){
      spe = spe*1.1;
    }
    if(name == "nova Piece"){
      spe = spe*0.75;
    }
    if(name == "breath"){
      for(int i=0; i<6; i++){
        missiles.add(new Missile("breath Piece",x,y,PI/10-(Variate(PI/20))*i+dir,spe,owner));
      }
    }
  }

  void render(){
    //body
    float tmp = 2;
    if(name == "frozen orb") tmp = 6;
    if(name == "chance bomb") tmp = 4;
    if(name == "tree bomb") tmp = 5;
    if(name == "tree bomb Piece") tmp = 3;
    if(name == "shot") tmp = 3;
    if(name == "sixcored bomb") tmp = 8;
    if(name == "hotshooting missile") tmp = 4;
    if(name == "mine") tmp = 7;
    if(name == "breath") tmp = 2;
    noStroke();
    if(owner == 0) fill(255,0,0);
    if(owner == 1) fill(0,255,0);
    if(owner == 2) fill(255);
    Triangle(x,y,dir,tmp);
  }

  void explode(){
    if(name == "frozen orb"){
      float tmp = random(PI);
      for(int i=0; i<10; i++){
        missiles.add(new Missile("frozen orb Piece2",x,y,((PI)/5)*i + tmp,spe,owner));
      }
    }
    if(name == "sixcored bomb"){
      if(random(1000) > 50){
        float tmpA = random(PI);
        String tmpB = " ";
        int tmpC = int(random(3));
        if(tmpC == 0) tmpB = "tree bomb";
        if(tmpC == 1) tmpB = "frozen orb";
        if(tmpC == 2) tmpB = "sixcored special Piece";
        for(int i=0; i<6; i++){
          if(tmpC == 2) missiles.add(new Missile(tmpB,x,y,((PI)/3)*i + tmpA,spe*0.5,owner));
          else missiles.add(new Missile(tmpB,x,y,((PI)/3)*i + tmpA,spe,owner));
        }
      } 
      else {
        for(int i=0; i<30; i++){
          missiles.add(new Missile("hotshooting missile",x,y,((PI)/15)*i,spe,owner));
        }
      }
    }
    if(name == "tree bomb"){
      for(int i=0; i<10; i++){
        missiles.add(new Missile("tree bomb Piece",x,y,dir+i*(PI/40)-(PI/10)+random(-PI/40,PI/40),spe*0.8,owner));
      }
    }
    if(name == "tree bomb Piece"){
      for(int i=0; i<6; i++){
        missiles.add(new Missile("tree bomb Piece Piece",x,y,((PI)/10)*i+(PI/10*17.5)+dir,spe*0.8,owner));
      }
    }
    if(name == "nova"){
      for(int i=0; i<50; i++){
        missiles.add(new Missile("nova Piece",x,y,((PI)/25)*i+(PI/10*17.5)+dir,spe*0.8,owner));
      }
    }
    if(name == "chance bomb"){
      float tmp = random(PI);
      for(int i=0; i<150; i++){
        missiles.add(new Missile("chance bomb Piece",x,y,((PI)/75)*i + tmp,spe*2,owner));
      }
    }
    if(name == "mine"){
      float tmpA = random(PI);
      for(int i=0; i<2; i++){
        missiles.add(new Missile("sixcored special Piece",x,y,((PI))*i + tmpA,1,owner));
      }
    }
  }
}
