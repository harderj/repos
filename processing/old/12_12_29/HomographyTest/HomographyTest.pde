
float scr = 500;
size((int)scr,(int)scr);

int n = 10;
float sz = scr*0.8;

float off = (scr-sz)*0.5;
float space = sz/n;

for(int i=0; i<n+1; i++){
  float x1 = off;
  float y1 = off + i*space;
  float x2 = scr-off;
  float y2 = off + i*space;
  line(x1, y1, x2, y2);
}

// 
for(int i=0; i<n+1; i++){
  float x1 = off + i*space;
  float y1 = off;
  float x2 = off + i*space;
  float y2 = scr-off;
  line(x1, y1, x2, y2);
}
