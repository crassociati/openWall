 /*
    Copyright (C) 2013  Pietro Leoni

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 /////////////////////////////////////////////////////////////////////////////////////////////////////DISPLAY
PShape keyboard_big, comList, mouseTrap;
PShape comList_UP, comList_DOWN, comList_LEFT, comList_RIGHT;
PFont Titillium;
boolean pointDraw=false;
float cursorX, cursorY;
void display(int index)
{
  background(220);

  smooth();

  if (fileConverted==true)
  {  


    // for (int i=0; i<lines.length; i++)
    // {
    frame.beginDraw();
    frame.smooth();

    if (!pointDraw)
    {
      frame.background(220);

      for (int i=0; i<lines.length; i++)
      {

        String[] pieces = split(lines[i], ',');
        if (pieces.length == 3) {
          int s = int(pieces[0]);    
          float x = float(pieces[1])/MONITORSCALE;
          float y = (float(pieces[2]))/MONITORSCALE;    

          pushMatrix();
          frame.strokeWeight(0.5); 
          frame.stroke(100);
          frame.point(x, y);
          popMatrix();
        }
      }
      pointDraw=true;
    }



    String[] pieces = split(lines[index], ',');
    if (pieces.length == 3) {
      int s = int(pieces[0]);    
      float x = float(pieces[1])/MONITORSCALE;
      float y = float(pieces[2])/MONITORSCALE;    

      if (index<=lines.length && index>0 && s==1)
      {
        frame.strokeWeight(0.75); 
        frame.stroke(cText);
        frame.line(oldx, oldy, x, y);
      }

      else if (index<=lines.length && index>0 && s==0)
      {
        frame.strokeWeight(0.75); 
        frame.stroke(200);
        // frame.line(oldx, oldy, x, y);
      } 
      /*
        else {
       strokeWeight(0.5); 
       stroke(100);
       point(x, y);
       }
       */
      oldx=x;
      oldy=y;
      cursorX=x;
      cursorY=y;
    }
  }
  frame.endDraw();
  pushMatrix();
  noStroke();
  image(frame, frameX, frameY, int(frameW*frameZoom), int(frameH*frameZoom)); 
  //image(frame,mouseX-(width/2), mouseY-(height/2));
  popMatrix();

  if (fileLoaded && index >1)
  {
    pushMatrix();
    stroke(200, 0, 0);
    noFill();
    ellipseMode(CENTER);
    ellipse( cursorX+border, cursorY+border, 6, 6);
    fill(200, 0, 0);
    textSize(8);
    text("x "+ int(cursorX) + "  y "+ int(cursorY), cursorX+border+7, cursorY+border+3);
    strokeWeight(0.1);
    line(border, border, cursorX+border, cursorY+border);
    line(border+frameW, border, cursorX+border, cursorY+border);

    popMatrix();
  }

  pushMatrix();
  fill(cText);
  if (connected) {

    textSize(11);
    text("the openWall is connected :-)", (CANVASW/MONITORSCALE)+border*3, 500);
  }

  if (!connected) {
    textSize(11);
    text("the openWall is not connected :-(", (CANVASW/MONITORSCALE)+border*3, 500);
  }

  if (!fileLoaded)
  {
    textSize(11);
    text("Please select a .svg file,", (CANVASW/MONITORSCALE)+border*3, 515);
  }

  if (fileLoaded)
  {
    textSize(11);
    text("you selected: " + fileName + ",", (CANVASW/MONITORSCALE)+border*3, 515);
  }

  if (isPlaying) {

    pushMatrix();
    textSize(11);
    //fill(cText);
    textAlign(LEFT);
    text("and we are playing it!", (CANVASW/MONITORSCALE)+border*3, 530);
    popMatrix();
  }

  if (!isPlaying) {
    textSize(11);  
    text("however the program is paused.", (CANVASW/MONITORSCALE)+border*3, 530);
  }

  if (pathMode==0) {
    textSize(11);  
    text("Path mode: original.", (CANVASW/MONITORSCALE)+border*3, 545);
  }
  if (pathMode==1) {
    textSize(11);  
    text("Path mode: optimized.", (CANVASW/MONITORSCALE)+border*3, 545);
  }
  if (pathMode==2) {
    textSize(11);  
    text("Path mode: 8Bit.", (CANVASW/MONITORSCALE)+border*3, 545);
  }


  popMatrix();

  shape(comList, width-comList.width, border);  // Draw at coordinate (110, 90) at size 100 x 100

  if (mousePressed)
  {

    fill(100, 75);
    rect(0, 0, width, height);
    shape(mouseTrap, width/2-(keyboard_big.width/2), height/2-(keyboard_big.height/2));  // Draw at coordinate (110, 90) at size 100 x 100
  }

}

void refreshCanvas()
{
  pointDraw=false;
}

PGraphics frame;


void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  //frameZoom=frameZoom+(e/50);
  // frameY+=e;
}


