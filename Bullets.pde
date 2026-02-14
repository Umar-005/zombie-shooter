class Bullets {

  float x;
  float y;
  float speed;
  float x2, y2;
  PVector dir;
  float angle;
  PImage bullet;
  
  Bullets(float x, float y, float speed, float x2, float y2){
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.x2 = x2;
    this.y2 = y2;

    dir = new PVector(x2 - x, y2 - y).normalize();
    angle = atan2(dir.y, dir.x);  //angle toward target

    bullet = game.imageLoader.bullet;
  }
  
  void drawBullet(){
    pushMatrix();
    translate(x, y);
    rotate(angle + PI);
    imageMode(CENTER);
    image(bullet, 0, 0);
    popMatrix();
    moveBullet();
  }
  
  void moveBullet(){
    x += dir.x * speed;
    y += dir.y * speed;
  }

  boolean outOfBounds(){
    return (x < 0 || x > width || y < 0 || y > height);
  }
  
  float[] bulletPosition(){
    return new float[] {x,y};
  }
}
