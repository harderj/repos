/*
  Petri-dish-AI
  By Jacob Harder, begun 22nd of May 2010
  
  The ultimate purpose of this sketch is
  to make an AI-system that, to a being,
  provides the ability to connect the input
  it receives with the output it generates.
  That to such an extend that it can foresee
  the consequences of its actions completely,
  no matter what laws the world it is placed
  in is.
  
  The first instance of such a world and such
  a being, is the simplest i could make up:
  The being is a circle with two lightsensors
  and two legs. The world is much like a rect-
  angular petri dish in a dark room with some
  shining pieces of food. The idea is that the
  being is to learn that light means food.
  Ultimately it should be able to learn to
  calculate the exact position of the food,
  and what move-combinations is best way of
  getting to the food.
*/

void setup(){
  size(500,500);
}

void draw(){
  background(0);
}

class being{
  
  Phys2 rigid;
  int age; // in frames
  
  being(Point2 pos){
    age = 0;
    rigid = new Phys2(pos);
  }
  
  void update(){
    age ++;
    
    
    rigid.update();
    render();
  }
  
  void render(){
    
  }
}
