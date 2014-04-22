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
 
 ////////////////////
class Linea {
  PVector startPoint;
  PVector endPoint;
  RPoint[] points_;
  RPoint[] revPoints={};


  Linea(RPoint[] _points)
  {
    points_= _points;
    startPoint = new PVector(points_[0].x, points_[0].y);
    endPoint = new PVector(points_[points_.length-1].x, points_[points_.length-1].y);
    /*
    startPoint.x = points_[0].x;    
     startPoint.y = points_[0].y;
     endPoint.x = points_[points_.length-1].x;
     endPoint.y = points_[points_.length-1].y;
     */
  }


  void display()
  {
    
    for (int i=0; i<points_.length; i++)
    {
      if (i>0)
      {
        //linee
        pushMatrix();
        stroke(0, 60);
        strokeWeight(0.1);
        line(points_[i-1].x, points_[i-1].y, points_[i].x, points_[i].y );
        popMatrix();

        //punti
        if ( startPoint.x == endPoint.x && startPoint.y == endPoint.y )
        {
          pushMatrix();
          stroke(0, 0, 255);
          strokeWeight(3);
          point(startPoint.x, startPoint.y);
          popMatrix();
        }
        else
        {
          pushMatrix();
          stroke(0, 255, 0);
          strokeWeight(3);
          point(startPoint.x, startPoint.y);
          popMatrix();

          pushMatrix();
          stroke(255, 0, 0);
          strokeWeight(3);
          point(endPoint.x, endPoint.y);
          popMatrix();
        }

        //   println("line from: " + points_[i-1].x + ", " +  points_[i-1].y +  " to: " + points_[i].x + ", " + points_[i].y);
      }
    }
  }

  void rev()
  {
    points_ = (RPoint[]) reverse(points_);
    startPoint.set(points_[0].x, points_[0].y);
    endPoint.set(points_[points_.length-1].x, points_[points_.length-1].y);
  }
}



