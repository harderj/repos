import point2line.*;

void setup(){
  size(500,500);
  smooth();
}

void draw(){

}

void keyPressed(){
  
  if(key == 'p'){
    background(0);
    
    Poly2 p = new Poly2(int(random(3,15)));
    
    p.setRandomScreenNatural();
    
    strokeWeight((width+height)*0.5*0.005);
    if(p.selfIntersecting()) stroke(255,0,0);
    else stroke(255);
    fill(255,255*0.5);
    p.renderFill();
    if(p.containPoint(p.averagePosition())) stroke(0,0,255);
    else stroke(0,255,0);
    strokeWeight((width+height)*0.5*0.01);
    renderVect2(p.averagePosition());
    
    //println(p.p.length);
  }
  
  // CIRCLE INTERSECTION

  if(key == 'c'){
    background(255);

    Circle2 circle1 = new Circle2(randomVect2Screen(), random(width*0.05,width*0.2));
    Circle2 circle2 = new Circle2(randomVect2Screen(), random(width*0.05,width*0.2));

    if(circle1.intersectingCircle(circle2)) fill(255,0,0);
    else fill(0);
    noStroke();

    circle1.render();
    circle2.render();
  }

  // LINE INTERSECTION

  if(key == 'l'){
    background(255);

    Line2 line1 = new Line2(randomVect2Screen(), randomVect2Screen());
    Line2 line2 = new Line2(randomVect2Screen(), randomVect2Screen());
    Vect2 inter = line1.intersectionLine(line2);

    while(!insideScreen(inter)){
      line1.set(randomVect2Screen(), randomVect2Screen());
      line2.set(randomVect2Screen(), randomVect2Screen());
      inter = line1.intersectionLine(line2);
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
    if(line1.intersectingLine(line2)) stroke(255,0,0);
    else stroke(negative(color(255,0,0)));
    renderVect2(inter);
  }

  // JUST FOR FUN

  if(key == 'a'){
    scale(0.05);
    int num = 1000;

    background(0);
    for(int i=0; i<num; i++){
      Line2 line1 = new Line2(randomVect2Screen(), randomVect2Screen());
      Line2 line2 = new Line2(randomVect2Screen(), randomVect2Screen());

      strokeWeight((width+height)*0.5*0.002);
      stroke(255);
      point(line1.intersectionLine(line2).x, line1.intersectionLine(line2).y);
    }
  }

}


