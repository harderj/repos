int num = 10;
float[] length = new float[num];
float[] angle = new float[num];

fill(0);
stroke(255);
pushMatrix();
beginShape();

for(int i=0; i<num; i++){
  length[i] = random(20);
  angle[i] = random(TWO_PI);
  
  vertex(0,0);
  translate(cos(angle[i]*length[i]),sin(angle[i]*length[i]));
  rotate(angle[i]);
}

endShape();
popMatrix();

pushMatrix();
beginShape();

for(int i=0; i<num; i++){  
  vertex(0,0);
  translate(20,20);
  rotate(-PI/3);
}

endShape();
popMatrix();

//pushMatrix();
beginShape();

vertex(20,20);
//translate(20,20);
vertex(0,20);
//translate(0,20);
vertex(50,0);
//translate(50,0);

endShape(CLOSE);
//popMatrix();
