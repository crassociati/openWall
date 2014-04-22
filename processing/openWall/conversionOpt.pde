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
 
 /////////////////////////////////////////////////////////////////////////////////////////////////////CONVERSIONOPT
PrintWriter outputOpt;
boolean fileOptimized=false;

void conversionOpt (String Path)
{
  println("optimization...");
  float olDistanza;
  float distanzaStart;
  float distanzaEnd;
  float distanza;
  int id=0;

  RG.init(this);
  grp = RG.loadShape(Path);
  //RG.setPolygonizer(RG.ADAPTATIVE);
  RG.setPolygonizerLength(2);
  RG.setPolygonizer(RG.UNIFORMLENGTH);

  points = grp.getPointsInPaths();
  points[0][0].print();

// for each group of points extracted from the lines, I create an Linea object

  for (int i=0; i<points.length; i++)
  {
    linee.add(new Linea(points[i]));
  }

  println("number of paths processed: " + linee.size());
  fileConverted=true;

  // set the cursor to the end of the first line
  cursore.set(linee.get(0).endPoint.x, linee.get(0).endPoint.y);

// as long as there are Linea objects, I'll choose the one closest to the last drawn, I keep the points in an external file and delete it not to consider it again

  while (linee.size () > 0)
  {
    // a reference distance for sure greatest of all those that will measure
    olDistanza =width*2;

    for (int n=0; n<linee.size(); n++)
    {
      // distance between the cursor and start or end points of the next path
      distanzaStart = cursore.dist(linee.get(n).startPoint);
      distanzaEnd = cursore.dist(linee.get(n).endPoint);

      distanza= min(distanzaStart, distanzaEnd);

      // the new object is taken into account only if closer than previously measured
      if (distanza<olDistanza)
      {
        olDistanza=distanza;
        id=n;

// if it is the last point of an object to be closer, and not its first, I must invert the order of its points

if (distanzaEnd<distanzaStart)
        {
          linee.get(n).rev();
        }
      }
    }



//  closed the previous loop, I now have the object id, so i write the points coordinates on the external file
    for (int i=0; i<linee.get(id).points_.length; i++)
    {

      if (i==0)
      { 
        outputOpt.println("0, " + linee.get(id).points_[i].x + ", " + linee.get(id).points_[i].y);
        outputOpt.println("1, " + linee.get(id).points_[i].x + ", " + linee.get(id).points_[i].y);
      }

      else
      { 
        outputOpt. println("1, " + linee.get(id).points_[i].x + ", " + linee.get(id).points_[i].y);
      }
    }


    cursore.set(linee.get(id).endPoint.x, linee.get(id).endPoint.y);
    
    //  remove the objetc

  linee.remove(id);
  }
  outputOpt.flush(); // Writes the remaining data to the file
  outputOpt.close(); // Finishes the file
    lines = loadStrings("linee.csv"); //non è un vero gcode ma solo un file su due colonne con la lista di coordinate
  fileOptimized=true;
  fileConverted=true;
  
   println("file optimized");

}

