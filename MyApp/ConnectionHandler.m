//
//  ConnectionHandler.m
//  MyApp
//
//  Created by mac_admin on 16/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import "ConnectionHandler.h"

@implementation ConnectionHandler

+ (void)makeConnection:(NSURLRequest *)aRequest callingService:(id)aService
{
    NSLog(@"REQUEST WEB SERVICE URL : %@", aRequest.URL.absoluteString);
    NSLog(@"REQUEST JSON : %@", [[NSString alloc] initWithData:aRequest.HTTPBody encoding:NSASCIIStringEncoding]);
    
    NSURLSession *tSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *tPostRequestTask = [tSession dataTaskWithRequest:aRequest
                                                         completionHandler:^(NSData *tData, NSURLResponse *tResponse, NSError *tError) {
                                                             
                                                             if(tError == nil) {
                                                                 if([aService conformsToProtocol:@protocol(ServiceLayerProtocol)]) {
                                                                     [aService onDataReceived:tData];
                                                                 }
                                                                 [tSession finishTasksAndInvalidate];
                                                             }
                                                             else {
                                                                 if([aService conformsToProtocol:@protocol(ServiceLayerProtocol)]) {
                                                                     [aService onError:tError];
                                                                 }
                                                                 [tSession finishTasksAndInvalidate];
                                                             }
                                                             
                                                         }];
    [tPostRequestTask resume];
}
@end
