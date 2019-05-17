class Dyr{
  boolean is = true;
  V2 pos, vel, acc;
  float sMass, mass, mouth, speed, dir, dirVel, splitMass;
  color pig;
  
  Dyr(V2 pos, float mass, float mouth, float speed, float splitMass, color pigment){
    this.pos = pos;
    this.mass = mass;
    sMass = mass;
    this.mouth = mouth;
    this.speed = speed;
    this.splitMass = splitMass;
    dir = random(TWO_PI);
    dirVel = 0;
    pig = pigment;
    
    acc = new V2();
    vel = new V2();
  }
  
  void upd(){
    move();
    render();
  }
  
  void move(){
    if(random(1000)<speed){
      acc.x += cos(dir)*gSpeed;
      acc.y += sin(dir)*gSpeed;
      
      mass -= gLoss;
    }
    if(/*vel.magnitude() <gRotate &&*/ dirVel<gRotateSpeed*0.1) dirVel += gRotateSpeed;
    dirVel *= gRotateDrag;
    dir += dirVel;
    
    acc.add(gGravity);
    vel.set(acc);
    acc.set(0);
    vel.mult(gDrag);
    pos.add(vel);
  }
  
  void render(){
    noStroke();
    fill(pig);
    ellipse(pos.x, pos.y, mass, mass);
    //mouth
    noFill();
    strokeWeight(2);
    stroke(pig);
    ellipse(pos.x+cos(dir)*mass*0.5*mouth, pos.y+sin(dir)*mass*0.5*mouth, mouth*2, mouth*2);
  }
}
