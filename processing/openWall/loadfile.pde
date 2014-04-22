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
 
 /////////////////////////////////////////////////////////////////////////////////////////////////////LOADFILE
String filePath=""; 
String fileName=""; 

boolean fileLoaded=false;

public void fileLoad() {

  if (!isPlaying && !fileLoaded)
  {
    selectInput("Select a file to process:", "fileSelected");
  }

  else if (!isPlaying && fileLoaded)
  {

    index=0;
    fileLoaded=false;
    fileConverted=false;
    filePath="";
    lines=null;

    output = createWriter("linee.csv");
    outputOpt = createWriter("lineeOpt.csv");
    fileOptimized=false;
    pathMode=0;
    refreshCanvas();

    selectInput("Select a file to process:", "fileSelected");
  }
}

void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());
    filePath=selection.getAbsolutePath();
    fileName= selection.getName();
    fileLoaded=true;
    println(filePath);
  }
}

