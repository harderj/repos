
int n=25;
int w,h;
boolean[] deck = new boolean[n*2];

void setup(){
  size(500,500);
  w=width;
  h=height;
  for(int i=0; i < n*2; i++){
    deck[i] = boolean(floor(i/n));
  }
}

void draw(){
  background(255);
  for(int i=0; i < n*2; i++){
    int t = floor(i/n);
    int N = n+2;
    float x = (t+1)*w/3;
    float y = ((float(i)+1)/(float(n)+2))*h - t*(n*h/(n+2));
    if(deck[i]) fill(255,0,0);
    else fill(0);
    noStroke();
    ellipse(x,y,40,10);
  }  
}

void mousePressed(){
  boolean[] tmpdeck = new boolean[n*2];
  for(int i=0; i < n*2; i++){
    int j = floor(i/2)+n*(i%2);
    tmpdeck[i] = deck[j];
  }
  println(tmpdeck);
  deck=tmpdeck;
}
