/* 
 * Wrapper to make I/O functions available with C linkage.
 * This allows C++ methods to be called from C code.
 *
 * Copyright 2014 The MathWorks, Inc. */
#include "rtwtypes.h"
// Initialize the touch sensor
void MW_USSensor_Init();
// Get the location on the sensor that is being touched as a
// percentage of the total length of the sensor
void MW_USSensor_Setup(uint8_T pin, boolean_T readInch);
float MW_Get_USSensor_Distance();
// Free the memory that was dynamically allocated
void MW_USSensor_Terminate();