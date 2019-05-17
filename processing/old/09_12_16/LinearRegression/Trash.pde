
  
  /*
  
  // second try
  
  stroke(0,255,0);
  linearFunc(0, a.y);
  
  float[] tmpA = new float[n];
  float[] tmpB = new float[n];
  for(int i=0; i<n; i++){
    tmpA[i] = (a.y - p[i].y)/(a.x - p[i].x);
    tmpB[i] = p[i].y - tmpA[i]*p[i].x;
    
    stroke(255,0,0,100);
    linearFunc(tmpA[i], tmpB[i]);
  }
  
  stroke(0,0,255);
  linearFunc(average(tmpA), average(tmpB));
  
  
  // first try
  
  PVector fir = new PVector(-1,10);
  PVector sec = new PVector(3,4);
  PVector thi = new PVector(9,10);
  PVector ave = average(fir, sec, thi);
  
  spot(fir);
  spot(sec);
  spot(thi);
  stroke(255,0,0);
  spot(ave);
  
  float[] a = new float[3];
  a[0] = (ave.y - fir.y)/(ave.x - fir.x);
  a[1] = (ave.y - sec.y)/(ave.x - sec.x);
  a[2] = (ave.y - thi.y)/(ave.x - thi.x);
  
  float[] b = new float[3];
  b[0] = fir.y - a[0]*fir.x;
  b[1] = sec.y - a[1]*sec.x;
  b[2] = thi.y - a[2]*thi.x;
  
  stroke(0,255,0,50);
  for(int i=0; i<3; i++) linearFunc(a[i], b[i]);
  
  stroke(0,0,255,150);
  linearFunc(average(a), average(b));
  
  */
