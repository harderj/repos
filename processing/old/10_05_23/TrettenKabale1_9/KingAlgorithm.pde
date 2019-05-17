void kingAlgorithm(){

  Card es = new Card(((Card) cards.get(findId(1, (int) random(4)))));

  if(es.x > 1){
    Card byEs = new Card(((Card) cards.get(findPos(es.x+1, es.y))));
  }
  else {
    for(int i=0; i<4; i++){
      Card two = new Card(((Card) cards.get(findId(2, i+1))));

      if(two.x > 1){
        Card byTwo = new Card(((Card) cards.get(findPos(two.x+1, two.y))));
      }
    }
  }
}

