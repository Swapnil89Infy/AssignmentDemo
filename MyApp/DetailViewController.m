//
//  ViewController.m
//  MyApp
//
//  Created by mac_admin on 13/12/16.
//  Copyright © 2016 mac_admin. All rights reserved.
//

#import "DetailViewController.h"
#import "Utility.h"


@interface DetailViewController ()

@property(nonatomic, strong)NSArray *detailArray;
@property(nonatomic, strong)NSString *titleHeader;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![Utility connectedToNetwork])
    {
        UIAlertView *statusUpdatedAlert = [[UIAlertView alloc] initWithTitle:@"No Network Connection" message:@"No network connection. Please try connecting to the Internet." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [statusUpdatedAlert show];
        statusUpdatedAlert = nil;
    }
    else {
        loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        loadingIndicator.center = self.view.center;
        
        [self.view addSubview:loadingIndicator];
        [loadingIndicator startAnimating];
        
        DetailsService *detailService = [DetailsService new];
        [detailService fetch:nil];
        [detailService setDelegate:self];
    }
    
}


- (void)detailResultHandler:(NSArray *)detailInfo :(NSString *)titleHeader
{
    [loadingIndicator stopAnimating];
    _titleHeader = titleHeader;
    _detailArray = detailInfo;
    dispatch_async(dispatch_get_main_queue(),^{
        [self setUI];
    });
}

- (void)onError:(NSError *)error
{
    UIAlertView *statusUpdatedAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Some Thing Wrong Happend" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [statusUpdatedAlert show];
    statusUpdatedAlert = nil;

}


-(void)setUI
{
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, NavigationBar_Height)];
    UINavigationItem *navItem = [UINavigationItem alloc];
    navItem.title = _titleHeader;
    [navbar pushNavigationItem:navItem animated:false];
    [self.view addSubview:navbar];
    
    infoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBar_Height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50)];
    infoTable.delegate =self;
    infoTable.dataSource = self;
    [infoTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:infoTable];

    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar_Height, 0, 0)];
    [infoTable insertSubview:refreshView atIndex:0];
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(reloadDatas) forControlEvents:UIControlEventValueChanged];
    NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Pull To Refresh"];
    [refreshString addAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} range:NSMakeRange(0, refreshString.length)];
    refreshControl.attributedTitle = refreshString;
    [refreshView addSubview:refreshControl];
}

-(void)reloadDatas
{
    if (![Utility connectedToNetwork])
    {
        UIAlertView *statusUpdatedAlert = [[UIAlertView alloc] initWithTitle:@"No Network Connection" message:@"No network connection. Please try connecting to the Internet." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [statusUpdatedAlert show];
        statusUpdatedAlert = nil;
    }
    else
    {
        DetailsService *detailService = [DetailsService new];
        [detailService fetch:nil];
        [detailService setDelegate:self];
        [refreshControl endRefreshing];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _detailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoCustomCell *cell;
    static NSString *CellIdentifier = @"Cell";
    
    cell = (InfoCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[InfoCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor grayColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];
    
    TableInfo *dataObject = [_detailArray objectAtIndex:indexPath.row];

    NSString *urlString = [[NSString alloc]initWithFormat:@"%@",dataObject.imgUrl];
    NSString *title = [[NSString alloc]initWithFormat:@"%@",dataObject.title];
    NSString *description = [[NSString alloc]initWithFormat:@"%@",dataObject.descriptionDetail];
    cell.thumbNailImage.image = [UIImage imageNamed:@"defaultImages"];
    [cell.spinner startAnimating];
    [cell setThumbnailUrlString:urlString];
    cell.title.text = title;
    cell.descriptionDetail.text = description;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize constraint = CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, CGFLOAT_MAX);
    CGSize size;
    
    TableInfo *dataObject = [_detailArray objectAtIndex:indexPath.row];
    NSString *description = [[NSString alloc]initWithFormat:@"%@",dataObject.descriptionDetail];

    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [description boundingRectWithSize:constraint
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:DescriptionFont}
                                                   context:context].size;
    
    size = CGSizeMake((boundingBox.width), (boundingBox.height));
    if(size.height > MaxHeight)
        return size.height + CellPadding;
    else
        return DefaultCell_Height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
