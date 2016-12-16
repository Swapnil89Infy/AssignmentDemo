//
//  ConnectionHandler.h
//  MyApp
//
//  Created by mac_admin on 16/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableInfo.h"

@interface ConnectionHandler : NSObject<NSURLSessionDelegate>

@property(nonatomic, strong)NSDictionary *jsonData;
@property(nonatomic, strong)NSArray *dataArray;
@property(nonatomic, strong)NSMutableArray *detailDataArray;
@property(nonatomic, strong)NSString *titleHeader;

@end
