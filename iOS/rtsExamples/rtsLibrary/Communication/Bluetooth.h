//
//  Bluetooth.h
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "Communication.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define POLARH7_HRM_DEVICE_INFO_SERVICE_UUID @"180A"       // 180A = Device Information
#define POLARH7_HRM_HEART_RATE_SERVICE_UUID @"180D"        // 180D = Heart Rate Service
#define POLARH7_HRM_ENABLE_SERVICE_UUID @"2A39"
#define POLARH7_HRM_NOTIFICATIONS_SERVICE_UUID @"2A37"
#define POLARH7_HRM_BODY_LOCATION_UUID @"2A38"
#define POLARH7_HRM_MANUFACTURER_NAME_UUID @"2A29"


// RBL Service
#define RBL_SERVICE_UUID                         @"713D0000-503E-4C75-BA94-3148F18D941E"
#define RBL_CHAR_TX_UUID                         @"713D0002-503E-4C75-BA94-3148F18D941E"
#define RBL_CHAR_RX_UUID                         @"713D0003-503E-4C75-BA94-3148F18D941E"


@interface Bluetooth : Communication <CBCentralManagerDelegate, CBPeripheralDelegate>

@end
