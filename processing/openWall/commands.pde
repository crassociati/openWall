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
 
int movement=20;

void play()
{
  if (fileConverted)
  {
    isPlaying = !isPlaying;    
    if (isPlaying == true)
    {       
      println("play! ");
    }
    if (isPlaying == false)
    {        
      println("pause! ");
    }
  }
}

void reset()
{
  if (!isPlaying)
  {
    index=0;
  }
}

void moveLeft()
{
  println("left");
  myPort.write(3 + "," + -movement + "," + movement + "\n");
}

void moveRight() 
{
  println("right");
  myPort.write(3 + "," + movement + "," + -movement + "\n");
} 

void moveUp() 
{
  println("up");
  myPort.write(3 + "," + -movement + "," + -movement + "\n");
} 

void moveDown()  
{
  println("down");
  textSize(15); 
  myPort.write(3 + "," + movement + "," + movement + "\n");
} 


void setZero()
{
  println("system calibrated");
  myPort.write(6 + "," + STARTPOINT_X + "," + STARTPOINT_Y + "\n");
}

void calibrateAxis()
{
  println("calibrate axis");
  myPort.write(20 + "," + 1 + "," + 1+ "\n");
}


void goHome()
{
  println("go home!");
  myPort.write(0 + "," + STARTPOINT_X + "," + STARTPOINT_Y + "\n");
}

void pathMode()
{
  refreshCanvas();
  pathMode++;
  if (pathMode > 1)
  {
    pathMode=0;
  }
  if (pathMode==0)
  {  
    println("path mode: original paths"); 
    lines=null;
    index=0;
    lines = loadStrings("linee.csv"); //non è un vero gcode ma solo un file su due colonne con la lista di coordinate
  }
  if (pathMode==1)
  {
    if (fileConverted==true) //se il file è già stato convertito
    {
      if (fileOptimized==false) // se il file non è ancora stato ottimizzato lo faccio, alrimenti mi limito a riselezionare il suo percorso.
      {
        fileConverted=false;
        conversionOpt(filePath);
      }
      
      lines=null;
      index=0;
      lines = loadStrings("lineeOpt.csv"); //non è un vero gcode ma solo un file su due colonne con la lista di coordinate
      println("path mode: optimized paths");
    }
  }
}

void penUp()
{
  println("pen up");
  myPort.write(3 + "," + 0 + "," + 0 + "\n");
}

void penDown()
{
  println("pen down");
  myPort.write(4 + "," + 0 + "," + 0 + "\n");
}

