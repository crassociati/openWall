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
boolean beginned = false;
float bar=0;

void begin()
{
  background(220);

  if
    (bar<keyboard_big.width)
  {

  shape(keyboard_big, width/2-(keyboard_big.width/2), height/2-(keyboard_big.height/2)); 

    bar+=5;
    pushMatrix();
    noStroke();
    fill(cText);
  //  text("loading...", (width/2)-50+1, (height/2)-10);
    rect(width/2-(keyboard_big.width/2), height/2+((keyboard_big.height/2)+10), bar, 10);

    popMatrix();
  }
else
{

  beginned = true;
  return;
}
}

