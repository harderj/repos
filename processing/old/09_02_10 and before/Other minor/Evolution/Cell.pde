class Cell{
  boolean is;
  Vect2 pos, vel, acc;
  String genes;
  float ene, vol;
  int buildPoint;

  Cell(Vect2 position, Vect2 velocity, String genes, float energy){
    is = true;
    pos = position;
    vel = velocity;
    ene = energy;
    vol = 1;
    buildPoint = 0;
    this.genes = genes;
    
    builderGenes();
  }
  
  void buildGenes(){
    for(int i = 0; genes.charAt(i) != 'd' && genes.charAt(i-1) != 'd'; i++){
      buildPoint ++;
      char gen = genes.charAt(i);
      String genFunc = "";
      if(gen != 'c'){
        genFunc += gen;
      } 
      else {
        if(genFunc.charAt(0) == 'b'){
          for(int j = 0; j < genFunc.length(); j++){
            if(ene > 1){
              vol ++;
              ene --;
            }
          }
        }
      }
    }
  }

  void draw(){
    runGenes();
    render();
  }
  
  void runGenes(){
    for(int i = buildPoint; genes.charAt(i) != 'd' && genes.charAt(i-1) != 'd'; i++){
      if(genes.charAt(i) == 'a'){
        
      }
    }
  }
  
  void render(){
    
  }
}
