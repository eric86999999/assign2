PImage bg1,bg2,start1,start2,end1,end2,enemy,fighter,hp,treasure;
int health,bgX,bgY,GAMEMODE=1,fighterX,fighterY,treasureX,treasureY,enemyX,enemyY;
int upDetect,downDetect,leftDetect,rightDetect;                         //detect collision
boolean upPressed=false;
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

void setup () {
  
  size(640,480) ;
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png"); 
  health= floor(random(420,606));
  treasureX=floor(random(30,610));
  treasureY=floor(random(30,450));
  bgX=0;
  bgY=-640;
  GAMEMODE=1;
  fighterX=540;                       
  fighterY=240;
  treasureX=floor(random(30,610));
  treasureY=floor(random(30,450));
  enemyX=-200;
  enemyY=floor(random(0,429));
  health=450;
}

void draw() {

switch(GAMEMODE){

case 1:                         //start menu

  image(start2,0,0);
  if ((mouseX<444 && mouseX>202)&&(mouseY<422 && mouseY>380)){    //detecting mouse area
    image(start1,0,0);
if(mousePressed){
GAMEMODE=2;
 } 
}
 break;
   
case 2:                                //start game

  image(bg2,bgY,0);                    //background scrolling
  image(bg1,bgX,0);           
  bgX+=4;
  bgY+=4;
  if(bgX==640){                        //bg1 reset
    bgX=-640;
  }
  if(bgY==640){                        //bg2 reset
    bgY=-640;
  }

  upDetect=floor(random(fighterX,fighterX+51));
  downDetect=floor(random(fighterX,fighterX+51));
  leftDetect=floor(random(fighterY,fighterY+51));
  rightDetect=floor(random(fighterY,fighterY+51));
  
  image(fighter,fighterX,fighterY);     //fighter
  if(upPressed && fighterY>0){
    fighterY-=4;
  }
  if(downPressed && fighterY<429){
    fighterY+=4;
  }
  if(leftPressed && fighterX>0 ){
    fighterX-=4;
  }
  if(rightPressed && fighterX<589){
    fighterX+=4;
  }

  image(treasure,treasureX,treasureY); //treasure

  image(enemy,enemyX,enemyY);          //moving enemy
   enemyX+=5;
   if(enemyX>=780){                    //border restart & random spawn
    enemyY=floor(random(30,450));
    enemyX=-200;
   }

  rectMode(CORNERS);                    //hp gauge
  fill(255,0,0);
  rect(410,50,health,30);               //hp gauge 410:min,610:max
  stroke(255,0,0);
  image(hp,405,28);

                                        //damage detector
  if(upDetect>=enemyX && upDetect<=enemyX+61 && fighterY>=enemyY && fighterY<=enemyY+61 || downDetect>=enemyX && downDetect<=enemyX+61 && fighterY+51>=enemyY && fighterY+51<=enemyY+61
      || leftDetect>=enemyY && leftDetect<=enemyY+61 && fighterX>=enemyX && fighterX<=enemyX+61 || rightDetect>=enemyY && rightDetect<=enemyY+61 && fighterX+51>=enemyX && fighterX+51<=enemyX+61){
                                                                                           
        
     if(health>450){
      enemyX=-61;
      enemyY=floor(random(0,429));      
      health-=40;
            }
     else{                              //gameover detect
       GAMEMODE=3;
        }
  }                                     //heal detector
     if(upDetect>=treasureX && upDetect<=treasureX+41 && fighterY>=treasureY && fighterY<=treasureY+41 || downDetect>=treasureX && downDetect<=treasureX+41 && fighterY+51>=treasureY && fighterY+51<=treasureY+41
      || leftDetect>=treasureY && leftDetect<=treasureY+41 && fighterX>=treasureX && fighterX<=treasureX+41 || rightDetect>=treasureY && rightDetect<=treasureY+41 && fighterX+51>=treasureX && fighterX+51<=treasureX+41){
      treasureX=floor(random(0,589));
      treasureY=floor(random(0,429));      
      if(health<=590){
        health+=20;
  }
     }
                                        //enemy chasing
if(enemyY+30.5>=fighterY+25.5 && enemyY-fighterY<=80){       
  enemyY-=2;
}
else if(enemyY+30.5>=fighterY+25.5 && enemyY-fighterY<=160){
  enemyY-=3;
}
else if(enemyY+30.5>=fighterY+25.5 && enemyY-fighterY<=240){
  enemyY-=4;
}
else if(enemyY+30.5>=fighterY+25.5 && enemyY-fighterY<=480){
  enemyY-=5;
}

if(enemyY+30.5<=fighterY+25.5 && fighterY-enemyX<=80){
  enemyY+=2;
}
else if(enemyY+30.5<=fighterY+25.5 && fighterY-enemyX<=160){
  enemyY+=3;
}
else if(enemyY+30.5<=fighterY+25.5 && fighterY-enemyX<=240){
  enemyY+=4;
}
else if(enemyY+30.5<=fighterY+25.5 && fighterY-enemyX<=480){
  enemyY+=5;
}
break;
   
case 3:                               //game over
  image(end2,0,0);
  if ((mouseX<width*2/3 && mouseX>width*1/3)&&(mouseY<355 && mouseY>308)){
    image(end1,0,0);
if(mousePressed){                            
  health=450;                         //restart
  enemyX=-61;
  fighterX=540;
  fighterY=240;
  GAMEMODE=2;
 } 
}
  break;
}
}

void keyPressed(){                    //key detection
    if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed=true;
      break;        
      case DOWN:
        downPressed=true;
      break;        
      case LEFT:
        leftPressed=true;
      break;
      case RIGHT:
        rightPressed=true;
      break;
    }
  }

}
void keyReleased(){
      if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed=false;
        break;
      case DOWN:
        downPressed=false;
        break;
      case LEFT:
        leftPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
    }
  }


}
