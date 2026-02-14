Game game;

void setup() {
  size(1920, 1080);
  background(0);
  game = new Game();  
}

void draw() {
  game.draw();
}

void mousePressed() {
  game.mousePressed();
}


void keyPressed() {
  game.keyPressed();
}

void keyTyped() {
 game.keyTyped();
}
