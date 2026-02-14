class Walker extends Enemy{
  PImage walker1, walker2, walker3, walker4;
  int count = 0;
  Walker(float speed, float enemyDamage, float enemyHealth){
    super(speed,enemyDamage,enemyHealth);
    walker1 = game.imageLoader.walker1;
    walker2 = game.imageLoader.walker2;
    walker3 = game.imageLoader.walker3;
    walker4 = game.imageLoader.walker4;

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
      image(walker1, 0, 0);
    } else if(count < 20){
      image(walker2, 0, 0);
    }else if (count <30){
       image(walker3, 0, 0);
    } else if (count<40){
      image(walker4, 0, 0);
    } else {
      image(walker1, 0, 0);
       count = 0;
    }
    count++;
    popMatrix();
     if (enemyHealth<startHealth){
       drawHealth();
        
    }
    moveEnemy();
  }
  void moveEnemy(){
    if(!inGun()){
      x += dir.x * speed;
      y += dir.y * speed;
    }
  }
  

  
  
  float[] enemyPosition(){
    float centerX = x;
    float bodyY = y+28;
    float zombieBodyRadius = 54;
    float headY = y-43;
    float zombieHeadRadius = 32;
    
    return new float[] {centerX,bodyY,headY,zombieBodyRadius,zombieHeadRadius};
  }
  
}
