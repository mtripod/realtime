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
@property (nonatomic) CBPeripheral     *activePeripheral;
@property (nonatomic) BOOL connected;
@end

@implementation Bluetooth

-(void)connect:(Success)success failure:(Failure)failure
{

    // Scan for all available CoreBluetooth LE devices
	NSArray *services = @[[CBUUID UUIDWithString:RBL_SERVICE_UUID], [CBUUID UUIDWithString:RBL_CHAR_TX_UUID], [CBUUID UUIDWithString:RBL_CHAR_RX_UUID]];
	CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
	[centralManager scanForPeripheralsWithServices:services options:nil];
	self.centralManager = centralManager;
    
    success(success);
}

-(void)disconnect:(Success)success failure:(Failure)failure
{
    success(success);
}

-(BOOL)isConnected
{
    return self.connected;
}

-(NSDictionary*)status
{
    return nil;
}


-(void)send:(NSDictionary*)data
    success:(Success)success
    failure:(Failure)failure
{
    success(success);
}

-(void)receive:(NSDictionary*)data
       success:(Success)success
       failure:(Failure)failure
{
    success(success);
}



#pragma mark - Helpers Bluethooth
-(void) read
{
    CBUUID *uuid_service = [CBUUID UUIDWithString:RBL_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:RBL_CHAR_TX_UUID];
    
    [self readValue:uuid_service characteristicUUID:uuid_char peripheral:self.activePeripheral];
}

-(void) write:(NSData *)d
{
    CBUUID *uuid_service = [CBUUID UUIDWithString:RBL_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:RBL_CHAR_RX_UUID];
    
    [self writeValue:uuid_service characteristicUUID:uuid_char peripheral:self.activePeripheral data:d];
}

-(void) enableReadNotification:(CBPeripheral *)peripheral
{
    CBUUID *uuid_service = [CBUUID UUIDWithString:RBL_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:RBL_CHAR_TX_UUID];
    
    [self notification:uuid_service characteristicUUID:uuid_char peripheral:peripheral on:YES];
}



-(void) notification:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral on:(BOOL)on
{
    CBService *service = [self findServiceFromUUID:serviceUUID peripheral:peripheral];
    
    if (!service)
    {
        NSLog(@"Could not find service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:serviceUUID],
              peripheral.identifier.UUIDString);
        
        return;
    }
    
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:characteristicUUID service:service];
    
    if (!characteristic)
    {
        NSLog(@"Could not find characteristic with UUID %@ on service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:characteristicUUID],
              [self CBUUIDToString:serviceUUID],
              peripheral.identifier.UUIDString);
        
        return;
    }
    
    [peripheral setNotifyValue:on forCharacteristic:characteristic];
}

-(void) readValue: (CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral
{
    CBService *service = [self findServiceFromUUID:serviceUUID peripheral:peripheral];
    
    if (!service)
    {
        NSLog(@"Could not find service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:serviceUUID],
              peripheral.identifier.UUIDString);
        
        return;
    }
    
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:characteristicUUID service:service];
    
    if (!characteristic)
    {
        NSLog(@"Could not find characteristic with UUID %@ on service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:characteristicUUID],
              [self CBUUIDToString:serviceUUID],
              peripheral.identifier.UUIDString);
        
        return;
    }
    
    [peripheral readValueForCharacteristic:characteristic];
}

-(void) writeValue:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral data:(NSData *)data
{
    CBService *service = [self findServiceFromUUID:serviceUUID peripheral:peripheral];
    
    if (!service)
    {
        NSLog(@"Could not find service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:serviceUUID],
              peripheral.identifier.UUIDString);
        
        return;
    }
    
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:characteristicUUID service:service];
    
    if (!characteristic)
    {
        NSLog(@"Could not find characteristic with UUID %@ on service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:characteristicUUID],
              [self CBUUIDToString:serviceUUID],
              peripheral.identifier.UUIDString);
        
        return;
    }
    
    [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
}


-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service
{
    for(int i=0; i < service.characteristics.count; i++)
    {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    
    return nil; //Characteristic not found on this service
}

-(CBService *) findServiceFromUUID:(CBUUID *)UUID peripheral:(CBPeripheral *)peripheral
{
    for(int i = 0; i < peripheral.services.count; i++)
    {
        CBService *s = [peripheral.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID])
            return s;
    }
    
    return nil; //Service not found on this peripheral
}

-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2
{
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    
    if (memcmp(b1, b2, UUID1.data.length) == 0)
        return 1;
    else
        return 0;
}

-(int) compareCBUUIDToInt:(CBUUID *)UUID1 UUID2:(UInt16)UUID2
{
    char b1[16];
    
    [UUID1.data getBytes:b1];
    UInt16 b2 = [self swap:UUID2];
    
    if (memcmp(b1, (char *)&b2, 2) == 0)
        return 1;
    else
        return 0;
}

-(NSString *) CBUUIDToString:(CBUUID *) cbuuid;
{
    NSData *data = cbuuid.data;
    
    if ([data length] == 2)
    {
        const unsigned char *tokenBytes = [data bytes];
        return [NSString stringWithFormat:@"%02x%02x", tokenBytes[0], tokenBytes[1]];
    }
    else if ([data length] == 16)
    {
        NSUUID* nsuuid = [[NSUUID alloc] initWithUUIDBytes:[data bytes]];
        return [nsuuid UUIDString];
    }
    
    return [cbuuid description];
}

-(UInt16) swap:(UInt16)s
{
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
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
    if (!error)
    {
        for (CBService *service in peripheral.services)
        {
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
	
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
	NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
	if (![localName isEqual:@""])
    {
		// We found the Heart Rate Monitor
		[self.centralManager stopScan];
		self.activePeripheral = peripheral;
		peripheral.delegate = self;
		[self.centralManager connectPeripheral:peripheral options:nil];
	}
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (!error)
    {
        for (CBService *s in service.characteristics)
        {
            if ([service.UUID isEqual:s.UUID])
            {
                [self enableReadNotification:self.activePeripheral];
                [[self delegate] communicationDidConnect];
                _connected = true;
                
                break;
            }
        }
    }
    else
    {
        NSLog(@"Characteristic discorvery unsuccessful!");
    }

}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    unsigned char data[20];
    
    static unsigned char buf[512];
    static int len = 0;
    NSInteger data_len;
    
    if (!error)
    {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:RBL_CHAR_TX_UUID]])
        {
            data_len = characteristic.value.length;
            [characteristic.value getBytes:data length:data_len];
            
            if (data_len == 20)
            {
                memcpy(&buf[len], data, 20);
                len += data_len;
                
                if (len >= 64)
                {
                    [[self delegate] communicationDidReceiveData:buf length:len];
                    len = 0;
                }
            }
            else if (data_len < 20)
            {
                memcpy(&buf[len], data, data_len);
                len += data_len;
                
                [[self delegate] communicationDidReceiveData:buf length:len];
                len = 0;
            }
        }
    }
    else
    {
        NSLog(@"updateValueForCharacteristic failed!");
    }
    
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
{
    [[self delegate] communicationDidDisconnect];
    _connected = false;
}


@end
