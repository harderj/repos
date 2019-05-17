size(500,500);
background(0);
smooth();

int num = 50;
stroke(255);
strokeWeight(((width+height)*0.5)*0.01);

for(int i=0; i<num; i++){

  for(int j=0; j<i; j++){
    
    point((i)*(width/num), ((float)j+1)/((float)i+1)*height);
    
  }

}
