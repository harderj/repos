void microFighters(){
  update1();
  update2();
  combinateModes();
  render1();
  render2();
}

void update1(){
  // intPut
  String tmpKeys = "swadqe";
  String tmpModeThis = mode1;
  String tmpModeThat = mode2;
  float tmpLifeThis = life1;
  float tmpLifeThat = life2;

  char tmpBF = '0'; // TemporaryButtonFind
  String tmpBM1 = ""; // TemporaryButtonMode#
  String tmpBM2 = "";
  String tmpBM3 = "";
  String tmpBM4 = "";
  String tmpBM5 = "";
  String tmpBM6 = "";

  tmpBF = tmpKeys.charAt(0); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM1 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(1); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM2 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(2); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM3 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(3); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM4 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(4); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM5 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(5); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM6 = ((Button) buttons.get(i)).mode;

  // mode settings
  if(tmpBM1 != "off" && tmpModeThis == "backing") tmpModeThis = "back";
  if(tmpBM2 != "off" && tmpModeThis == "striking") tmpModeThis = "strike";
  if(tmpBM3 != "off" && tmpModeThis == "highBlocking") tmpModeThis = "highBlock";
  if(tmpBM4 != "off" && tmpModeThis == "lowBlocking") tmpModeThis = "lowBlock";
  if(tmpBM5 != "off" && tmpModeThis == "highStriking") tmpModeThis = "highStrike";
  if(tmpBM6 != "off" && tmpModeThis == "lowStriking") tmpModeThis = "lowStrike";

  if(tmpBM1 != "off" && tmpModeThis != "back") tmpModeThis = "backing";
  if(tmpModeThis == "back"){
    if(tmpBM2 != "off") tmpModeThis = "striking";
    if(tmpBM3 != "off") tmpModeThis = "highBlocking";
    if(tmpBM4 != "off") tmpModeThis = "lowBlocking";
    if(tmpBM5 != "off") tmpModeThis = "highStriking";
    if(tmpBM6 != "off") tmpModeThis = "lowStriking";
  }

  // outPut
  mode1 = tmpModeThis;
  mode2 = tmpModeThat;
  life1 = tmpLifeThis;
  life2 = tmpLifeThat;
}

void update2(){
  // intPut
  String tmpKeys = "juhkyi";
  String tmpModeThis = mode2;
  String tmpModeThat = mode1;
  float tmpLifeThis = life2;
  float tmpLifeThat = life1;

  char tmpBF = '0'; // TemporaryButtonFind
  String tmpBM1 = ""; // TemporaryButtonMode#
  String tmpBM2 = "";
  String tmpBM3 = "";
  String tmpBM4 = "";
  String tmpBM5 = "";
  String tmpBM6 = "";

  tmpBF = tmpKeys.charAt(0); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM1 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(1); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM2 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(2); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM3 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(3); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM4 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(4); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM5 = ((Button) buttons.get(i)).mode;

  tmpBF = tmpKeys.charAt(5); 
  for(int i=0; i<buttons.size(); i++) if(tmpBF == ((Button) buttons.get(i)).order)
    tmpBM6 = ((Button) buttons.get(i)).mode;

  // mode settings
  if(tmpBM1 != "off" && tmpModeThis == "backing") tmpModeThis = "back";
  if(tmpBM2 != "off" && tmpModeThis == "striking") tmpModeThis = "strike";
  if(tmpBM3 != "off" && tmpModeThis == "highBlocking") tmpModeThis = "highBlock";
  if(tmpBM4 != "off" && tmpModeThis == "lowBlocking") tmpModeThis = "lowBlock";
  if(tmpBM5 != "off" && tmpModeThis == "highStriking") tmpModeThis = "highStrike";
  if(tmpBM6 != "off" && tmpModeThis == "lowStriking") tmpModeThis = "lowStrike";

  if(tmpBM1 != "off" && tmpModeThis != "back") tmpModeThis = "backing";
  if(tmpModeThis == "back"){
    if(tmpBM2 != "off") tmpModeThis = "striking";
    if(tmpBM3 != "off") tmpModeThis = "highBlocking";
    if(tmpBM4 != "off") tmpModeThis = "lowBlocking";
    if(tmpBM5 != "off") tmpModeThis = "highStriking";
    if(tmpBM6 != "off") tmpModeThis = "lowStriking";
  }

  // outPut
  mode2 = tmpModeThis;
  mode1 = tmpModeThat;
  life2 = tmpLifeThis;
  life1 = tmpLifeThat;
}

void combinateModes(){
  float tmpDmg1 = 0;
  float tmpDmg2 = 0;
  // 1
  if(mode1 == "striking"){
    if(mode2 == "striking"){
      tmpDmg2 += strikingStrikingDmg;
      textPops.add(new TextPop("CLASHING STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode2 == "strike"){
      tmpDmg2 += strikingStrikeDmg;
      textPops.add(new TextPop("GOOD STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode2 == "back" || mode2 == "backing"){
      tmpDmg2 += strikingBackDmg;
      textPops.add(new TextPop("STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode2 == "highStriking" || mode2 == "lowStriking"){
      tmpDmg2 += strikingHlstrikingDmg;
      textPops.add(new TextPop("PERFECT STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode2 == "highStrike" || mode2 == "lowStrike"){
      tmpDmg2 += strikingHlstrikeDmg;
      textPops.add(new TextPop("GREAT STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode2 == "highBlock" || mode2 == "highBlocking" || mode2 == "lowBlock" || mode2 == "lowBlocking"){
      tmpDmg1 += strikingBlockDmg;
      textPops.add(new TextPop("BLOCKED STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  if(mode1 == "backing"){
    if(mode2 == "strike" || mode2 == "highStrike" || mode2 == "lowStrike"){
      tmpDmg2 += backingStrikeDmg;
      textPops.add(new TextPop("RIP",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  if(mode1 == "highBlocking" || mode1 == "lowBlocking"){
    if(mode2 == "strike"){
      tmpDmg2 += blockingStrikeDmg;
      textPops.add(new TextPop("BASHING BLOCK",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  if(mode1 == "highStriking"){
    if(mode2 != "highBlock" && mode2 != "highblocking" && mode2 != "striking"){
      tmpDmg1 += hlstrikingGeneralDmg;
      textPops.add(new TextPop("BAD STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode2 == "highBlock" || mode2 == "highBlocking"){
      tmpDmg2 += blockCrushDmg;
      textPops.add(new TextPop("SHATTERING STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  if(mode1 == "lowStriking"){
    if(mode2 != "lowBlock" && mode2 != "lowblocking" && mode2 != "striking"){
      tmpDmg1 += hlstrikingGeneralDmg;
      textPops.add(new TextPop("BAD STRKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode2 == "lowBlock" || mode2 == "lowBlocking"){
      tmpDmg2 += blockCrushDmg;
      textPops.add(new TextPop("SHATTERING STRIKE",x1,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  // 2
  if(mode2 == "striking"){
    if(mode1 == "striking"){
      tmpDmg1 += strikingStrikingDmg;
      textPops.add(new TextPop("CLASHING STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode1 == "strike"){
      tmpDmg1 += strikingStrikeDmg;
      textPops.add(new TextPop("GOOD STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode1 == "back" || mode1 == "backing"){
      tmpDmg1 += strikingBackDmg;
      textPops.add(new TextPop("STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode1 == "highStriking" || mode1 == "lowStriking"){
      tmpDmg1 += strikingHlstrikingDmg;
      textPops.add(new TextPop("PERFECT STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode1 == "highStrike" || mode1 == "lowStrike"){
      tmpDmg1 += strikingHlstrikeDmg;
      textPops.add(new TextPop("GREAT STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode1 == "highBlock" || mode1 == "highBlocking" || mode1 == "lowBlock" || mode1 == "lowBlocking"){
      tmpDmg2 += strikingBlockDmg;
      textPops.add(new TextPop("BLOCKED",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  if(mode2 == "backing"){
    if(mode1 == "strike" || mode1 == "highStrike" || mode1 == "lowStrike"){
      tmpDmg1 += backingStrikeDmg;
      textPops.add(new TextPop("RIP",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  if(mode2 == "highBlocking" || mode2 == "lowBlocking"){
    if(mode1 == "strike"){
      tmpDmg1 += blockingStrikeDmg;
      textPops.add(new TextPop("BASHING BLOCK",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  if(mode2 == "highStriking"){
    if(mode1 != "highBlock" && mode1 != "highblocking" && mode1 != "striking"){
      tmpDmg2 += hlstrikingGeneralDmg;
      textPops.add(new TextPop("BAD STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode1 == "highBlock" || mode1 == "highBlocking"){
      tmpDmg1 += blockCrushDmg;
      textPops.add(new TextPop("SHATTERING STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  if(mode2 == "lowStriking"){
    if(mode1 != "lowBlock" && mode1 != "lowblocking" && mode1 != "striking"){
      tmpDmg2 += hlstrikingGeneralDmg;
      textPops.add(new TextPop("BAD STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
    if(mode1 == "lowBlock" || mode1 == "lowBlocking"){
      tmpDmg1 += blockCrushDmg;
      textPops.add(new TextPop("SHATTERING STRIKE",x2,height/2+40,15,35,color(255,255,255),"00111101"));
    }
  }
  
  if(tmpDmg1 > 0){
    textPops.add(new TextPop(str(int(tmpDmg1)),x1,height/2-40,15,15,color(255,255,255),"00111110"));
  }
  if(tmpDmg2 > 0){
    textPops.add(new TextPop(str(int(tmpDmg2)),x2,height/2-40,15,15,color(255,255,255),"00111110"));
  }
  life1 -= tmpDmg1;
  life2 -= tmpDmg2;
}

void render1(){
  color col = color(255,0,0);
  
  strokeWeight(3);
  stroke(col);

  // strike
  if(mode1 == "striking"){
    line(x1,height/2,width/2,height/2);
  }
  
  if(mode1 == "strike"){
    line(x1,height/2+5,x2,height/2);
  }
  
  // highStrike
  if(mode1 == "highStriking"){
    line(x1,height/2,width/2,height/2-20);
  }
  
  if(mode1 == "highStrike"){
    line(x1,height/2,x2,height/2-20);
  }
  
  // lowStrike
  if(mode1 == "lowStriking"){
    line(x1,height/2,width/2,height/2+20);
  }
  
  if(mode1 == "lowStrike"){
    line(x1,height/2,x2,height/2+20);
  }
  
  // block
  if(mode1 == "highBlocking" || mode1 == "lowBlocking"){
    line(x1+35,height/2-20,x1+35,height/2+20);
  }
  
  if(mode1 == "highBlock"){
    line(x1+40,height/2,x1+40,height/2-40);
  }
  
  if(mode1 == "lowBlock"){
    line(x1+40,height/2,x1+40,height/2+40);
  }
  
  // body
  fill(col);
  noStroke();
  if(mode1 != "back" && mode1 != "backing"){
    ellipse(x1,height/2,height/10,height/10);
  }
  if(mode1 == "backing"){
    ellipse(x1-25,height/2,height/10,height/10);
  }
  if(mode1 == "back"){
    ellipse(x1-50,height/2,height/10,height/10);
  }

  // info
  textFont(font,10);
  text("Life: " + int(life1), width/20, height/20);
  
  textFont(font,10);
  text("Mode: " + mode1, width/20, height/20*2);
}

void render2(){
  color col = color(0,255,0);
  
  strokeWeight(3);
  stroke(col);

  // strike
  if(mode2 == "striking"){
    line(x2,height/2,width/2,height/2);
  }
  
  if(mode2 == "strike"){
    line(x2,height/2-5,x1,height/2);
  }
  
  // highStrike
  if(mode2 == "highStriking"){
    line(x2,height/2,width/2,height/2-20);
  }
  
  if(mode2 == "highStrike"){
    line(x2,height/2,x1,height/2-20);
  }
  
  // lowStrike
  if(mode2 == "lowStriking"){
    line(x2,height/2,width/2,height/2+20);
  }
  
  if(mode2 == "lowStrike"){
    line(x2,height/2,x1,height/2+20);
  }
  
  // block
  if(mode2 == "highBlocking" || mode2 == "lowBlocking"){
    line(x2-35,height/2-20,x2-35,height/2+20);
  }
  
  if(mode2 == "highBlock"){
    line(x2-40,height/2,x2-40,height/2-40);
  }
  
  if(mode2 == "lowBlock"){
    line(x2-40,height/2,x2-40,height/2+40);
  }
  
  // body
  fill(col);
  noStroke();
  if(mode2 != "back" && mode2 != "backing"){
    ellipse(x2,height/2,height/10,height/10);
  }
  if(mode2 == "backing"){
    ellipse(x2+25,height/2,height/10,height/10);
  }
  if(mode2 == "back"){
    ellipse(x2+50,height/2,height/10,height/10);
  }

  // info
  textFont(font,10);
  text("Life: " + int(life2), width/20*15, height/20);
  
  textFont(font,10);
  text("Mode: " + mode2, width/20*15, height/20*2);
}
