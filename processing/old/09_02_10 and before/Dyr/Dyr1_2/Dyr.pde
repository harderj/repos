class Dyr{
  boolean is = true;
  V2 pos, vel, acc;
  float sMass, mass, mouth, sSpeed, speed, dir, dirVel, splitMass;
  color pig;
  
  Dyr(V2 pos, float mass, float mouth, float speed, float splitMass, color pigment){
    this.pos = pos;
    this.mass = mass;
    sMass = mass;
    this.mouth = mouth;
    this.speed = speed;
    sSpeed = speed;
    this.splitMass = splitMass;
    dir = random(TWO_PI);
    dirVel = 0;
    pig = pigment;
    
    acc = new V2();
    vel = new V2();
  }
  
  void upd(){
    move();
    basics();
    render();
  }
  
  void basics(){
    acc.add(gGravity);
    vel.add(acc);
    acc.set(0);
    vel.mult(gDrag);
    pos.add(vel);
    if(pos.x < 0){
      pos.x = 0;
      vel.x = 0;
    }
    if(pos.x > width){
      pos.x = width;
      vel.x = 0;
    }
    if(pos.y < 0){
      pos.y = 0;
      vel.y = 0;
    }
    if(pos.y > height){
      pos.y = height;
      vel.y = 0;
    }
  }
  
  void move(){
    if(abs(vel.magnitude()) < gMove) 
    speed *= 1.01;
    if(random(100+(gSpeed/vel.magnitude())*100)<speed){
      acc.x += cos(dir)*gSpeed;
      acc.y += sin(dir)*gSpeed;
      mass -= gLoss;
      speed = sSpeed;
    }
    if(abs(dirVel) < gRotateSpeed*0.1) if(random(1000)<speed) dirVel += random(-gRotateSpeed,gRotateSpeed);
    dirVel *= gRotateDrag;
    dir += dirVel;
  }
  
  void render(){
    noStroke();
    fill(pig);
    ellipse(pos.x, pos.y, mass, mass);
    //mouth
    noFill();
    strokeWeight(2);
    stroke(pig);
    arc(pos.x+cos(dir)*mass*0.25*mouth, pos.y+sin(dir)*mass*0.25*mouth, mouth*2, mouth*2, dir + HALF_PI, dir - HALF_PI);
  }
}
