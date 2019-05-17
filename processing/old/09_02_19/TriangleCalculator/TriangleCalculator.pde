float NULL = 12.34;
float[] a = {
  NULL, NULL, NULL};
float[] l = {
  NULL, NULL, NULL};

int calculationStopper = 0;

void setup(){
  l[0]=16;
  l[1]=15;
  l[2]=15;

  while((l[0] == NULL || l[1] == NULL || l[2] == NULL || a[0] == NULL || a[1] == NULL || a[2] == NULL) && calculationStopper < 30){
    calculationStopper ++;
    for(int i=0; i<3; i++){
      //angle-checks
      if(a[i] == NULL){
        int o1 = int(inbound(i+1,-1,2));
        int o2 = int(inbound(i+2,-1,2));
        
        //2 lengths one angle (1)
        if(a[o1] != NULL && l[o1] != NULL && l[i] != NULL){
          float tmpSin = (sin(a[o1])*l[i])/l[o1];
          a[i] = atan2(tmpSin, sqrt(1-(tmpSin*tmpSin)));
          println("HEY");
        }
        
        //2 lengths one angle (2)
        if(a[o2] != NULL && l[o2] != NULL && l[i] != NULL){
          float tmpSin = (sin(a[o2])*l[i])/l[o2];
          a[i] = atan2(tmpSin, sqrt(1-(tmpSin*tmpSin)));
          println("HO");
        }
        
        //last angle
        if(a[o1] != NULL && a[o2] != NULL){
          a[i] = PI-(a[o1]+a[o2]);
        }
        
        //3 lengths calculation
        if(l[0] != NULL && l[1] != NULL && l[2] != NULL){
          float tmpCos = (((l[o1]*l[o1])+(l[o2]*l[o2]))-(l[i]*l[i]))/(2*l[o1]*l[o2]);
          a[i] = atan2(sqrt(1-(tmpCos*tmpCos)), tmpCos);
        }
      }
      //length-checks
      if(l[i] == NULL){

      }
    }
  }
  
  a[0] = absoluteAngle(a[0]);
  a[1] = absoluteAngle(a[1]);
  a[2] = absoluteAngle(a[2]);
  
  println("Length 0 = " + l[0]);
  println("Length 1 = " + l[1]);
  println("Length 2 = " + l[2]);

  println("Angle 0 (radians) = " + a[0]);
  println("Angle 1 (radians) = " + a[1]);
  println("Angle 2 (radians) = " + a[2]);

  println("Angle 0 (degrees) = " + degrees(a[0]));
  println("Angle 1 (degrees) = " + degrees(a[1]));
  println("Angle 2 (degrees) = " + degrees(a[2]));
  
  println("Degree sum = " + (degrees(a[0])+degrees(a[1])+degrees(a[2])));
}

void draw(){
  background(125);
  if((l[0] == NULL || l[1] == NULL || l[2] == NULL || a[0] == NULL || a[1] == NULL || a[2] == NULL) && calculationStopper < 30){
    fill(255);
    stroke(0);
    
    pushMatrix();
    beginShape();
    
    for(int i=0; i<3; i++){
      vertex(0,0);
      rotate(a[i]);
      translate(0, l[i]);
    }
    
    endShape();
    popMatrix();
  }
}

float inbound(float value, float minimum, float maximum){

  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}

float absoluteAngle(float a){
  a = inbound(a + TWO_PI,0, TWO_PI);

  return a;
}

/*
 float tmpSin = ((l[o1]*l[o1])-(l[o2]*l[o2]))/(l[o1]*l[o2]);
 a[i] = atan2(tmpSin, tmpCos);
 println(int(inbound(2,-1,2)));
 println(int(inbound(3,-1,2)));
 println(int(inbound(4,-1,2)));
 println(int(inbound(5,-1,2)));
 println(int(inbound(6,-1,2)));
 */

