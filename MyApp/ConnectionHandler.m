//
//  ConnectionHandler.m
//  MyApp
//
//  Created by mac_admin on 16/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import "ConnectionHandler.h"

@implementation ConnectionHandler


-(id)init{
    if ( self = [super init] ) {
        NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/746330/facts.json"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSData* mainData = [string dataUsingEncoding:NSUTF8StringEncoding];
        _jsonData = [NSJSONSerialization JSONObjectWithData:mainData options:NSJSONReadingAllowFragments error:nil];
        _dataArray = [_jsonData valueForKey:@"rows"];
        _titleHeader = [_jsonData valueForKey:@"title"];
        
        [self setDataToObject];
        return self;
    } else
        return nil;
}

-(void)setDataToObject
{
    _detailDataArray = [[NSMutableArray alloc]init];
    for(int i=0; i < _dataArray.count ; i++)
    {
        TableInfo *infoData = [[TableInfo alloc]init];
        
        NSDictionary *tempDict = [_dataArray objectAtIndex:i];
        [infoData setTitle:[tempDict objectForKey:@"title"]];
        [infoData setDescriptionDetail:[tempDict objectForKey:@"description"]];
        [infoData setImgUrl:[tempDict objectForKey:@"imageHref"]];
        [_detailDataArray addObject:infoData];
    }
}
@end
