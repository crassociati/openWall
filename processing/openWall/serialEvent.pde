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
 
 void serialEvent(Serial myPort)
{
  while (myPort.available() > 0)
  {
    char inByte2 = myPort.readChar();

    /*
    if (inByte2 <= 32)
      System.out.println("myPort.read() = " + (int) inByte2);
    else
      System.out.println("myPort.read() = " + inByte2);
    */

    if (inByte2 == 'Y')
    {
      isCommandExecuting = false;
    }
    else if (inByte2 == 'N')
    {
      isCommandExecuting = false;
    }
  }
}

