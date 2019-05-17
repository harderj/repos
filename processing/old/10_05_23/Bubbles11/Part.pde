class Part{
  boolean is;
  boolean search;
  PVector p, v, a;
  Part linkA, linkB;

  Part(PVector pos){
    is = true;
    p = new PVector();
    v = new PVector();
    a = new PVector();
    this.p.x = pos.x;
    this.p.y = pos.y;
  }


  void update(){
    attractMouse();
    detractParts();
    baseVars();
    if(search) findLink();
    move();
    render();
  }

  void detractParts(){
    float minimum = 2;
    float force = 10;
    float distance = 20;
    for(int i=0; i<parts.size(); i++){
      PVector tmpP = ((Part) parts.get(i)).p;

      if(tmpP != p){
        PVector tmpD = new PVector(p.x, p.y);
        tmpD.sub(tmpP);
        
        float dist2 = tmpD.x*tmpD.x+tmpD.y*tmpD.y;
        if(dist2 < distance*distance){
          float tmpA = atan2(tmpD.y, tmpD.x);
          a.x += cos(tmpA)*(force/(dist2+minimum));
          a.y += sin(tmpA)*(force/(dist2+minimum));
        }
      }
    }
  }

  void baseVars(){
    if(linkA == null || linkB == null) search = true;
    else search = false;
  }

  void findLink(){
    for(int i=0; i<parts.size(); i++){
      PVector tmpP = ((Part) parts.get(i)).p;
      boolean tmpS = ((Part) parts.get(i)).search;

      if(tmpP != p && tmpS){
        Part tmpA = ((Part) parts.get(i)).linkA;
        Part tmpB = ((Part) parts.get(i)).linkB;
        if(linkA == null && linkB == null){
          if(linkA == null && tmpA == null){
            linkA = ((Part) parts.get(i));
            ((Part) parts.get(i)).linkA = this;
          }

          else if(linkB == null && tmpB == null){
            linkB = ((Part) parts.get(i));
            ((Part) parts.get(i)).linkB = this;
          }
        }
        else {

        }
      }

    }
  }

  void attractMouse(){
    float tmpA = atan2(p.y-mouse.y, p.x-mouse.x);
    float f = 0.1;
    a.x -= cos(tmpA)*f;
    a.y -= sin(tmpA)*f;
  }

  void move(){
    v.add(a);
    v.mult(drag);
    a.set(0,0,0);
    p.add(v);
  }

  void render(){
    noStroke();
    fill(0);
    ellipse(p.x, p.y, 5, 5);

    if(!search){
      strokeWeight(2);
      stroke(0);
      line(p.x, p.y, linkA.p.x, linkA.p.y);
      strokeWeight(2);
      stroke(0);
      line(p.x, p.y, linkB.p.x, linkB.p.y);
    }
  }

}



