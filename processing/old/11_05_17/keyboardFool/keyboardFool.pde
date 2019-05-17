

String KS = "nhuio"; //keys

int KN = KS.length(); //number of keys

int k, t, n = 0;

void setup(){
  
}
void draw(){
  
}

void keyPressed(){
  n++;
  int dt = millis()-t;//delta time
  int i=0;
  while(i < KN && key!=KS.charAt(i)) i ++;
  i = i%KN;
  
  
  /*
  if(i<KN){
    if(dt<10 && i!=k){
      k=KN*(k+1)*(i+1);
    }
    else {
      //println(k);
      t=millis();
      k=i;
    }
  }
  */
}

void keyReleased(){
  n--;
  println(n);
}
