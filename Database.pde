class Database {
  ArrayList<String[]> leaderboard = new ArrayList<String[]>();
  ArrayList<String []> userInfo = new ArrayList<String[]>();
  
  Database(){
    leaderboard = loadStringArray("data/leaderboard.txt");
    userInfo = loadStringArray("data/userInfo.txt");

  }
  
  // Adds user if it doesnt exist
  boolean addUser(String username, String password) {
    if(!usernameExists(username)){ 
      userInfo.add(new String[]{username,password,"0"}); // username password highscore
      saveListOfArrays(userInfo, "userInfo.txt");
      return true;
    }
    return false;
  }
  
  // checks id username exists
  boolean usernameExists(String username) {
    for (int i=0; i<userInfo.size(); i++) {
      if (userInfo.get(i)[0].equals(username)) {
        return true;
      }
    }
    return false;
  }
  
   // Checks users login info to see if it exists
  boolean checkLogin(String username, String password) {
    if(usernameExists(username)){
      int index = getUserIndex(username);
      if (index == -1) {
        return false; // username not found
      }
      String[] usersInfo = userInfo.get(index);
      return password.equals(usersInfo[1]);
    }
    return false;
  }
  
  // gets index based on the username
  int getUserIndex(String username) {
    for (int i = 0; i < userInfo.size(); i++) {
      if (userInfo.get(i)[0].equals(username)) {
        return i;
      }
    }
    return -1;  // no username
  }

  int getUserHighScore(String username) {
    int index = getUserIndex(username);
    return Integer.valueOf((userInfo.get(index))[2]);
  }
  
  void saveHighScore(String username, int newScore) {
    int index = getUserIndex(username);
    String [] info = userInfo.get(index);
    String [] updatedInfo = {info[0], info[1], String.valueOf(newScore)};
    userInfo.set(index, updatedInfo);
    saveListOfArrays(userInfo, "userInfo.txt");
  }
  
  ArrayList<String[]> getTop10() {
    ArrayList<String[]> displayLeaderboard = new ArrayList<String[]>();
    for(int i = 0; i< leaderboard.size(); i++){
      displayLeaderboard.add(leaderboard.get(i));
    }
    
    while(displayLeaderboard.size()< 10){
      displayLeaderboard.add(new String[] {"N/A", "N/A"});
    }
    
    return displayLeaderboard;
  }  


  void updateTop10(String username, int newScore) {

    boolean inserted = false;

    if (leaderboard.size() > 0) {
      for (int i = 0; i < leaderboard.size(); i++) {
        int score = Integer.valueOf(leaderboard.get(i)[1]);
        if (newScore > score) {
          leaderboard.add(i, new String[]{username, String.valueOf(newScore)});
          inserted = true;
          break;
        }
      }
    } else {
      leaderboard.add(new String[]{username, String.valueOf(newScore)});
      inserted = true;
    }

    // If not inserted inside loop, append at end
    if (!inserted) {
      leaderboard.add(new String[]{username, String.valueOf(newScore)});
    }

    // Always trim to max 10 entries
    if (leaderboard.size() > 10) {
      leaderboard.remove(10);
    }

    // Always save
    saveListOfArrays(leaderboard, "leaderboard.txt");
  }


  
  // saves data into text files
  void saveListOfArrays(ArrayList<String[]> list, String filename) {
    String[] lines = new String[list.size()]; // creates an array with the length of the list.size()
    for (int i = 0; i < list.size(); i++) { 
      String[] arr = list.get(i); 
      lines[i] = join(arr, ' '); // one elemnet of lines stores each element of arr with a space inbetween
    }

    saveStrings("data/" + filename, lines);    // save all lines to file
  }
  
  // loads data from files
  ArrayList<String[]> loadStringArray(String filename) {
    ArrayList<String[]> list = new ArrayList<String[]>();
    String[] lines = loadStrings(filename);
    for (int i=0; i<lines.length ; i++) {
      String[] parts = split(lines[i], ' ');  // parts stors all items that were on that line
      list.add(parts);
    }

    return list;
  }


}
