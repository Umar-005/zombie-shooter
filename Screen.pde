abstract class Screen {
  Game game;
  PImage background, logo;
  
  Screen(Game game) {
    this.game = game;
    background = game.imageLoader.background;
    logo = game.imageLoader.logo;
  }
  
   void drawBackground() {
    imageMode(CENTER);
    image(background, width/2, height/2, width, height);
  }
  
  void drawLogo(){
    image(logo,width/2,200);
  }
  
  abstract void draw();
  abstract void handleMousePressed();
  abstract void handleKeyPressed();
  abstract void handleKeyTyped();
}








class ScreenStart extends Screen{
  
  Button loginBtn, signupBtn, guestBtn;
  ScreenStart(Game game){
    super(game);
    guestBtn = new Button(width/2,height/2-100,300,80,"Play as Guest");
    loginBtn = new Button(width/2,height/2+20,300,80,"Login");
    signupBtn = new Button(width/2,height/2+140,300,80,"SignUp");
  }
  
  void draw(){
    drawBackground();
    drawLogo();
    
    boolean hoverLogin = loginBtn.isMouseOver();
    boolean hoverSignup = signupBtn.isMouseOver();
    boolean hoverGuestBtn = guestBtn.isMouseOver();
    cursor((hoverLogin || hoverSignup || hoverGuestBtn) ? HAND : ARROW);
    
    loginBtn.draw(hoverLogin);
    signupBtn.draw(hoverSignup);
    guestBtn.draw(hoverGuestBtn);
  }
  void handleMousePressed() {
    if (loginBtn.isMouseOver()) {
      game.switchScreen(new ScreenLogin(game)); // navigate to Login
    }
    else if (signupBtn.isMouseOver()) {
      game.switchScreen(new ScreenSignUp(game)); // navigate to Signup
    }
    else if (guestBtn.isMouseOver()){
      boolean login = false;
      String user = "user";
      while(!login){
        user = user+String.valueOf((int)random(9999));  // adds a random user 
        if(game.database.addUser(user,"1234")){
          game.currentUser = user;
          login = true;
          game.switchScreen(new ScreenMenu(game));
        }
      }
    }
  }
  
  void handleKeyPressed(){}
  void handleKeyTyped(){}
}








class ScreenLogin extends Screen{
  InputField usernameField;
  InputField passwordField;
  ShowButton showButton;
  Button loginButton;
  Button backButton;
  
  boolean showPassword = false;
  boolean usernameWrong = false;
  String displayedPass;

  ScreenLogin(Game game){
    super(game);
    
    usernameField = new InputField(width / 2, 300, 280, 50, "Username");
    passwordField = new InputField(width / 2, 400, 280, 50, "Password");
    showButton    = new ShowButton(width / 2 + 200, 400, 100, 40);
    loginButton   = new Button(width / 2, 500, 300, 80, "Login");
    backButton    = new Button(width / 2, 600, 300, 80, "Back");

    usernameField.setActive(true);   //  Auto focus username on open
  }
  
  void draw(){
    drawBackground();
    fill(255);
    textSize(80);
    textAlign(CENTER, CENTER);
    text("Login", width/2, 130);
    
    usernameField.draw(usernameField.text);
    if(showPassword) displayedPass = passwordField.text;
    else displayedPass = passwordField.text.replaceAll(".", "*");
    passwordField.draw(displayedPass);
    
    showButton.draw(showPassword);
    
    boolean overShow = showButton.isMouseOver();
    boolean overLogin = loginButton.isMouseOver();
    boolean overBack = backButton.isMouseOver();
    cursor((overShow || overLogin || overBack) ? HAND : ARROW);

    loginButton.draw(overLogin);
    backButton.draw(overBack);
    
    if (usernameWrong) {
      fill(255, 0, 0);
      textSize(40);
      text("Username or password is incorrect!", width/2, 700);
    }
  }
  
  
  void handleMousePressed() {
    usernameField.setActive(usernameField.isMouseOver());
    passwordField.setActive(passwordField.isMouseOver());

    if (showButton.isMouseOver()) showPassword = !showPassword;

    if (loginButton.isMouseOver()) attemptLogin(); 

    if (backButton.isMouseOver()) {
      usernameField.clear();
      passwordField.clear();
      game.switchScreen(new ScreenStart(game));
    }
  }

  void handleKeyTyped() {
    if (usernameField.active) usernameField.handleKeyTyped(key);
    else if (passwordField.active) passwordField.handleKeyTyped(key);
  }

  void handleKeyPressed() {
    //  When Enter is pressed, auto move to next step
    if (keyCode == ENTER) {
      if (usernameField.active) {
        usernameField.setActive(false);
        passwordField.setActive(true);
      } else if (passwordField.active) {
        attemptLogin();
      }
    }
  }
  
  void attemptLogin() {
    String username = usernameField.text;
    String password = passwordField.text;
    usernameWrong = false;

    if (game.database.checkLogin(username, password)) {
      game.currentUser = username;
      usernameField.clear();
      passwordField.clear();
      game.switchScreen(new ScreenMenu(game));
    } else {
      usernameWrong = true;
      usernameField.clear();
      passwordField.clear();
      passwordField.setActive(false);
      usernameField.setActive(true);
    }
  }

}






class ScreenSignUp extends Screen{
  
  InputField usernameField;
  InputField passwordField;
  InputField confirmPasswordField;
  ShowButton showButton;
  Button signUpButton;
  Button backButton;

  boolean showPassword = false;
  boolean usernameShort = false;
  boolean usernameExists = false;
  boolean usernameInvalid = false;
  boolean passwordsDontMatch = false;
  String passDisplay, confirmDisplay;

  final int MIN_USERNAME_LEN = 3;
  final int MIN_PASSWORD_LEN = 3;
  
  ScreenSignUp(Game game){
    super(game);
    
    usernameField = new InputField(width / 2, 300, 280, 50, "Username");
    passwordField = new InputField(width / 2, 400, 280, 50, "Password");
    confirmPasswordField = new InputField(width / 2, 500, 280, 50, "Confirm Password");

    showButton = new ShowButton(width / 2 + 200, 400, 100, 40);
    signUpButton = new Button(width / 2, 600, 300, 80, "Sign Up");
    backButton = new Button(width / 2, 700, 300, 80, "Back");

    usernameField.setActive(true);
  }
  
  void draw(){
    drawBackground();
    
    fill(255);
    textSize(80);
    textAlign(CENTER, CENTER);
    text("Sign Up", width / 2, 130);
    
    // Input fields
    usernameField.draw(usernameField.text);
    if(showPassword){
      passDisplay = passwordField.text;
      confirmDisplay = confirmPasswordField.text;
    } else {
      passDisplay =  passwordField.text.replaceAll(".", "*");
      confirmDisplay = confirmPasswordField.text.replaceAll(".", "*");
    }
    passwordField.draw(passDisplay);
    confirmPasswordField.draw(confirmDisplay);
    
    //Buttons
    showButton.draw(showPassword);
    signUpButton.draw(signUpButton.isMouseOver());
    backButton.draw(backButton.isMouseOver());
    cursor((showButton.isMouseOver() || signUpButton.isMouseOver() || backButton.isMouseOver()) ? HAND : ARROW);
    
    
    // Error messages
    fill(255, 0, 0);
    textSize(40);
    if (usernameShort) text("Username or password is too short!", width / 2, 800);
    if (usernameInvalid) text("Username and password can only contain letters, numbers, or _", width / 2, 800);
    if (passwordsDontMatch) text("Passwords do not match!", width / 2, 800);
    if (usernameExists) text("Username already exists!", width / 2, 800);
  }


  void handleMousePressed() {
    usernameField.setActive(usernameField.isMouseOver());
    passwordField.setActive(passwordField.isMouseOver());
    confirmPasswordField.setActive(confirmPasswordField.isMouseOver());

    if (showButton.isMouseOver()) showPassword = !showPassword;
    if (signUpButton.isMouseOver()) attemptSignUp();

    if (backButton.isMouseOver()) {
      clearTextErrors();
      game.switchScreen(new ScreenStart(game));
      clearInputFields();
    }
  }
  
  
  void handleKeyPressed() {
    if (keyCode == ENTER) {
      // Move focus or attempt signup
      if (usernameField.active) {
        usernameField.setActive(false);
        passwordField.setActive(true);
      } 
      else if (passwordField.active) {
        passwordField.setActive(false);
        confirmPasswordField.setActive(true);
      } 
      else if (confirmPasswordField.active) {
        attemptSignUp();
      }
    }
  }
  
  
  void handleKeyTyped() {
    if (usernameField.active) usernameField.handleKeyTyped(key);
    else if (passwordField.active) passwordField.handleKeyTyped(key);
    else if (confirmPasswordField.active) confirmPasswordField.handleKeyTyped(key);
  }
  
  void attemptSignUp() {
    clearTextErrors();
    String username = trim(usernameField.text);
    String password = passwordField.text;
    String confirm = confirmPasswordField.text;

    if (username.length() < MIN_USERNAME_LEN || password.length() < MIN_PASSWORD_LEN) {
      usernameShort = true;
    } else if (!password.equals(confirm)) {
      passwordsDontMatch = true;
    } else if (!username.matches("[A-Za-z0-9_]+") || !password.matches("[A-Za-z0-9_]+")) {
      usernameInvalid = true;
    } else if (game.database.addUser(username, password)) {
      game.currentUser = username;
      clearInputFields();
      game.switchScreen(new ScreenMenu(game));
      return;
    } else {
      usernameExists = true;
    }


    passwordField.clear();
    confirmPasswordField.clear();
    usernameField.clear();
    usernameField.setActive(true);
    passwordField.setActive(false);
    confirmPasswordField.setActive(false);
  }

  void clearTextErrors() {
    usernameShort = false;
    usernameExists = false;
    usernameInvalid = false;
    passwordsDontMatch = false;
  }

  void clearInputFields() {
    usernameField.clear();
    passwordField.clear();
    confirmPasswordField.clear();
  }
}






class ScreenMenu extends Screen{
  
  Button playBtn;
  Button leaderboardBtn;
  Button logoutBtn;
  int buttonHeight = 70;
  int buttonSpacing = 30;
  int userHighScore = 0;
  
  ScreenMenu(Game game){
    super(game);
    
    float logoY = logo.height / 2 + 20;
    float startY = logoY + logo.height / 2 + 50;
    
    userHighScore = game.database.getUserHighScore(game.currentUser);

    playBtn = new Button(width / 2, startY + buttonHeight + buttonSpacing, 300, 80, "Play");
    leaderboardBtn = new Button(width / 2, startY + 2 * (buttonHeight + buttonSpacing),300, 80, "Leaderboard");
    logoutBtn = new Button(width / 2, startY + 3 * (buttonHeight + buttonSpacing), 300, 80, "Logout");
  }
  
  void draw(){
    drawBackground();
    
    float logoY = logo.height / 2 + 20;
    imageMode(CENTER);
    image(logo, width / 2, logoY);
    textAlign(CENTER);
    fill(255);
    textSize(50);
    text("High Score: " + userHighScore, width / 2, logoY + logo.height / 2 - 30);

    boolean overPlay = playBtn.isMouseOver();
    boolean overLeaderboard = leaderboardBtn.isMouseOver();
    boolean overLogout = logoutBtn.isMouseOver();

    cursor((overPlay || overLeaderboard || overLogout) ? HAND : ARROW);

    playBtn.draw(overPlay);
    leaderboardBtn.draw(overLeaderboard);
    logoutBtn.draw(overLogout);
    text("username: " + game.currentUser, 200,100);
    
    
    drawStats(150,200,"Bullets", "You will start with 50", "Increase bullets by \n buying more from the shop");
    drawStats(450,200,"Max Bullets", "Maximum bullets start at 50", "Increase max by \n buying it from the shop");
    drawStats(150,400,"Health", "You will start at 100 health", "Increase health \n from the shop");
    drawStats(450,400,"Bullet Damage", "Bullet damage will start at 10", "Increase bullet damage from the \n shop  headshots do more \n damage");
    drawStats(150,600,"Health Regen", "Health regen starts at 7 health/s", "Increase regen from the shop \n headshots do more damage");
    drawStats(450,600,"Score", "Score per hit is 10", "Headshots give more score");
    drawStats(150,800,"Shop", "Shop is in the right corner", "You cant shoot while shop is open");
    
    
    drawEnemy(width-725,50,"Zombie","normal","normal","normal", game.imageLoader.zombie1,"");
    drawEnemy(width-725,370,"Skeleton","fast weaving","weak","weak", game.imageLoader.skeleton1,"");
    drawEnemy(width-475,50,"Walker","slow","strong","strong", game.imageLoader.walker1,"");
    drawEnemy(width-475,370,"Dog","rapid weaving"," really weak","weak", game.imageLoader.dog1,"");
    drawEnemy(width-225,50,"Doctor","fast","weak","N/A", game.imageLoader.doctor1,"if killed score is halved");
    
    drawDrop(width-725, 720,"Insta Kill" ,  game.imageLoader.instaKill, "takes 1 bullet to kill");
    drawDrop(width-475, 720,"Max Ammo" ,  game.imageLoader.maxAmmo, "fills ammo");
    drawDrop(width-225, 720,"Double Points" ,  game.imageLoader.doublePoints, "doubles score ");
    drawDrop(width-725, 870,"Nuke" ,  game.imageLoader.nuke, "kills everything");
  }
  
  
  void handleMousePressed() {
    if (playBtn.isMouseOver()) {
       game.switchScreen(new ScreenGame(game)); 
    } 
    else if (leaderboardBtn.isMouseOver()) {
      game.switchScreen(new ScreenLeaderboard(game));
    } 
    else if (logoutBtn.isMouseOver()) {
      game.currentUser = "";
      game.switchScreen(new ScreenStart(game));
    }
  }
  
  void handleKeyPressed(){}
  void handleKeyTyped(){}
  
  void drawStats(int x, int y, String name, String info1, String info2){
    rectMode(CENTER);
    noFill();
    rect(x,y+70,285,180);
    textSize(30);
    text(name,x,y);
    textSize(20);
    text(info1,x,y+50);
    text(info2,x,y+100);
  }
  
  void drawEnemy(int x, int y, String name, String movement, String health, String damage, PImage image, String extra){
    rectMode(CORNER);
    noFill();
    rect(x,y,220,310);
    image(image,x+110,y+120);
    textSize(30);
    text(name,x+110,y+20);
    textSize(20);
    text("Health: " + health,x+110,y+200);
    text("Movement: " + movement,x+110,y+230);
    text("Damage: " + damage,x+110,y+260);
    text(extra,x+110,y+290);
  }
  
  void drawDrop(int x, int y, String name, PImage image, String info){
    rectMode(CORNER);
    noFill();
    rect(x,y,220,140);
    image(image,x+110,y+60);
    textSize(30);
    text(name,x+110,y+20);
    textSize(20);
    text("Effect: " + info,x+110,y+120);

    
  }

}









class ScreenLeaderboard extends Screen{
  Button backButton;
  boolean overBack = false;
  
  ScreenLeaderboard(Game game){
    super(game);
    backButton = new Button(width / 2, height - 120, 300, 80, "Back");
  }
  
  void draw(){
    drawBackground();
    
    // set table properties
    int tableW = 800, tableH = 700, rowH = 60, startY = 100;
    float left = width / 2f - tableW / 2f;
    float top = startY;
    float centerY = top + tableH / 2f;
    float colRank = left + 60, colScore = left + tableW * 35/100, colUser = left + tableW * 65/100;
    
    // draw table
    stroke(200);
    strokeWeight(3);
    fill(0, 10, 40, 160);
    rect(width / 2f, centerY, tableW, tableH, 25);


    // draw headings
    fill(180, 220, 255);
    textSize(36);
    textAlign(LEFT, CENTER);
    float headerY = top + 60;
    text("#", colRank, headerY);
    text("Score", colScore, headerY);
    text("Username", colUser, headerY);
    
    // draw columns and headings
    stroke(150, 150, 180, 150);
    strokeWeight(1);
    for (int i = 0; i <= 10; i++) {
      line(left, top + 100 + i * rowH, left + tableW, top + 100 + i * rowH);
    }
    line(colScore - 20, top + 10, colScore - 20, top + tableH - 10);
    line(colUser - 20, top + 10, colUser - 20, top + tableH - 10);
    
    // gets data
    ArrayList<String[]> leaderboard = game.database.getTop10();
    
    // writes data
    fill(255);
    textSize(30);
    textAlign(LEFT, CENTER);
    for (int i = 0; i < leaderboard.size(); i++) {
        String[] row = leaderboard.get(i);
        float rowY = top + 120 + (i * rowH);
        text((i + 1) + ")", colRank, rowY);
        text(row[1], colScore, rowY);
        text(row[0], colUser, rowY);
    }
    
    // draw button
    overBack = backButton.isMouseOver();
    cursor(overBack ? HAND : ARROW);
    backButton.draw(overBack);
  }
  
  void handleMousePressed() {
    if (overBack) game.switchScreen(new ScreenMenu(game));
  }
  
  void handleKeyPressed(){}
  void handleKeyTyped(){}

}
