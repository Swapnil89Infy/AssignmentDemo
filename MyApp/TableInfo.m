//
//  MyData.m
//  MyApp
//
//  Created by mac_admin on 15/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import "TableInfo.h"

@implementation TableInfo

@synthesize title;
@synthesize descriptionDetail;
@synthesize imgUrl;

-(id) init
{
    title=@"";
    descriptionDetail=@"";
    imgUrl = @"";
    return self;
}

-(id) setData:(NSDictionary *)infoDict
{
    [self setTitle:[infoDict objectForKey:@"title"]];
    [self setDescriptionDetail:[infoDict objectForKey:@"description"]];
    [self setImgUrl:[infoDict objectForKey:@"imageHref"]];
    return self;
}
@end
