// Pathfinding w/ Genetic Algorithms
// Daniel Shiffman <http://www.shiffman.net>

// A class for an obstacle, just a simple rectangle that is drawn
// and can check if a creature touches it

// Also using this class for starting point and target location

class Obstacle {

  Rectangle r;

  Obstacle(int x, int y, int w, int h) {
    r = new Rectangle(x,y,w,h);
  }



  void render() {
    smooth();
    stroke(0);
    fill(175);
    rectMode(CORNER);
    rect(r.x,r.y,r.width,r.height);
  }

  boolean contains(PVector spot) {
    if (r.contains((int)spot.x,(int)spot.y)) {
      return true;
    } else {
      return false;
    }
  }

}

class Rectangle{
  int x,y,width,height;
  
  Rectangle(int positionX, int positionY, int widthX, int heightY){
    x=positionX;
    y=positionY;
    width=widthX;
    height=heightY;
  }
  
  boolean contains(int spotX, int spotY){
    return (spotX > x && spotX < x+width && spotY > y && spotY < y+height);
  }
}
