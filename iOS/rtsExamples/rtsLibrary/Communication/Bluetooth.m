//
//  Bluetooth.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "Bluetooth.h"

@interface Bluetooth ()

@property (nonatomic) CBCentralManager *centralManager;
@property (nonatomic) CBPeripheral     *polarH7HRMPeripheral;
@property (nonatomic) BOOL connected;
@end

@implementation Bluetooth

-(void)connect:(Success)success failure:(Failure)failure
{

    // Scan for all available CoreBluetooth LE devices
	NSArray *services = @[[CBUUID UUIDWithString:POLARH7_HRM_HEART_RATE_SERVICE_UUID], [CBUUID UUIDWithString:POLARH7_HRM_DEVICE_INFO_SERVICE_UUID]];
	CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
	[centralManager scanForPeripheralsWithServices:services options:nil];
	self.centralManager = centralManager;
    

}

-(void)disconnect:(Success)success failure:(Failure)failure
{

}

-(BOOL)isConnected
{
    return self.connected;
}

-(NSDictionary*)status
{
    return nil;
}


#pragma mark - Bluethooth 


// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
	// Determine the state of the peripheral
	if ([central state] == CBCentralManagerStatePoweredOff) {
		NSLog(@"CoreBluetooth BLE hardware is powered off");
	}
	else if ([central state] == CBCentralManagerStatePoweredOn) {
		NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
	}
	else if ([central state] == CBCentralManagerStateUnauthorized) {
		NSLog(@"CoreBluetooth BLE state is unauthorized");
	}
	else if ([central state] == CBCentralManagerStateUnknown) {
		NSLog(@"CoreBluetooth BLE state is unknown");
	}
	else if ([central state] == CBCentralManagerStateUnsupported) {
		NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
	}
}

// method called whenever we have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
	[peripheral setDelegate:self];
    [peripheral discoverServices:nil];
	self.connected = (peripheral.state == CBPeripheralStateConnected);
}

// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
	for (CBService *service in peripheral.services) {
		[peripheral discoverCharacteristics:nil forService:service];
	}
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
	NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
	if (![localName isEqual:@""]) {
		// We found the Heart Rate Monitor
		[self.centralManager stopScan];
		self.polarH7HRMPeripheral = peripheral;
		peripheral.delegate = self;
		[self.centralManager connectPeripheral:peripheral options:nil];
	}
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
	if ([service.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_HEART_RATE_SERVICE_UUID]])
    {  // 1
		for (CBCharacteristic *aChar in service.characteristics)
		{
			// Request heart rate notifications
			if ([aChar.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_NOTIFICATIONS_SERVICE_UUID]])
            { // 2
				[self.polarH7HRMPeripheral setNotifyValue:YES forCharacteristic:aChar];
			}
			// Request body sensor location
			else if ([aChar.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_BODY_LOCATION_UUID]])
            { // 3
				[self.polarH7HRMPeripheral readValueForCharacteristic:aChar];
			}
            //			else if ([aChar.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_ENABLE_SERVICE_UUID]]) { // 4
            //				// Read the value of the heart rate sensor
            //				UInt8 value = 0x01;
            //				NSData *data = [NSData dataWithBytes:&value length:sizeof(value)];
            //				[peripheral writeValue:data forCharacteristic:aChar type:CBCharacteristicWriteWithResponse];
            //			}
		}
	}
	// Retrieve Device Information Services for the Manufacturer Name
	if ([service.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_DEVICE_INFO_SERVICE_UUID]])
    { // 5
        for (CBCharacteristic *aChar in service.characteristics)
        {
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_MANUFACTURER_NAME_UUID]])
            {
                [self.polarH7HRMPeripheral readValueForCharacteristic:aChar];
                NSLog(@"Found a Device Manufacturer Name Characteristic");
            }
        }
	}
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
	// Updated value for heart rate measurement received
	if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_NOTIFICATIONS_SERVICE_UUID]])
    { // 1
		// Get the Heart Rate Monitor BPM
		//[self getHeartBPMData:characteristic error:error];
	}
	// Retrieve the characteristic value for manufacturer name received
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_MANUFACTURER_NAME_UUID]])
    {  // 2
		//[self getManufacturerName:characteristic];
    }
	// Retrieve the characteristic value for the body sensor location received
	else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:POLARH7_HRM_BODY_LOCATION_UUID]])
    {  // 3
		//[self getBodyLocation:characteristic];
    }
	
	// Add our constructed device information to our UITextView
	//self.deviceInfo.text = [NSString stringWithFormat:@"%@\n%@\n%@\n", self.connected, self.bodyData, self.manufacturer];  // 4
}

@end
