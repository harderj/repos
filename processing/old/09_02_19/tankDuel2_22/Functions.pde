// randomize
float Variate(float a){
  a = random(a-a/5,a+a/5);
  return a;
}

// critmize
float tmpCritmizeA;
float tmpCritmizeB;

float Critmize(float a){
  tmpCritmizeA = a;
  tmpCritmizeB = a;
  if(random(100) < 7.5) Crit();
  return tmpCritmizeA;
}

void Crit(){
  tmpCritmizeA += tmpCritmizeB;
  if(random(100) < 75) Crit();
}

// search string
int searchString(char searchFor, String searchIn){
  int count = 0;
  if(searchIn.length() > 0){
  for(int i=0; i<searchIn.length(); i++){
    if(searchIn.charAt(i) == searchFor){
      break;
    }
    count ++;
  }
  }
  return count;
}
