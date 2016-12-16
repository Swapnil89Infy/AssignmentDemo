//
//  MyAppTableViewCell.h
//  MyApp
//
//  Created by mac_admin on 14/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface InfoCustomCell : UITableViewCell

@property(nonatomic, retain)UILabel *title;
@property(nonatomic, retain)UILabel *descriptionDetail;
@property(nonatomic, retain)UIImageView *thumbNailImage;
@property(nonatomic, strong)NSString *thumbnailUrlString;
@property(nonatomic, strong)UIActivityIndicatorView *spinner;
-(void)setThumbnailUrlString:(NSString *)urlString;

@end
