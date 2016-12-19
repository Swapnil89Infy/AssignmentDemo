//
//  ConnectionHandler.h
//  MyApp
//
//  Created by mac_admin on 16/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableInfo.h"
#import "DetailsService.h"
#import "ServiceLayerProtocol.h"

@interface ConnectionHandler : NSObject

+ (void)makeConnection:(NSURLRequest *)request callingService:(id)service;

@end
