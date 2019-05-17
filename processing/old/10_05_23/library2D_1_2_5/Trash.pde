

/*




void keyPressed(){
  
  // POLYGON
  
  if(key == 'p'){
    background(0);
    
    Poly2 p = new Poly2(int(random(3,10)));
    
    p.setRandomScreenNatural();
    
    strokeWeight((width+height)*0.5*0.005);
    if(p.selfIntersecting()) stroke(255,0,0);
    else stroke(255);
    fill(255,255*0.5);
    p.renderFill();
    if(p.containPoint(p.averagePosition())) stroke(0,0,255);
    else stroke(0,255,0);
    strokeWeight((width+height)*0.5*0.01);
    p.averagePosition().render();
    
    //println(p.p.length);
  }
  
  // CIRCLE

  if(key == 'c'){
    background(255);

    Circle2 circle1 = new Circle2(randomPoint2Screen(), random(width*0.05,width*0.2));
    Circle2 circle2 = new Circle2(randomPoint2Screen(), random(width*0.05,width*0.2));

    if(circle1.intersectingCircle(circle2)) fill(255,0,0);
    else fill(0);
    noStroke();

    circle1.render();
    circle2.render();
  }

  // LINE

  if(key == 'l'){
    background(255);

    Line2 line1 = new Line2(randomPoint2Screen(), randomPoint2Screen());
    Line2 line2 = new Line2(randomPoint2Screen(), randomPoint2Screen());
    Point2 inter = line1.intersectionLine(line2);

    while(!inter.insideScreen()){
      line1.set(randomPoint2Screen(), randomPoint2Screen());
      line2.set(randomPoint2Screen(), randomPoint2Screen());
      inter = line1.intersectionLine(line2);
    }

    strokeWeight((width+height)*0.5*0.01*0.5);
    stroke(0,100);
    line1.renderGraph();
    line2.renderGraph();

    strokeWeight((width+height)*0.5*0.01);
    stroke(0);
    line1.render();
    line2.render();

    strokeWeight((width+height)*0.5*0.02);
    if(line1.intersectingLine(line2)) stroke(255,0,0);
    else stroke(negative(color(255,0,0)));
    inter.render();
  }

  // JUST FOR FUN

  if(key == 'a'){
    scale(0.05);
    int num = 1000;

    background(0);
    for(int i=0; i<num; i++){
      Line2 line1 = new Line2(randomPoint2Screen(), randomPoint2Screen());
      Line2 line2 = new Line2(randomPoint2Screen(), randomPoint2Screen());

      strokeWeight((width+height)*0.5*0.002);
      stroke(255);
      point(line1.intersectionLine(line2).x, line1.intersectionLine(line2).y);
    }
  }
}



*/
