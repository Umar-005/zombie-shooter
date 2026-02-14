class Gun {
  float x, y;
  PImage base, barrel;
  float health = 100;
  float totalHealth = health;
  float pivotX = 57;
  float pivotY = 120;
  float tipX   = 57;
  float tipY   = 50;
  float regenRate =0.1;

  float extend = 60; // makes image appear further away than the pivot point

  Gun(float x, float y) {
    this.x = x;
    this.y = y;
    base   = game.imageLoader.base;
    barrel = game.imageLoader.barrel;
  }

  void drawGun() {
    float angle = atan2(mouseY - y, mouseX - x); // gets angle

    pushMatrix(); // only transform the barrrel
    translate(x, y); 
    rotate(angle + HALF_PI); //roatates image 
    imageMode(CORNER);
    image(barrel, -pivotX, -pivotY - extend); 
    popMatrix();

    imageMode(CENTER);
    image(base, x, y);
    if (health<totalHealth){
      drawHealth();
      health = health + regenRate;
    }
  }

  PVector getBarrelTip() {
    float angle = atan2(mouseY - y, mouseX - x);
    float a = angle + HALF_PI;

    float dx = tipX - pivotX;
    float dy = (tipY - pivotY) - extend;

    float rx = dx*cos(a) - dy*sin(a);
    float ry = dx*sin(a) + dy*cos(a);

    return new PVector(x + rx, y + ry);
  }
  
  
  void drawHealth(){
    float xOffSet = 90;
    float yOffSet = 160;
    float healthPercent = health/totalHealth*100;
    noFill();
    noStroke();
    rectMode(CORNER);
    fill(0,255,0);
    rect(x-xOffSet,y-yOffSet,healthPercent*(xOffSet/50),20);
    fill(255,0,0);
    rect(x-xOffSet+healthPercent*(xOffSet/50),y-yOffSet,xOffSet*2-healthPercent*(xOffSet/50),20);
  }
  

}
