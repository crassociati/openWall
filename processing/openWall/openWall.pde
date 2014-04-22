/*
  openWall 0.9
 -------------------------- 
 by Pietro Leoni
 --------------------------
 thanks to
 Claudio Indellicati
 --------------------------
 www.carloratti.com
 www.fablabtorino.org
 www.pietroleoni.com
 --------------------------
 pietro.leoni@gmail.com
 --------------------------
 
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


import geomerative.*;
import processing.serial.*;     


RShape grp;
PGraphics pdf;
RPoint[][] points;

color c1= color(250);
color c2= color(180);
color cText= color(24, 133, 187);

float oldx, oldy;

boolean isCommandExecuting = false;
boolean isPlaying=false;
boolean loadGraphic=false;
boolean connected= false;
boolean serialSelected= false;
boolean firstLoad;
boolean simulation= true;

//boolean mousePressed;
///////////First of all, the system calibrates the size of your wall!
int CANVASW = 950;  // canvas width in mm
int CANVASH = 750; // canvas height in mm
int STARTPOINT_X = 2991; // distance between the starting point of the plotter and the nails on the wall (in steps, so mm*4.54) 
int STARTPOINT_Y = 2991; // distance between the starting point of the plotter and the nails on the wall (in steps, so mm*4.54) 

int PLOTTERW = 95;  // this is about the chassis ;-)
int PLOTTERH = 31;  // this also 
float STEPSFACTOR = 4.54; // 220 mm for 1000 steps

float MONITORSCALE=1;
int border=5;

Serial myPort;               

String[] lines;
int index = 0;
ArrayList <Linea> linee;
PVector cursore;

int pathMode=0;

int oldX;

int frameX, frameY, frameW, frameH;
float frameZoom;

/////////////////////////////////////////////////////////////////////////////////////////////////////SETUP

void setup() {
  size(int(CANVASW/MONITORSCALE)+200+(border*2), int(CANVASH/MONITORSCALE)+(border*2));
  background(200);
  stroke(255);

  cursore = new PVector(0, 0);
  linee =new ArrayList <Linea>();


  println(Serial.list());

  // on my macbook is the 4
  try
  {
    myPort = new Serial(this, Serial.list()[4], 9600);
    myPort.bufferUntil('\n');
    println("the openWall is connected :-)");  // e.printStackTrace();
    connected=true;
    simulation=false;
  } 
  catch (Exception e) {
    println("ERROR: " + e);
    println("the openWall is not connected :-(");  // e.printStackTrace();
    connected=false;
    simulation=true;
  }


  // display();
  output = createWriter("linee.csv");
  outputOpt = createWriter("lineeOpt.csv");
//  output8Bit = createWriter("linee8Bit.csv");

  Titillium= createFont("Titillium-Regular.otf", 14);

  keyboard_big = loadShape("keyboard.svg");
  comList = loadShape("comList.svg");
  comList_UP = loadShape("comList_UP.svg");
  comList_DOWN = loadShape("comList_DOWN.svg");
  comList_LEFT = loadShape("comList_LEFT.svg");
  comList_RIGHT = loadShape("comList_RIGHT.svg");
  mouseTrap = loadShape("mouseTrap.svg");

  frameW=int(CANVASW/MONITORSCALE);
  frameH=int(CANVASH/MONITORSCALE);
  frameX=border;
  frameY=border;  
  frameZoom=1;
  frame = createGraphics(int(CANVASW/MONITORSCALE), int(CANVASH/MONITORSCALE));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////DRAW

void draw()
{
  if (beginned == false)
  {
    begin();
  }
  else
  {
    if (fileLoaded == true && fileConverted == false)
    {
      conversion(filePath);
    }

    display(index);
  }
  
  if (simulation && isPlaying)
  {
    index++;   
    if (index >= lines.length)
    {
      println("Fully printed!"); 
      index=0;
      play();
    }
  }

  if (!simulation && isPlaying && !isCommandExecuting)
  {
    if (index < lines.length)
    {
      String[] pieces = split(lines[index], ',');
      
      if (pieces.length == 3)
      {
        int servo = int(pieces[0]);    
        float planarDistLEFT = float(pieces[1]);
        float planarDistRIGHT = float(pieces[2]);    

        float wire1= sqrt(sq(planarDistLEFT - (PLOTTERW/2)) + sq(planarDistRIGHT));
        wire1 = sqrt(sq(wire1) + sq(PLOTTERH)); 
        float wireSX=wire1 * STEPSFACTOR;

        float wire2= sqrt(sq(CANVASW - planarDistLEFT - (PLOTTERW/2)) + sq(planarDistRIGHT));
        wire2 = sqrt(sq(wire2) + sq(PLOTTERH)); 
        float wireDX=wire2*STEPSFACTOR;

        println(servo + "," + planarDistLEFT + ", " + planarDistRIGHT + " converted to = " + wireSX + " " + wireDX); 

        myPort.write(servo + "," + wireSX + "," + wireDX+ "\n");
          
        isCommandExecuting = true;

        index++;
        delay(10);

        if (index == lines.length)
        {
          play();
          goHome();
          index = 0;
        }
      }
    }
  }
}

