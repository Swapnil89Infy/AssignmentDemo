//
//  AppDelegate.h
//  MyApp
//
//  Created by mac_admin on 13/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) DetailViewController *viewController;

- (void)saveContext;


@end

