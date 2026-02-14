class Skeleton extends Enemy{
  PImage skeleton1, skeleton2, skeleton3, skeleton4;
  int count = 0;
  Skeleton(float speed, float enemyDamage, float enemyHealth){
    super(speed,enemyDamage,enemyHealth);
    skeleton1 = game.imageLoader.skeleton1;
    skeleton2 = game.imageLoader.skeleton2;
    skeleton3 = game.imageLoader.skeleton3;
    skeleton4 = game.imageLoader.skeleton4;
  }
  
  void drawEnemy(){

    pushMatrix();
    translate(x, y);
    if(randomStartPosition[0]==0){
        rotate(angle);
      }
    else {
      rotate(angle + PI);
      scale(-1, 1); 
     }
    imageMode(CENTER);
    if (count < 10){
      image(skeleton1, 0, 0);
    } else if(count < 20){
      image(skeleton2, 0, 0);
    }else if (count <30){
       image(skeleton3, 0, 0);
    } else if (count<40){
      image(skeleton4, 0, 0);
    } else {
      image(skeleton1, 0, 0);
       count = 0;
    }
    count++;
    popMatrix();
     if (enemyHealth<startHealth){
       drawHealth();
        
    }
    moveEnemy();
  }
  void moveEnemy() {
    if (!inGun()) {
  
      // forward movement
      x += dir.x * speed;
      y += dir.y * speed;
  
      // perpendicular vector
      perpX = -dir.y;  // makes sin wave perpendicular so it lines up with the enemies direction 
      perpY = dir.x;
  
      // sin offset
      wave = sin(frameCount * waveSpeed + waveOffset) * waveAmplitude;
  
      x += perpX * wave;
      y += perpY * wave;
  }
  }
  

  
  
  float[] enemyPosition(){
    float centerX = x;
    float bodyY = y+30;
    float zombieBodyRadius = 70;
    float headY = y-60;
    float zombieHeadRadius = 30;
    
    return new float[] {centerX,bodyY,headY,zombieBodyRadius,zombieHeadRadius};
  }
  
}
