void debugVect(){
  size(200,200);
  
  //constructors
  Vect t1 = new Vect();
  Vect t2 = new Vect(1);
  Vect t3 = new Vect(2, 3);
  Vect t4 = new Vect(4, 5, 6);
  Vect t5 = new Vect(7, 8, 9, 10);
  Vect t6 = new Vect(11, 12, 13, 14, 15);
  Vect t7 = new Vect(t6);
  float[] tmpArray = new float[7];
  for(int i = 0; i < 7; i++) tmpArray[i] = random(-10,10);
  Vect t8 = new Vect(tmpArray);
  t1.debug("t1");
  t2.debug("t2");
  t3.debug("t3");
  t4.debug("t4");
  t5.debug("t5");
  t6.debug("t6");
  t7.debug("t7");
  t8.debug("t8");
  
  //sets
  Vect t9 = new Vect(tmpArray);
  t9.setZero();
  t9.debug("t9");
  
  Vect t10 = new Vect(t9);
  t10.set(3.6, t9.n.length-2);
  t10.debug("t10");
  
  Vect t11 = new Vect(t9);
  t11.set(tmpArray);
  t11.debug("t11");
  
  Vect t12 = new Vect(t4);
  t12.set(t5);
  t12.debug("t12");
  
  //random
  Vect t13 = new Vect(tmpArray);
  t13.randomize();
  t13.debug("t13");
  
  Vect t14 = new Vect(tmpArray);
  t14.randomize(10);
  t14.debug("t14");
  
  Vect t15 = new Vect(tmpArray);
  t15.randomize(-5,20);
  t15.debug("t15");
  
  //add
  float[] tmpArrayShort = new float[2];
  for(int i = 0; i<tmpArrayShort.length; i++) tmpArrayShort[i] = 100;
  
  Vect t17 = new Vect(tmpArray);
  t17.add(tmpArrayShort);
  t17.debug("t17");
  
  Vect t18 = new Vect(t4);
  t18.add(t5);
  t18.debug("t18");
  
  //sub
  Vect t19 = new Vect(tmpArrayShort);
  t19.sub(tmpArray);
  t19.debug("t19");
  
  Vect t20 = new Vect(t4);
  t20.sub(t5);
  t20.debug("t20");
  
  //normalize
  Vect t21 = new Vect(1);
  t21.normalize();
  t21.debug("t21");
  
  //negativize
  Vect t22 = new Vect(tmpArray);
  t22.negativize();
  t22.debug("t22");
  t11.debug("t22 extented");
}
