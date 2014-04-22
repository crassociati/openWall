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
 
 /////////////////////////////////////////////////////////////////////////////////////////////////////CONVERSION
boolean fileConverted=false;
PrintWriter output;

void conversion (String Path)
{
  RG.init(this);
  grp = RG.loadShape(Path);
  RG.setPolygonizerLength(1.48);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  points = grp.getPointsInPaths();



  for (int n=0; n<points.length; n++)
  {

    for (int i=0; i<points[n].length; i++)
    {

      noFill();
      stroke(255, 0, 0);

      if (i==0)
      { 
        output.println("0, " + (points[n][i].x) + ", " + (points[n][i].y));
        output.println("1, " + (points[n][i].x) + ", " + (points[n][i].y));
      }

      else
      { 
        output.println("1, " + (points[n][i].x) + ", " + (points[n][i].y));
      }
    }
  }
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  lines = loadStrings("linee.csv"); //non è un vero gcode ma solo un file su due colonne con la lista di coordinate
  fileConverted=true;

}


