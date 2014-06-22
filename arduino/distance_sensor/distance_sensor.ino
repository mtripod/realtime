int trigPin = 2;    
int echoPin = 3;     
int ledGreenPin = 4;  
int ledRedPin = 5;

int maximumRange = 20; // Maximum range needed
int minimumRange = 0; // Minimum range needed
long duration, distance; // Duration used to calculate distance

void setup() {
 pinMode(trigPin, OUTPUT);
 pinMode(echoPin, INPUT);
 pinMode(ledGreenPin, OUTPUT);
 pinMode(ledRedPin, OUTPUT);
}

void loop() {
 /* The following trigPin/echoPin cycle is used to determine the
 distance of the nearest object by bouncing soundwaves off of it. */ 
 digitalWrite(trigPin, LOW); 
 delayMicroseconds(2); 

 digitalWrite(trigPin, HIGH);
 delayMicroseconds(10); 
 
 digitalWrite(trigPin, LOW);
 duration = pulseIn(echoPin, HIGH);
 
 //Calculate the distance (in cm) based on the speed of sound.
 distance = duration/58.2;
 
 if (distance >= maximumRange)
 {
   /* Send a negative number to computer and Turn LED ON 
   to indicate "out of range" */
   Serial.println("-1");
   digitalWrite(ledRedPin, HIGH); 
   digitalWrite(ledGreenPin, LOW); 
 }
 else 
 {
   /* Send the distance to the computer using Serial protocol, and
   turn LED OFF to indicate successful reading. */
   Serial.println(distance);
   digitalWrite(ledRedPin, LOW); 
   digitalWrite(ledGreenPin, HIGH);
 }
 
 //Delay 50ms before next reading.
 delay(50);   
}
