//
//  ServiceLayerProtocol.h
//  MyApp
//
//  Created by mac_admin on 13/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceLayerProtocol <NSObject>

- (void)fetch:(NSDictionary*)aRequestDictionary;
- (void)onDataReceived:(NSData *)aResponseData;
- (void)onError:(NSError *)error;

@end
