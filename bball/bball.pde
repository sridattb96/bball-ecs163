import java.util.Map;
import java.lang.Math;

/* Data Storage */
HashMap<String, double[]> playerData = new HashMap<String, double[]>();
HashMap<String, String> playerNames = new HashMap<String, String>();

Table table;
Table playerTable;
Table teamTable;

/* Useful Variables */
int team1;
int team2;
String team1Name;
String team2Name;
int gameNum;
int game;
int series;
int round;

int count = 0;
int fileNum = 1;
HScrollbar hs1;
PFont f;

/* Court Dimensions */
int courtWidth = 700;
int courtHeight = 420;
int xoffset = 40;
int yoffset = 100;

/* Click Events */
boolean overNextButton = false;
boolean overPrevButton = false;
boolean gamePaused = false;
boolean overPauseButton = false;


boolean button401 = false;
boolean button402 = false;


void setup() {
  size(1250,750);
  
  hs1 = new HScrollbar(xoffset, yoffset + courtHeight + 12, courtWidth, 20, 1);  
  
  /* Initialize */
  gameNum = 401;
  game = 1;
  series = 0;
  round = 4;
  
  loadData(fileNum);
  
  team1 = table.getRow(1).getInt("teamid");
  team2 = table.getRow(6).getInt("teamid");
  
  for (int i = 0; i < teamTable.getRowCount(); i++){
     TableRow row = teamTable.getRow(i);
     if (row.getInt("teamid") == team1){
       team1Name = row.getString("name") + " (" + row.getString("abbr") + ")";
     }
     if (row.getInt("teamid") == team2){
       team2Name = row.getString("name") + " (" + row.getString("abbr") + ")";
     }
  }
  
}

void loadData(int fileNum){
  
  String playerFile = "../players.csv";
  playerTable = loadTable(playerFile);
  
  playerTable.setColumnTitle(0, "playerid");
  playerTable.setColumnTitle(1, "firstname");
  playerTable.setColumnTitle(2, "lastname");
  playerTable.setColumnTitle(3, "jerseynumber");
  
  String teamFile = "../team.csv";
  teamTable = loadTable(teamFile);
  
  teamTable.setColumnTitle(0, "teamid");
  teamTable.setColumnTitle(1, "name");
  teamTable.setColumnTitle(2, "abbr");
  
  String fileName = "../data/games/0041400" + gameNum + "/" + fileNum + ".csv";
  table = loadTable(fileName);
  
  if (table != null){  
      table.setColumnTitle(1, "teamid");
      table.setColumnTitle(2, "playerid");
      table.setColumnTitle(3, "xpos");
      table.setColumnTitle(4, "ypos");
      table.setColumnTitle(7, "gameclock");
      table.setColumnTitle(8, "shotclock");
  }
  
  else {
     println("table is null so increment");
     fileNum++;
     count = 0;
     println(fileNum);
     loadData(fileNum);
  }
}

void draw() {  
  
  background(255, 255, 255);
  
  drawCourt();
  //drawScoreboard();
  drawButtons();
  
  hs1.update();
  hs1.display();
     
  if (count < table.getRowCount()){
     populateCourt();
  }
  else {
     fileNum++;
     count = 0;
     println(fileNum);
     loadData(fileNum);
  }  
  
  drawPlayerInfo();
  drawGameSelection();
}

void drawGameSelection(){
  textSize(13);
  fill(0, 0, 0);
  text("1st round", xoffset + 100, yoffset + courtHeight + 50, 70);
  text("2nd round", xoffset + 250, yoffset + courtHeight + 50, 70);
  text("3rd round", xoffset + 400, yoffset + courtHeight + 50, 70);
  text("4th round", xoffset + 550, yoffset + courtHeight + 50, 70);
  
  text("0st series", xoffset, yoffset + courtHeight + 80, 70);
  text("1st series", xoffset, yoffset + courtHeight + 100, 70);
  text("2nd series", xoffset, yoffset + courtHeight + 120, 70);
  text("3rd series", xoffset, yoffset + courtHeight + 140, 70);
  text("4th series", xoffset, yoffset + courtHeight + 160, 70);
  text("5th series", xoffset, yoffset + courtHeight + 180, 70);
  text("6th series", xoffset, yoffset + courtHeight + 200, 70);
  text("7th series", xoffset, yoffset + courtHeight + 220, 70);

/* Round 1 */
  int inc = 0;
  fill(255, 0, 0);
  for (int i = 0; i < 6; i++){
    ellipse(xoffset + 100 + inc, yoffset + courtHeight + 75, 10, 10);
    inc += 20;
  }
  
  inc = 0;
  for (int i = 0; i < 4; i++){
    ellipse(xoffset + 100 + inc, yoffset + courtHeight + 95, 10, 10);
    inc += 20;
  }
  
    inc = 0;
  for (int i = 0; i < 6; i++){
    ellipse(xoffset + 100 + inc, yoffset + courtHeight + 115, 10, 10);
    inc += 20;
  }
  
      inc = 0;
  for (int i = 0; i < 4; i++){
    ellipse(xoffset + 100 + inc, yoffset + courtHeight + 135, 10, 10);
    inc += 20;
  }
  
      inc = 0;
  for (int i = 0; i < 4; i++){
    ellipse(xoffset + 100 + inc, yoffset + courtHeight + 155, 10, 10);
    inc += 20;
  }
  
      inc = 0;
  for (int i = 0; i < 5; i++){
    ellipse(xoffset + 100 + inc, yoffset + courtHeight + 175, 10, 10);
    inc += 20;
  }
  
      inc = 0;
  for (int i = 0; i < 7; i++){
    ellipse(xoffset + 100 + inc, yoffset + courtHeight + 195, 10, 10);
    inc += 20;
  }
  
        inc = 0;
  for (int i = 0; i < 5; i++){
    ellipse(xoffset + 100 + inc, yoffset + courtHeight + 215, 10, 10);
    inc += 20;
  }
  
  /* Round 2 */
  
          inc = 0;
  for (int i = 0; i < 6; i++){
    ellipse(xoffset + 250 + inc, yoffset + courtHeight + 75, 10, 10);
    inc += 20;
  }
  
            inc = 0;
  for (int i = 0; i < 6; i++){
    ellipse(xoffset + 250 + inc, yoffset + courtHeight + 95, 10, 10);
    inc += 20;
  }
  
            inc = 0;
  for (int i = 0; i < 6; i++){
    ellipse(xoffset + 250 + inc, yoffset + courtHeight + 115, 10, 10);
    inc += 20;
  }
  
            inc = 0;
  for (int i = 0; i < 7; i++){
    ellipse(xoffset + 250 + inc, yoffset + courtHeight + 135, 10, 10);
    inc += 20;
  }
  
 /* Round 3 */
 
  inc = 0;
  for (int i = 0; i < 4; i++){
    ellipse(xoffset + 400 + inc, yoffset + courtHeight + 75, 10, 10);
    inc += 20;
  }
  
  inc = 0;
  for (int i = 0; i < 5; i++){
    ellipse(xoffset + 400 + inc, yoffset + courtHeight + 95, 10, 10);
    inc += 20;
  }
  
  /* Round 4 */
  inc = 0;
  ellipse(xoffset + 550, yoffset + courtHeight + 75, 10, 10);
  ellipse(xoffset + 550, yoffset + courtHeight + 95, 10, 10);

  /* Click Events */
  
  /* Round 4 */
  
  if (mouseX > xoffset + 550 - 5 && mouseX < xoffset + 550 + 5){
    if ( mouseY > yoffset + courtHeight + 75 && mouseY < yoffset + courtHeight + 80){
      println("401");
       button401 = true; 
    }
  }
  
  if (mouseX > xoffset + 550 - 5 && mouseX < xoffset + 550 + 5){
   if ( mouseY > yoffset + courtHeight + 95 && mouseY < yoffset + courtHeight + 100){
           println("402");

      button402 = true; 
   }
  }
}

void drawButtons(){
  
  //next event button
  fill(0, 0, 0);
  rect(xoffset + courtWidth + 20, yoffset + 20, 50, 50);
  
  fill(255, 0, 0);
  triangle(xoffset + courtWidth + 35, yoffset + 35, xoffset + courtWidth + 55, yoffset + 45, xoffset + courtWidth + 35,yoffset + 55); 
  
  if (mouseX > xoffset + courtWidth + 20 && mouseX < xoffset + courtWidth + 70){
    if ( mouseY > yoffset + 20 && mouseY < yoffset + 70){
       overNextButton = true; 
    }
  }
  
  //prev event button
  fill(0, 0, 0);
  rect(xoffset + courtWidth + 20, yoffset + 100, 50, 50);
  
  fill(255, 0, 0);
  triangle(xoffset + courtWidth + 55, yoffset + 115, xoffset + courtWidth + 35, yoffset + 125, xoffset + courtWidth + 55, yoffset + 135); 
 
  if (mouseX > xoffset + courtWidth + 20 && mouseX < xoffset + courtWidth + 70){
    if ( mouseY > yoffset + 100 && mouseY < yoffset + 150){
       overPrevButton = true; 
    }
  }
  
  //pause event button
  if (gamePaused){
        overPauseButton = false;

    fill(255, 0, 0);
    rect(xoffset + courtWidth + 20, yoffset + 180, 50, 50);
  
    fill(0, 0, 0);
    rect(xoffset + courtWidth + 38, yoffset + 195, 3, 20);
    rect(xoffset + courtWidth + 48, yoffset + 195, 3, 20);
  } else {
    overPauseButton = false;
    fill(0, 0, 0);
    rect(xoffset + courtWidth + 20, yoffset + 180, 50, 50);
  
    fill(255, 0, 0);
    rect(xoffset + courtWidth + 38, yoffset + 195, 3, 20);
    rect(xoffset + courtWidth + 48, yoffset + 195, 3, 20);
  }
  
  if (mouseX > xoffset + courtWidth + 20 && mouseX < xoffset + courtWidth + 70){
     if (mouseY > yoffset + 180 && mouseY < yoffset + 230){
       overPauseButton = true;
     }
  }  
  
  //Info
  textSize(20);
  text("Round", xoffset + courtWidth + 20, yoffset + 290, 70); 
  text("" + round, xoffset + courtWidth + 20, yoffset + 320, 70); 
  text("Series", xoffset + courtWidth + 20, yoffset + 350, 70); 
    text("" + series, xoffset + courtWidth + 20, yoffset + 380, 70); 

  text("Game", xoffset + courtWidth + 20, yoffset + 410, 70); 
    text("" + game, xoffset + courtWidth + 20, yoffset + 440, 70); 

  
  
  
}

void mousePressed(){
   if (overNextButton) {
       overNextButton = false;
       fileNum++;
       count = 0;
       println(fileNum);
       loadData(fileNum);
   }
   
   if (overPrevButton) {
       overPrevButton = false;
       fileNum--;
       count = 0;
       println(fileNum);
       loadData(fileNum);
   }
   
   if (overPauseButton){
     if (gamePaused){

        gamePaused = false;
        loop();
     }
     else {

        gamePaused = true;
        
        fill(255, 0, 0);
        rect(xoffset + courtWidth + 20, yoffset + 180, 50, 50);
  
        fill(0, 0, 0);
        rect(xoffset + courtWidth + 38, yoffset + 195, 3, 20);
        rect(xoffset + courtWidth + 48, yoffset + 195, 3, 20);
        
        noLoop();
     }
   }
   
   if (button401) {
       button401 = false;
       count = 0;
       gameNum = 401;
       game = 1;
       series = 0;
       round = 4;
       println("loaded event 401");
       loadData(fileNum);
   }
   
   if (button402) {
       button402 = false;
       count = 0;
       gameNum = 402;
       game = 2;
       series = 0;
       round = 4;
       println("loaded event 401");
       loadData(fileNum);
   }
}

void drawCourt(){  
  
  //court
  fill(232, 211, 136);
  stroke(19,85,213);
  rect(xoffset, yoffset, courtWidth, courtHeight);

  //left half of court
  stroke(19,85,213);
  fill(232, 211, 136);
  arc(xoffset, yoffset + courtHeight/2, .6*courtWidth, courtHeight, -PI/2, PI/2);
  rect(xoffset, yoffset + courtHeight/2 - courtHeight/8, .22*courtWidth, courtHeight/4);
  arc(xoffset + .22*courtWidth + 1, yoffset + courtHeight/2, 110, courtHeight/4, -PI/2, PI/2);

  //hoop
  stroke(255,0,0);
  rect(xoffset + courtWidth/25, yoffset + courtHeight/2 - 24, 1, 50);
  ellipse(xoffset + courtWidth/15, yoffset + courtHeight/2, 25, 25);

  //middle of court
  stroke(19,85,213);
  ellipse(xoffset + courtWidth/2, yoffset + courtHeight/2, 100, 100);
  rect(xoffset + courtWidth/2, yoffset, 1, courtHeight);
  
  //right half of court
  stroke(19,85,213);
  fill(232, 211, 136);
  arc(xoffset + courtWidth, yoffset + courtHeight/2, .6*courtWidth, courtHeight, PI/2, 3*PI/2);
  rect(xoffset + courtWidth - .22*courtWidth, yoffset + courtHeight/2 - courtHeight/8, .22*courtWidth, courtHeight/4);
  arc(xoffset + courtWidth - .22*courtWidth - 1, yoffset + courtHeight/2, 110, courtHeight/4, PI/2, 3*PI/2);
  
  //hoop
  stroke(255,0,0); 
  rect(xoffset + courtWidth - courtWidth/25, 225, 1, 50);
  ellipse(xoffset + courtWidth - courtWidth/15, 250, 25, 25);
}

void drawScoreboard(){
  fill(0, 0, 0);
  rect(xoffset, yoffset + courtHeight, courtWidth, 50); 
}

void populateCourt(){
  TableRow row;
  boolean isPlayer = false;
  //if (table.getRow(count).getInt("teamid") != -1){
  //   println(count);
  //}

  for (int i = 0; i < 11; i++){
     row = table.getRow(count + i);
     if (row.getInt("teamid") == team1) {
         stroke(0, 0, 0);
         fill(108,112,238);
         isPlayer = true;
     }
     else if (row.getInt("teamid") == team2) {
         stroke(0, 0, 0);
         fill(204,0,0);
         isPlayer = true;
     }
     else {
         fill(254,154,61);
         stroke(1, 0);
     }
     
     if (isPlayer){        
       storeInMap(row);
       textSize(12);
       String name = playerNames.get(Integer.toString((row.getInt("playerid"))));
       String num = name.substring(name.indexOf("#"), name.length()-1);
       text(num, row.getInt("xpos")*7 + 30, row.getInt("ypos")*7 + yoffset - 20, 70);
     }
     
     ellipse(row.getInt("xpos")*7 + xoffset, row.getInt("ypos")*7 + yoffset, 20, 20);
     
     drawTopBar(row);
  }
  
  count += 11;
}

void drawTopBar(TableRow row){
  
   stroke(0, 0, 0);
   noFill();
   rect(xoffset, yoffset - 40, courtWidth, 40); 
   
   //game title
   textSize(17);   
   fill(0, 0, 0);
   String title = team1Name + " vs " + team2Name;
   text(title, xoffset + 150, yoffset - 10, 10);

   //shotclock
   textSize(25);
   fill(0, 0, 0);
   int sc = row.getInt("shotclock");
   text(Integer.toString(sc), xoffset + courtWidth - 35, yoffset - 10, 40);
   
   //gametime
   textSize(25);
   fill(0, 0, 0);
   int gt = row.getInt("gameclock");
   text(Integer.toString(gt), xoffset + 10, yoffset - 10, 40);
}

void storeInMap(TableRow row){
    String playerid = String.valueOf(row.getInt("playerid"));
    double[] arr = playerData.get(playerid);
    
    if (arr != null){
      double[] temp = playerData.get(playerid);
      
      //update distance
      double ydiff = temp[1] - row.getInt("ypos");
      double xdiff = temp[0] - row.getInt("xpos");
      double dist = Math.sqrt(ydiff*ydiff + xdiff*xdiff);
      temp[2] += Math.round(7*94*dist/courtWidth);
      
      //update current position
      temp[0] = row.getInt("xpos");
      temp[1] = row.getInt("ypos");
      playerData.put(playerid, temp);
      
    } else {
      double[] temp = {row.getInt("xpos"), row.getInt("ypos"), 0};
      playerData.put(playerid, temp);
      
      for (TableRow rowElem : playerTable.rows()) {
        if (row.getInt("playerid") == rowElem.getInt("playerid")){
           String name = rowElem.getString("firstname") + " " + rowElem.getString("lastname") + " (#" + rowElem.getString("jerseynumber") + ")";
           playerNames.put(playerid, name);
        }
      }
    }
}

void drawPlayerInfo(){

  String title = "Distance Statistics";
  
  fill(255, 255, 255);
  rect(900, yoffset, 250, 70);

  textSize(20);
  fill(0, 0, 0);
  text(title, 930, yoffset + 23, 70);
  
  int ypos = 0;
  for (HashMap.Entry<String, String> entry : playerNames.entrySet())
  {
      String playerid = entry.getKey();
      double[] temp = playerData.get(playerid);
      double dist = temp[2];
            
      //table
      fill(240, 240, 240);
      rect(900, yoffset*1.32 + ypos, 250, 30);
      
      //info button
      textSize(15);
      fill(140, 140, 140);
      ellipse(887, yoffset*1.47 + ypos, 18, 18);
      fill(255, 255, 255);
      text("i", 886, yoffset*1.53 + ypos, 200);

      //text
      String s = entry.getValue() + ": " + dist + " ft";
      textSize(12);
      fill(0, 0, 0);
      text(s, 940, yoffset*1.5 + ypos, 70);
      
      ypos += 30;
  }
  
  drawPlayerScreen();
}

void drawPlayerScreen(){

   fill(240, 240, 240);
   rect(900, yoffset*4.5, 250, 250);
   
   //header
   fill(255, 255, 255);
   textSize(17);
   rect(900, yoffset*4.5, 250, 30);
   String playerName = "Dummy";
   String title = "Player Info: " + playerName;
   fill(0, 0, 0);
   text(title, 935, yoffset*4.5 + 20, 70);
   
   //info
   fill(255, 255, 255);
   rect(900, yoffset*4.5 + 195, 250, 80);
}

class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    //spos = xpos + swidth/2 - sheight/2;
    spos = xoffset;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }
  
  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      //newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
      newspos = constrain(mouseX, sposMin, sposMax);

    }
    //if (abs(newspos - spos) > 1) {
    if (true){  
      //spos = spos + (newspos-spos)/loose;
      //if (spos > 0) {
        
      //} 
      spos = xoffset + (courtWidth-18)*count/table.getRowCount();
      //println(spos);
      
    }
  }
  
  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    //noStroke();
    stroke(0, 0, 0);
    fill(204);  
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }
}