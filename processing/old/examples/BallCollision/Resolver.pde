// Ball collision is a transcript of code from the following url: 
// http://www.phy.ntnu.edu.tw/ntnujava/index.php?topic=4.msg15#msg15 
// Resolve a collision between Balls 
void resolveBallCollision(BallParticle a, BallParticle b){ 
  // Save velocities 
  float avx = a.x-a.px; 
  float avy = a.y-a.py; 
  float bvx = b.x-b.px; 
  float bvy = b.y-b.py; 
  // get the current line between the balls 
  Line ball_to_ball = new Line(a, b); 
  // do we have to wind back time? 
  float penetration = a.radius+b.radius-ball_to_ball.len; 
  float time_of_collision = 0; 
  if(penetration > 0){ 
    // take the speed of the overlap and use that as a measurement to reverse time 
    float a_velocity_towards = avx*ball_to_ball.dx+avy*ball_to_ball.dy;
    float b_velocity_towards = bvx*ball_to_ball.dx+bvy*ball_to_ball.dy;
    time_of_collision = penetration/(a_velocity_towards-b_velocity_towards); 
    a.x -= avx*time_of_collision; 
    a.y -= avy*time_of_collision; 
    b.x -= bvx*time_of_collision; 
    b.y -= bvy*time_of_collision; 
    // ball 2 ball needs to be updated for the reflection to work 
    ball_to_ball.updateLine(); 
  } 
  // the balls need to be reflected along their trajectories 
  // velocity projections 
  float a_velocity_dot = avx*ball_to_ball.dx+avy*ball_to_ball.dy; 
  float a_perp_velocity_dot = -avx*ball_to_ball.dy+avy*ball_to_ball.dx;
  float b_velocity_dot = bvx*ball_to_ball.dx+bvy*ball_to_ball.dy; 
  float b_perp_velocity_dot = -bvx*ball_to_ball.dy+bvy*ball_to_ball.dx;
  // new velocity projections 
  float a_new_velocity_dot = a_velocity_dot+a.elasticity+(b_velocity_dot-a_velocity_dot); 
  float b_new_velocity_dot = b_velocity_dot+b.elasticity+(a_velocity_dot-b_velocity_dot); 
  // calculate new velocities 
  avx = a_new_velocity_dot*ball_to_ball.dx-a_perp_velocity_dot*ball_to_ball.dy; 
  avy = a_new_velocity_dot*ball_to_ball.dy+a_perp_velocity_dot*ball_to_ball.dx;
  bvx = b_new_velocity_dot*ball_to_ball.dx-b_perp_velocity_dot*ball_to_ball.dy; 
  bvy = b_new_velocity_dot*ball_to_ball.dy+b_perp_velocity_dot*ball_to_ball.dx;
  // do we have to wind forward time? 
  if(penetration > 0){ 
    // wind forward time to avoid balls sticking 
    // I've found that ommiting this part generally adds stability - 
    // the balls become less logical so you're not surprised when they skip ahead 
    a.x += avx*time_of_collision; 
    a.y += avy*time_of_collision; 
    b.x += bvx*time_of_collision; 
    b.y += bvy*time_of_collision; 
  } 
  // apply new velocity 
  a.px = a.x-avx; 
  a.py = a.y-avy; 
  b.px = b.x-bvx; 
  b.py = b.y-bvy; 
} 
