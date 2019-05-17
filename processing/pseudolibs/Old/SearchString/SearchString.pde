// Searches for a specific string, inside another string.
// Returns 'true' if found, 'false' if not.
// If the string searched in is shorter than the one searched for, 'false' will return.
boolean searchString(String searchFor, String searchIn){
  boolean hit = false;
  if(searchFor.length()<searchIn.length()){
    for(int i=0; i<(searchIn.length() - searchFor.length()); i++){
      String tmp = searchIn.substring(i,i+searchFor.length());
      if(tmp.equals(searchFor)){
        hit = true;
      }
    }
  }
  return hit;
}

// Searches for a char in a string.
// Returns the char's place in the string (from 0 to n).
// If the char doesn't exist, 'n' will return.


