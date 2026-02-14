class Doctor extends Enemy{
  PImage doctor1, doctor2, doctor3;
  int count = 0;
  Doctor(float speed, float enemyDamage, float enemyHealth){
    super(speed,enemyDamage,enemyHealth);
    doctor1 = game.imageLoader.doctor1;
    doctor2 = game.imageLoader.doctor2;
    doctor3 = game.imageLoader.doctor3;

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
      image(doctor1, 0, 0);
    } else if(count < 20){
      image(doctor2, 0, 0);
    }else if (count <30){
       image(doctor3, 0, 0);
    } else if (count<40){
      image(doctor2, 0, 0);
    } else {
      image(doctor1, 0, 0);
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
