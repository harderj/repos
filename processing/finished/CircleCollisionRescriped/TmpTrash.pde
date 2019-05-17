/*
Vect2D bVect = new Vect2D();
   bVect.vx = b[1].x - b[0].x;
   bVect.vy = b[1].y - b[0].y;
   
   float bVectMag = sqrt(bVect.vx * bVect.vx + bVect.vy * bVect.vy);
   if (bVectMag < b[0].r + b[1].r){
   
   float theta  = atan2(bVect.vy, bVect.vx);
   
   float sine = sin(theta);
   float cosine = cos(theta);
   
   Vect2[] bTemp = {  
   new Vect2(),
   new Vect2()
   };
   
   bTemp[1].x  = cosine * bVect.vx + sine * bVect.vy;
   bTemp[1].y  = cosine * bVect.vy - sine * bVect.vx;
   
   // rotate Temporary velocities
   Vect2D[] vTemp = { 
   new Vect2D(), new Vect2D()             };
   vTemp[0].vx  = cosine * v[0].vx + sine * v[0].vy;
   vTemp[0].vy  = cosine * v[0].vy - sine * v[0].vx;
   vTemp[1].vx  = cosine * v[1].vx + sine * v[1].vy;
   vTemp[1].vy  = cosine * v[1].vy - sine * v[1].vx;
   
   Vect2D[] vFinal = {  
   new Vect2D(), new Vect2D()              };
   // final rotated velocity for b[0]
   vFinal[0].vx = ((b[0].m - b[1].m) * vTemp[0].vx + 2 * b[1].m * vTemp[1].vx) / (b[0].m + b[1].m);
   vFinal[0].vy = vTemp[0].vy;
   // final rotated velocity for b[0]
   vFinal[1].vx = ((b[1].m - b[0].m) * vTemp[1].vx + 2 * b[0].m * vTemp[0].vx) / (b[0].m + b[1].m);
   vFinal[1].vy = vTemp[1].vy;
   
   // hack to avoid clumping
   bTemp[0].x += vFinal[0].vx;
   bTemp[1].x += vFinal[1].vx;
   
   // rotate balls
   Ball[] bFinal = { 
   new Ball(), new Ball()             };
   bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
   bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
   bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
   bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;
   
   // update balls to screen position
   b[1].x = b[0].x + bFinal[1].x;
   b[1].y = b[0].y + bFinal[1].y;
   b[0].x = b[0].x + bFinal[0].x;
   b[0].y = b[0].y + bFinal[0].y;
   
   // update velocities
   v[0].vx = cosine * vFinal[0].vx - sine * vFinal[0].vy;
   v[0].vy = cosine * vFinal[0].vy + sine * vFinal[0].vx;
   v[1].vx = cosine * vFinal[1].vx - sine * vFinal[1].vy;
   v[1].vy = cosine * vFinal[1].vy + sine * vFinal[1].vx;
   }
   }


for(int i=0; i<balls.size(); i++){
      Vect2 tmpPos = new Vect2(((Ball) balls.get(i)).pos.x, ((Ball) balls.get(i)).pos.y);
      float distance = dist(pos.x, pos.y, tmpPos.x, tmpPos.y);
      if(distance < r + ((Ball) balls.get(i)).r && ((Ball) balls.get(i)).id != id){
        Vect2 tmpVel = new Vect2(((Ball) balls.get(i)).vel.x, ((Ball) balls.get(i)).vel.y);
        Vect2 tmpAcc = new Vect2(((Ball) balls.get(i)).acc.x, ((Ball) balls.get(i)).acc.y);
        float tmpM = ((Ball) balls.get(i)).m;
        float theta = atan2(tmpPos.y - pos.y, tmpPos.x - pos.x);
        float sine = sin(theta);
        float cosine = cos(theta);

        Vect2[] tmpA = {new Vect2(), new Vect2()};
        tmpA[1].x = cosine*(tmpPos.x-pos.x) + sine*(tmpPos.y-pos.y);
        tmpA[1].y = cosine*(tmpPos.x-pos.x) - sine*(tmpPos.y-pos.y);

        Vect2[] tmpB = {new Vect2(), new Vect2()};
        tmpB[0].x = cosine*tmpVel.x + sine*tmpVel.y;
        tmpB[0].y = cosine*tmpVel.x - sine*tmpVel.y;
        tmpB[1].x = cosine*vel.x + sine*vel.y;
        tmpB[1].y = cosine*vel.x - sine*vel.y;

        Vect2[] tmpC = {new Vect2(), new Vect2()};
        tmpC[0].x = (m - tmpM) * tmpB[0].x;
        tmpC[0].y = tmpB[0].y;
        tmpC[1].x = (tmpM - m) * tmpB[1].x;
        tmpC[1].y = tmpB[1].y;

        tmpA[0].x += tmpC[0].x;
        tmpA[1].x += tmpC[1].x;

        Vect2[] tmpD = {new Vect2(), new Vect2()};
        tmpD[0].x = cosine * tmpA[0].x - sine * tmpA[0].y;
        tmpD[0].y = cosine * tmpA[0].y + sine * tmpA[0].x;
        tmpD[1].x = cosine * tmpA[1].x - sine * tmpA[1].y;
        tmpD[1].y = cosine * tmpA[1].y + sine * tmpA[1].x;
        
        tmpPos.x = pos.x + tmpD[1].x;
        tmpPos.y = pos.y + tmpD[1].y;
        pos.x += tmpD[0].x;
        pos.y += tmpD[0].y;

        vel.x = cosine * tmpC[0].x - sine * tmpC[0].y;
        vel.y = cosine * tmpC[0].y + sine * tmpC[0].x;
        tmpVel.x = cosine * tmpC[1].x - sine * tmpC[1].y;
        tmpVel.y = cosine * tmpC[1].y + sine * tmpC[1].x;
      }
    }
  }





*/
