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

#include <Stepper.h>
#include <Servo.h>

// Pins
#define LED1_PIN 9
#define LED2_PIN 5
#define LED3_PIN 6
#define PEN_SERVO_PIN 7
#define STEPPER_ENABLE_PIN A1

// Stepper steps per revolution
#define STEPS 48

// Rensponse codes
#define RESP_OK 'Y'
#define RESP_KO 'N'

// Motors
Stepper leftStepper(STEPS, 10, 11, 12, 13);
Stepper rightStepper(STEPS, A2, A3, A4, A5);
Servo penServo;

// Steppers speeds
#define INITIAL_STEPPERS_SPEED 50
int fastStepperSpeed = 100;
int slowStepperSpeed = 100;

// Pen servo positions
int penWritePosition = 0;
int penUpPosition = 20;

#define PEN_DAMPING_DELAY 7

int oldPenPosition = penUpPosition;

long leftStepperPosition = 0L,
     rightStepperPosition = 0L,
     oldLeftStepperPosition = 0L,
     oldRightStepperPosition = 0L;






//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
int pendelay = 100;
boolean pen = false;
boolean oldpen = false;
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!
//// REMOVE!






/////////////////////////////////////////////////////////////////////////////////////////////////////SETUP

void setup()
{
  Serial.begin(9600);

  pinMode(LED1_PIN, OUTPUT);
  pinMode(LED2_PIN, OUTPUT);
  pinMode(LED3_PIN, OUTPUT);
  digitalWrite(LED1_PIN, LOW);
  digitalWrite(LED2_PIN, LOW);
  digitalWrite(LED3_PIN, LOW);

  pinMode(STEPPER_ENABLE_PIN, OUTPUT);
  digitalWrite(STEPPER_ENABLE_PIN, HIGH); 
  setSteppersSpeed(INITIAL_STEPPERS_SPEED);

  penServo.attach(PEN_SERVO_PIN);
  setPenPosition(penWritePosition);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////LOOP

void loop()
{
  oldLeftStepperPosition = leftStepperPosition;
  oldRightStepperPosition = rightStepperPosition;

  receiveCommand();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////RECEIVE COMMAND

void receiveCommand()
{
  while (Serial.available() > 0)
  {
    int commandCode = Serial.parseInt();  
    float commandParam1 = Serial.parseFloat(); 
    float commandParam2 = Serial.parseFloat();  

    if (Serial.read() == '\n')
    {
      if (executeCommand(commandCode, commandParam1, commandParam2))
        Serial.println(RESP_OK);
      else
        Serial.println(RESP_KO);
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////EXECUTE COMMAND

boolean executeCommand (int commandCode, float commandParam1, float commandParam2)
{
  if (commandCode == 0)
  {
    // Move, no write, fast speed
    
    digitalWrite(LED1_PIN, LOW);
    digitalWrite(LED2_PIN, HIGH);

    setSteppersSpeed(fastStepperSpeed);

    pen = false;

    setPenPosition(penUpPosition);

    if (oldpen != pen)
    { 
      delay(pendelay);
    }
 
    oldpen = pen;

    moveToCoordinates(commandParam1, commandParam2);
    
    return true;
  }
  else if (commandCode == 1)
  {
    // Write while moving, slow speed
    
    digitalWrite(LED1_PIN, HIGH);
    digitalWrite(LED2_PIN, LOW);

    setSteppersSpeed(slowStepperSpeed);

    pen = true;

    setPenPosition(penWritePosition);

    if (oldpen != pen)
    { 
      delay(pendelay);
    }

    oldpen = pen;

    moveToCoordinates(commandParam1, commandParam2);
        
    return true;
  }
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  else if (commandCode == 2)
  {
    // Move the steppers and write. fast speed

    digitalWrite(LED1_PIN, LOW);

    setSteppersSpeed(fastStepperSpeed);

    pen = false;

    setPenPosition(penWritePosition);

    moveSteppers(commandParam1, commandParam2);

    if (oldpen != pen)
    { 
      delay(pendelay);
    }

    oldpen = pen;

    return true;
  }
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  // REMOVE!!!!!!
  else if (commandCode == 3)
  {
    // Move the steppers, no write, fast speed

    digitalWrite(LED1_PIN, LOW); 

    setSteppersSpeed(fastStepperSpeed);

    pen = false;

    setPenPosition(penUpPosition);

    moveSteppers(commandParam1, commandParam2);

    if (oldpen != pen)
    { 
      delay(pendelay);
    }

    oldpen = pen;

    return true;
  }
  else if (commandCode == 4)
  {
    // Move the steppers and write. fast speed

    digitalWrite(LED1_PIN, LOW); 
 
    setSteppersSpeed(fastStepperSpeed);
 
    pen = true;
 
    setPenPosition(penWritePosition);

    moveSteppers(commandParam1, commandParam2);

    if (oldpen != pen)
    { 
      delay(pendelay);
    }

    oldpen = pen;

    return true;
  }
  else if (commandCode == 6)
  {
    // Initial calibration, no move
    
    digitalWrite(LED3_PIN, HIGH);

    leftStepperPosition = commandParam1;
    rightStepperPosition = commandParam2;

    return true;
  }
  else if (commandCode == 7)
  {
    // Set slow and fast speed values
    
    fastStepperSpeed = commandParam1;
    slowStepperSpeed = commandParam2;
    
    return true;
  }
  else if (commandCode == 9)
  {
    // Set pen servo position
    
    setPenPosition(commandParam1);

    return true;
  }
  else if (commandCode == 10)
  {
    // Set pen up servo position
    
    penUpPosition = commandParam1;
    
    return true;
  }
  else if (commandCode == 11)
  {
    // Set pen write servo position
    
    penWritePosition = commandParam1;
    
    return true;
  }
  else if (commandCode == 20)
  {
    // Disable stepper motors
    
    digitalWrite(STEPPER_ENABLE_PIN, LOW);  

    return true;
  }
  else if (commandCode == 21)
  {
    // Enable stepper motors
    
    digitalWrite(STEPPER_ENABLE_PIN, HIGH);  

    return true;
  }
  else
  {
    // Unrecognized command
    
    return false;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////MOVE TO COORDINATES

void moveToCoordinates (long newLeftStepperPosition, long newRightStepperPosition)
{
  leftStepperPosition = newLeftStepperPosition;
  rightStepperPosition = newRightStepperPosition;

  long distLEFT = max(leftStepperPosition, oldLeftStepperPosition) - min(leftStepperPosition, oldLeftStepperPosition);

  if (leftStepperPosition < oldLeftStepperPosition)
  { 
    distLEFT = -distLEFT;
  } 

  long distRIGHT = max(rightStepperPosition, oldRightStepperPosition) - min(rightStepperPosition, oldRightStepperPosition);

  if (rightStepperPosition < oldRightStepperPosition)
  { 
    distRIGHT = -distRIGHT;
  } 

  moveAlongLine(0L, 0L, distLEFT, distRIGHT);
  
  delay(10);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////MOVE ALONG LINE

// thanks to http://arduino.cc/forum/index.php/topic,65835.msg482379.html#msg482379
void moveAlongLine (long x0, long y0, long x1, long y1)
{
  // Bresenham's Line Algorithm

  long ox, oy;
  int ma, mb;
  long dx = abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
  long dy = abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
  long err = (dx > dy ? dx : -dy) / 2, e2; 

  for(;;)
  {    
    ox = x0;
    oy = y0;

    if (x0 == x1 && y0 == y1)
      break;

    e2 = err;

    if (e2 > -dx)
    { 
      err -= dy; 
      x0 += sx; 
    }    

    if (e2 < dy)
    { 
      err += dx; 
      y0 += sy; 
    }

    ma = mb = 0;

    if (y0 < oy)
    { 
      mb = -1;
    }
    
    if (y0 > oy)
    {
      mb = 1;
    }
    
    if (x0 < ox)
    {  
      ma = -1;
    }
    
    if (x0 > ox)
    { 
      ma = 1;
    }
    
    moveSteppers(ma, mb);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////MOVE STEPPERS

void moveSteppers (int leftSteps, int rightSteps) 
{
  leftStepper.step(leftSteps);
  rightStepper.step(rightSteps);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////SET STEPPERS SPEED

void setSteppersSpeed (int steppersSpeed) 
{
  leftStepper.setSpeed(steppersSpeed);
  rightStepper.setSpeed(steppersSpeed);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////SET PEN POSITION

void setPenPosition (int penPosition)
{
  if (penPosition > oldPenPosition)
  {
    for (int i = oldPenPosition; i < penPosition; ++i)
    {
      penServo.write(i);
      delay(PEN_DAMPING_DELAY);
    }
  
    oldPenPosition = penPosition;
  }
  else if (penPosition < oldPenPosition)
  {
    for (int i = oldPenPosition; i > penPosition; --i)
    {
      penServo.write(i);
      delay(PEN_DAMPING_DELAY);
    }
  
    oldPenPosition = penPosition;
  }
}

