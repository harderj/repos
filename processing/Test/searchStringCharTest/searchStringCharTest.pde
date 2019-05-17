boolean hey = true;

int searchString(char searchFor, String searchIn){
  int count = 0;
  for(int i=0; i<searchIn.length(); i++){
    if(searchIn.charAt(i) == searchFor){
      break();
    }
    count ++;
  }
  return count;
}

void setup(){
  String tmpHey = "g3j9sfdka2";
  int tmpHo = searchString('k', tmpHey);
  println(tmpHo);
}

void draw(){

}
