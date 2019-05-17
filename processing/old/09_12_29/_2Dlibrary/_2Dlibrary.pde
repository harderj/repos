import point2line.*;

void setup(){
  size(500,500);
  smooth();
}

void draw(){

}

void mousePressed(){
}

void keyPressed(){

  if(key == 'l'){

    background(255);

    Line2 line1 = new Line2(randomScreen(), randomScreen());
    Line2 line2 = new Line2(randomScreen(), randomScreen());
    Vect2 inter = line1.intersection(line2);

    while(!insideScreen(inter)){
      line1.set(randomScreen(), randomScreen());
      line2.set(randomScreen(), randomScreen());
      inter = line1.intersection(line2);
    }

    strokeWeight((width+height)*0.5*0.01*0.5);
    stroke(0,100);
    renderLineGraph(line1.tilt(), line1.offset());
    renderLineGraph(line2.tilt(), line2.offset());

    strokeWeight((width+height)*0.5*0.01);
    stroke(0);
    line1.render();
    line2.render();

    strokeWeight((width+height)*0.5*0.02);
    if(line1.intersecting(line2)) stroke(255,0,0);
    else stroke(negative(color(255,0,0)));
    renderVect2(inter);
  }

  if(key == 'a'){
    scale(0.05);
    int num = 1000;

    background(0);
    for(int i=0; i<num; i++){
      Line2 line1 = new Line2(randomScreen(), randomScreen());
      Line2 line2 = new Line2(randomScreen(), randomScreen());

      strokeWeight((width+height)*0.5*0.002);
      stroke(255);
      point(line1.intersection(line2).x, line1.intersection(line2).y);
    }
  }

}

