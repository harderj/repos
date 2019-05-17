import processing.opengl.*;

int interval = 5000;
int lastTime = 0;
int pauseTime = 300;
PFont[] fonts = new PFont[1];
int fontNum = 0;
int skipNum = 10; // not too high! above 15 might cause a crash

int ID1, ID2;
int sentenceCount;
Sentence[] ss;
int[] used;
float tOffsetX, tOffsetY, tSize;

void setup() {
  size(screen.width, screen.height, OPENGL);
  background(0);
  smooth();

  loadFonts();
  loadTexts();
}

void draw() {
  background(0);

  if(key == 'p') doPause();
  else if(keyPressed && key == 'i') showEdit();
  else doSentences();

  doKeyControls();
}

void loadFonts() {
  //fonts[0] = loadFont("Serif-48.vlw");
  fonts[0] = loadFont("GB18030Bitmap-48.vlw");
}

void loadTexts() {
  String[] s = loadStrings("newSents.txt");
  String[] r = loadStrings("rules.txt");
  println(s);
  sentenceCount = (s.length-2);
  ss = new Sentence[sentenceCount];
  used = new int[sentenceCount];

  int typeNum = 0;
  String[] typeTag = {
    "left,right,", "left,", "right,"
  };

  for( int i=0; i<s.length; i++) {
    if(s[i].length() != 0) {
      if(s[i].charAt(0) == '-') {
        typeNum ++;
      }
      else {
        ss[i-typeNum] = new Sentence((i-typeNum), s[i], typeTag[typeNum]);
        used[i-typeNum] = 0;
      }
    }
  }

  for( int i=0; i<r.length; i++) {
    if(r[i].length()>0) {
      ss[int(r[i].charAt(0))].tags += r[i];
    }
  }
}

void doKeyControls() {
  if(keyPressed) {
    // text horizontal control
    if(key == 'a') tOffsetX --;
    if(key == 'd') tOffsetX ++;
    // text vertical control
    //if(key == 'w') tOffsetY --;
    //if(key == 's') tOffsetY ++;
    // text size control
    if(key == 'q') tSize -= 0.2;
    if(key == 'e') tSize += 0.2;
  }
}

void doSentences() {
  if(millis() > lastTime) {
    for(int i=0; i<sentenceCount; i++) if(used[i] > 0) used[i] --;
    used[ID1] = skipNum;
    used[ID2] = skipNum;
    //println(used);
    findNewID();
    //for(int i=0; i<40; i++) println(i + "   " + badCombi(i,7));
  }

  if(abs(lastTime-millis())>pauseTime) {
    renderSentences();
  }
}

void renderSentences(){
  fill(255);
    textFont(fonts[fontNum], 22 + tSize);
    float y = height*0.5 + tOffsetY;
    float x = width*0.2 + tOffsetX;
    textAlign(CENTER);
    text(ss[ID1].t, x, y);
    text(ss[ID2].t, width-x, y);
}

void renderPauseButton(){
  fill(255);
  noStroke();
  rect(width*0.35, height*0.6, width*0.05, height*0.2);
  rect(width*0.50, height*0.6, width*0.05, height*0.2);
}

void doPause() {
  renderPauseButton();
  renderSentences();
}

void findNewID() {
  lastTime = (millis() + interval);
  ID1 = int(random(sentenceCount));
  ID2 = int(random(sentenceCount));
  if( badCombi(ID1, ID2) ) findNewID();
}

boolean badCombi(int a, int b) {
  if(a == b) return true;
  if(!searchString("left", ss[a].tags)) return true;
  if(!searchString("right", ss[b].tags)) return true;
  if(used[a] > 0) return true;
  if(used[b] > 0) return true;
  String[] tmpA = split(ss[a].tags, ',');
  for(int i=0; i<tmpA.length; i++) if(int(tmpA[i]) == b) return true;
  return false;
}

void showEdit() {
  showTexts();
}

void showTexts() {
  fill(255);
  textAlign(LEFT);

  textFont(fonts[fontNum], 10);
  for( int i=0; i<sentenceCount; i++) {
    text(ss[i].t, width*0.05, 20+i*12);
  }

  String[] tmpS = loadStrings("rules.txt");
  fill(255,0,0);
  for( int i=0; i<tmpS.length; i++) {
    text(ss[int(split(tmpS[i], ',')[0])].t, width*0.6, 20+i*12);
    text(ss[int(split(tmpS[i], ',')[1])].t, width*0.8, 20+i*12);
  }
}

//void mousePressed(){exit();}

void mousePressed() {
  String[] s = loadStrings("rules.txt");
  String tmp = str(ID1) + "," + str(ID2);
  println(append(s, tmp));
  saveStrings("data/rules.txt", append(s, tmp));
}

class Sentence {
  int ID;
  String t, tags;

  Sentence(int ID, String t, String tags) {
    this.ID = ID;
    this.t = t;
    this.tags = tags;
  }
}

boolean searchString(String searchFor, String searchIn) {
  boolean hit = false;
  if(searchFor.length()<searchIn.length()) {
    for(int i=0; i<(searchIn.length() - searchFor.length()); i++) {
      String tmp = searchIn.substring(i,i+searchFor.length());
      if(tmp.equals(searchFor)) {
        hit = true;
      }
    }
  }
  return hit;
}

