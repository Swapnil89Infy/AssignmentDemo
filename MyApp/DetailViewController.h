//
//  DetailViewController.h
//  MyApp
//
//  Created by mac_admin on 13/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoCustomCell.h"
#import "TableInfo.h"
#import "ConnectionHandler.h"
#import "Constant.h"
#import "DetailsService.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DetailServiceProtocol>
{
    CGFloat *cellHeight;
    UIRefreshControl *refreshControl;
    UITableView *infoTable;
    ConnectionHandler *connectionHandler;
    UIActivityIndicatorView *loadingIndicator;
}

@end

