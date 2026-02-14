class Game{
  Database database;
  Screen currentScreen;
  ImageLoader imageLoader;
  String currentUser;
  
  Game(){
    database = new Database();
    imageLoader = new ImageLoader();
    currentScreen = new ScreenStart(this);
  }
  
  void draw() {
    currentScreen.draw();
  }
  
  void mousePressed() {
    currentScreen.handleMousePressed();
  }
  
  void switchScreen(Screen newScreen) {
    currentScreen = newScreen;
  }
  
  void keyPressed() {
      currentScreen.handleKeyPressed();
  }
  void keyTyped() {
      currentScreen.handleKeyTyped();
  }
}
