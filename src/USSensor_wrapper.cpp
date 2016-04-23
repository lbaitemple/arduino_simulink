// #include "mbed.h"
#include <uss.h>
uss* USS;

extern "C" void MW_USSensor_Init() {
    USS = new uss();
}

extern "C" void  MW_USSensor_Setup(uint8_T pin, boolean_T readInch){
    USS->setParameter(pin, readInch);
}
extern "C" float MW_Get_USSensor_Distance() {
    USS->getDistance();
    return USS->distance;
}


extern "C" void MW_USSensor_Terminate() {
    delete USS;
}
