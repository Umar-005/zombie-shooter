class Zombie extends Enemy{
  PImage zombie1, zombie2, zombie3, zombie4;
  int count = 0;
  Zombie(float speed, float enemyDamage, float enemyHealth){
    super(speed,enemyDamage,enemyHealth);
    zombie1 = game.imageLoader.zombie1;
    zombie2 = game.imageLoader.zombie2;
    zombie3 = game.imageLoader.zombie3;
    zombie4 = game.imageLoader.zombie4;

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
      image(zombie1, 0, 0);
    } else if(count < 20){
      image(zombie2, 0, 0);
    }else if (count <30){
       image(zombie3, 0, 0);
    } else if (count<40){
      image(zombie4, 0, 0);
    } else {
      image(zombie1, 0, 0);
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
    float zombieBodyRadius = 51;
    float headY = y-50;
    float zombieHeadRadius = 33;
    
    return new float[] {centerX,bodyY,headY,zombieBodyRadius,zombieHeadRadius};
  }
  
}
