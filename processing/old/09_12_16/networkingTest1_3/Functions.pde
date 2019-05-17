PVector string2Vector(String theString){
  String[] tmp = split(theString,',');
  
  PVector v = new PVector();
  
  for(int i=0; i<tmp.length; i++){
    if(i==0) v.x = string2Float(tmp[i]);
    if(i==1) v.y = string2Float(tmp[i]);
    if(i==2) v.z = string2Float(tmp[i]);
  }
  
  return v;
}

String vector2String(PVector theVector){
  String s = ("[ " + theVector.x + ", " + theVector.y + ", " + theVector.z + " ]");
  
  return s;
}

float string2Float(String theString){
  String tmp = "";
  for(int i=0; i<theString.length(); i++){
    if(theString.charAt(i) == '0' || theString.charAt(i) == '1' || theString.charAt(i) == '2' || theString.charAt(i) == '3' ||
    theString.charAt(i) == '4' || theString.charAt(i) == '5' || theString.charAt(i) == '6' || theString.charAt(i) == '7' ||
    theString.charAt(i) == '8' || theString.charAt(i) == '9' || theString.charAt(i) == '.'){
      tmp += theString.charAt(i);
    }
  }
  
  return float(tmp);
}
