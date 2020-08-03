#include <Servo.h>
#define pin_servo 8
Servo myservo;  // create servo object to control a servo
int angle=180;    // variable to read the value from the analog pin
void setup() {
  myservo.attach(pin_servo);  // attaches the servo on pin 9 to the servo object
}

void loop() {
 myservo.write(angle);
 }
