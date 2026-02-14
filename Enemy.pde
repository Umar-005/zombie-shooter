abstract class Enemy{
  
  // enemies positions and velocity 
  int [] randomStartPosition;
  float x,y,speed,angle ;
  int gunX, gunY;
  PVector dir;
  
  // enemies info
  float enemyDamage,bulletDamage,startHealth,enemyStartHealth,enemyHealth;
  boolean alive = true;
  
  // images
  PImage blood1,blood2,blood3,blood4,explosion1, explosion2, explosion3, explosion4;
  
  // animation
  int animationCount =0;
  int animationLength = 12;
  
  
  // advanced movement
  float waveOffset = random(TWO_PI); // random different starting point
  float waveSpeed = 0.2;             // how fast it oscillates
  float waveAmplitude = 8; 
  float perpX, perpY,wave;
  
  Enemy(float speed, float enemyDamage, float enemyHealth){
    this.speed = speed;
    this.enemyDamage = enemyDamage;
    this.enemyHealth = enemyHealth;
    enemyStartHealth = enemyHealth;
    randomStartPosition = randomPosition();
    x = randomStartPosition[0];
    y = randomStartPosition[1];
    gunX = width/2; 
    gunY = height/2-38;
    
    dir = new PVector(gunX - x, gunY - y).normalize();
    angle = atan2(dir.y, dir.x);  //angle toward target
    
    startHealth = enemyHealth;
    
    
    blood1 = game.imageLoader.blood1;
    blood2 = game.imageLoader.blood2;
    blood3 = game.imageLoader.blood3;
    blood4 = game.imageLoader.blood4;
    
    explosion1 = game.imageLoader.explosion1;
    explosion2 = game.imageLoader.explosion2;
    explosion3 = game.imageLoader.explosion3;
    explosion4 = game.imageLoader.explosion4;
    
  }
  
  int[] randomPosition() {
    int r = int(random(1, 3)); 
    int randomY = int(random(0, height));
  
    if (r == 1) return new int[] {width, randomY};
    else return new int[] {0, randomY};          

  }
  
  boolean inGun(){
        return dist(x, y, width / 2, height / 2 - 38) < 200;
  }
  
  void deathAnimation(boolean nuke){
    imageMode(CENTER);
    if(!nuke){
      if (animationCount < animationLength/4){
        image(blood1, x, y);
      } 
      else if(animationCount < 2 * animationLength/4){
        image(blood2, x, y);
      }
      else if (animationCount < 3 * animationLength/4){
        image(blood3, x, y);
      }
      else if (animationCount < animationLength){
        image(blood4, x, y);
      }
    }
    else{
      if (animationCount < animationLength/4){
        image(explosion1, x, y);
      } 
      else if(animationCount < 2 * animationLength/4){
        image(explosion2, x, y);
      }
      else if (animationCount < 3 * animationLength/4){
        image(explosion3, x, y);
      }
      else if (animationCount <animationLength){
        image(explosion4, x, y);
      }
    
    
    }
    animationCount++;
  }
  
  
  void drawHealth(){
    float xOffSet = 40;
    float yOffSet = 90;
    float health = enemyHealth/enemyStartHealth*100;   // ensure the length stays the same no matter the health
    noFill();
    stroke(2);
    rectMode(CORNER);
    rect(x-xOffSet,y-yOffSet,xOffSet*2,10);
    noStroke();
    fill(0,255,0);
    rect(x-xOffSet,y-yOffSet,health*(xOffSet/50),10);
    fill(255,0,0);
    rect(x-xOffSet+health*(xOffSet/50),y-yOffSet,xOffSet*2-health*(xOffSet/50),10);
  }
  
  float updateHealth(float enemyHealth, float bulletDamage){
    enemyHealth = enemyHealth - bulletDamage;
    return enemyHealth;
  }
  abstract float[] enemyPosition();
  abstract void drawEnemy();
  abstract void moveEnemy();

  
}
