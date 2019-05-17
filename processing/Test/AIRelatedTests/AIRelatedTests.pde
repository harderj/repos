void setup(){

  int[][] a = new int[2][3];

  a[0][0] = 3;

  println(a[0]);

  int numP = 20;
  int t = (int)millis();
  float tmp = 1;
  int n = 0;
  while((int)millis()-t < 10){
    /*
    float[] lis = new float[numP];
    for(int i=0; i<numP; i++) lis[i] = random(-10, 10);
    int[] hey = orderDescend(lis);
    */
    
    for(int i = 0; i<23*23; i++) tmp = sqrt(random(1));
    
    n++;
    
  }
  println(n);

  int num = 181;
  println(num + ", " + num/10 + "*10 + " + num%10);
  
  float[] heyhey = new float[2];
  println(heyhey);
}

void draw(){
  // nothn'
}

int[] orderDescend(float[] l){
  int lth = l.length; // lth = length of list
  int[] tmp = new int[lth];
  for(int i=0; i<lth; i++) tmp[i] = 0;

  for(int i=0; i<lth; i++){
    int n = 0;
    while(n<i){
      //println("i: " + i + " | n: " + n + " | l[i]: " + l[i] + " | tmp[n]: " + tmp[n] + " | l[tmp[n]]: " + l[tmp[n]]);
      //println(tmp);
      if(l[i]<l[tmp[n]]) n++;
      else break;
    }
    tmp = pushIntoArray(i, tmp, n);
  }

  return tmp;
}

float[] changeOrder(float[] l, int[] o){
  int lth = l.length;
  if(lth != o.length) return null;
  float[] tmp = new float[lth];
  for(int i=0; i<lth; i++){
    tmp[i] = l[o[i]];
  }
  return tmp;
}

int[] pushIntoArray(int a, int[] l, int s){ // a = number l = list | s = startpoint of push
  int lth = l.length; // lth = length of list
  if(lth<s) return null;
  int[] tmp = new int[lth];
  for(int i=lth-1; i>=0; i--){ // important that the 'if(i==s)' statement is last, as 'a' would be copied
    if(i>s) tmp[i] = l[i-1];
    if(i==s) tmp[i] = a;
    if(i<s) tmp[i] = l[i];
  }
  return tmp;
}

