class Dog extends Enemy{
  PImage dog1, dog2, dog3;
  int count = 0;

  Dog(float speed, float enemyDamage, float enemyHealth){
    super(speed,enemyDamage,enemyHealth);
    dog1 = game.imageLoader.dog1;
    dog2 = game.imageLoader.dog2;
    dog3 = game.imageLoader.dog3;

  }
  
  void drawEnemy(){

    pushMatrix();
    translate(x, y);
    if(randomStartPosition[0]==0){
        rotate(angle);
              scale(-1, 1);
      }
    else {
      rotate(angle - PI); 
     }
    imageMode(CENTER);
    if (count < 10){
      image(dog1, 0, 0);
    } else if(count < 20){
      image(dog2, 0, 0);
    }else if (count <30){
       image(dog3, 0, 0);
    } else {
      image(dog1, 0, 0);
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
      float perpX = -dir.y;
      float perpY = dir.x;
  
      // sin offset
      float wave = sin(frameCount * waveSpeed + waveOffset) * waveAmplitude;
  
      x += perpX * wave;
      y += perpY * wave;
  }
}
  

  
  void drawHealth(){
    noFill();
    stroke(2);
    rectMode(CORNER);
    float xOffSet = 40;
    float yOffSet = 90;
    rect(x-xOffSet,y-yOffSet,xOffSet*2,10);
    noStroke();
    fill(0,255,0);
    rect(x-xOffSet,y-yOffSet,enemyHealth*(xOffSet/50),10);
    fill(255,0,0);
    rect(x-xOffSet+enemyHealth*(xOffSet/50),y-yOffSet,xOffSet*2-enemyHealth*(xOffSet/50),10);
  }
  
  float[] enemyPosition(){
    float centerX = x-16;
    float bodyY = y+16;
    float zombieBodyRadius = 22;
    float headY = y-13;
    float zombieHeadRadius = 32;
    
    return new float[] {centerX,bodyY,headY,zombieBodyRadius,zombieHeadRadius};
  }
  
}
