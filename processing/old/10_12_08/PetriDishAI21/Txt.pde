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

/*

  TODO
    food-eating
    fix the beings eyes so that they do not see light when the body is inbetween them and the light source
    do the AI
      "wander around"-method
      much, much more..
  
  DONE
    basic setup // 1.6
      the class being // 1.6
        memory // 1.7
        methods // 1.7
    display methods // 1.8
      grid // 1.9
      lightmap * translate fix // 1.9
      translate // 1.9
    basic move methods for ani // 1.9
    make a model for what the AI ultimately should be doing // 2.0
      finish of the method under being-class called "primitive()" // 2.0
    memory visualisation // 2.1
    
  ISSUES
    the idea of storing memory as an arrayList is probably not optimal
    it is not currently sure what leg is left, and whats right and what they are called in the memory
*/
