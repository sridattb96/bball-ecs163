import java.util.Map;
import java.lang.Math;

HashMap<String, double[]> playerData = new HashMap<String, double[]>();
HashMap<String, String> playerNames = new HashMap<String, String>();

Table table;
Table playerTable;
int count = 0;
int fileNum = 1;
HScrollbar hs1;
PFont f;

/* Court Dimensions */
int courtWidth = 700;
int courtHeight = 420;
int xoffset = 40;
int yoffset = 40;

/* Click Events */
boolean overNextButton = false;
boolean overPrevButton = false;
boolean gamePaused = false;
boolean overPauseButton = false;

void setup() {
  size(1200,700);
  
  hs1 = new HScrollbar(0, 492, width, 16, 16);  
    
  loadData(fileNum);
}

void loadData(int fileNum){
  
  String playerFile = "../players.csv";
  playerTable = loadTable(playerFile);
  
  playerTable.setColumnTitle(0, "playerid");
  playerTable.setColumnTitle(1, "firstname");
  playerTable.setColumnTitle(2, "lastname");
  
  String fileName = "../data/games/0041400102/" + fileNum + ".csv";
  table = loadTable(fileName);
  
  if (table != null){  
      table.setColumnTitle(1, "teamid");
      table.setColumnTitle(2, "playerid");
      table.setColumnTitle(3, "xpos");
      table.setColumnTitle(4, "ypos");
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
  drawScoreboard();
  drawButtons();
  
  //hs1.update();
  //hs1.display();
     
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
}

void drawCourt(){  
  
  //court
  fill(232, 211, 136);
  stroke(19,85,213);
  rect(40, 40, 700, 420);

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
  if (table.getRow(count).getInt("teamid") != -1){
     println(count);
     noLoop();
  }
  for (int i = 0; i < 11; i++){
     row = table.getRow(count + i);
     if (row.getInt("teamid") == 1610612737) {
         stroke(0, 0, 0);
         fill(108,112,238);
         storeInMap(row);
     }
     else if (row.getInt("teamid") == 1610612751) {
         stroke(0, 0, 0);
         fill(204,0,0);
         storeInMap(row);
     }
     else {
         fill(254,154,61);
         stroke(1, 0);
     }
     
     ellipse(row.getInt("xpos")*7 + xoffset, row.getInt("ypos")*7 + yoffset, 20, 20);
  }
  
  count += 11;
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
      temp[2] += dist;
      
      //update current position
      temp[0] = row.getInt("xpos");
      temp[1] = row.getInt("ypos");
      playerData.put(playerid, temp);
      
    } else {
      double[] temp = {row.getInt("xpos"), row.getInt("ypos"), 0};
      playerData.put(playerid, temp);
      
      for (TableRow rowElem : playerTable.rows()) {
        if (row.getInt("playerid") == rowElem.getInt("playerid")){
           String name = rowElem.getString("firstname") + " " + rowElem.getString("lastname");
           playerNames.put(playerid, name);
        }
      }
    }
}

void drawPlayerInfo(){
  
  String title = "Distances traveled by each player";
  fill(255, 0, 0);
  text(title, 900, yoffset*2, 70);
  

  int ypos = 0;
  for (HashMap.Entry<String, String> entry : playerNames.entrySet())
  {
      String playerid = entry.getKey();
      double[] temp = playerData.get(playerid);
      double dist = temp[2];
      
      String s = entry.getValue() + ": " + dist;
      
      fill(255, 0, 0);
      text(s, 900, yoffset*3 + ypos, 70);
      
      ypos += 30;
  }
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
    spos = xpos + swidth/2 - sheight/2;
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
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
      if (spos > 0) {
        
      }
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
    noStroke();
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