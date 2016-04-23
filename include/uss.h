// 
//    FILE: dht.h
// VERSION: 0.1.00
// PURPOSE: DHT Temperature & Humidity Sensor library for Arduino
//
//     URL: http://arduino.cc/playground/Main/DHTLib
//
// HISTORY:
// see dht.cpp file
// 

#ifndef dht_h
#define dht_h

#if ARDUINO >= 100
 #include "Arduino.h"
#else
 #include "WProgram.h"
#endif
#include "rtwtypes.h"
#define DHT_LIB_VERSION "0.1.00"

class uss
{
public:
	void setParameter(uint8_t pin, boolean_T readInch);
    void getDistance();
	float distance;
    boolean_T readInch;
    uint8_t pin;

private:
	int read();
    long microsecondsToCentimeters(long microseconds);
    long microsecondsToInches(long microseconds);
};
#endif
//
// END OF FILE
//
