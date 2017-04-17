//
//  BDJNewsListViewController.m
//  Badajoz
//
//  Created by David Cordero on 08/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJNewsListViewController.h"

#import "BDJFeedChannel.h"
#import "BDJRSSItem.h"
#import "BDJFeedWorker.h"
#import "WeakifyStrongify.h"
#import "BDJNewsListViewCell.h"
#import "BDJPieceOfNewsViewController.h"
#import "NSString+HTML.h"
#import "NSString+HTML.h"
#import "DLog.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "DTAlertView.h"

static NSString *const kCellConnectedCellReuseIdentifier = @"kCellConnectedCellReuseIdentifier";

@interface BDJNewsListViewController ()

@property (strong, nonatomic)BDJFeedWorker *feedWorker;
@property (strong, nonatomic)BDJFeedChannel *feedChannel;
@property (nonatomic, strong) NSIndexPath *indexPathForSelectedRow;
@property (strong, nonatomic)UIRefreshControl *refreshControl;

@property (nonatomic, copy) void (^fetchFeedDidSucceedBlock)(id resultData, BOOL cached);
@property (nonatomic, copy) void (^fetchFeedDidFail)(NSError *error);

@end

@implementation BDJNewsListViewController

- (id)initWithFeed:(BDJNewsFeed)feed
{
    self = [super init];
    if (self) {
        _feed = feed;
        _feedWorker = [[BDJFeedWorker alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self defineWorkerBlocks];
    [self setupRefreshControl];
    [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.indexPathForSelectedRow = [self.tableView indexPathForSelectedRow];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.indexPathForSelectedRow animated:YES];
}

#pragma mark - Private

- (void)setupRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)openInSafari:(BDJRSSItem *)rssItem
{
    DTAlertViewButtonClickedBlock block = ^(DTAlertView *_alertView, NSUInteger buttonIndex, NSUInteger cancelButtonIndex){
        if (buttonIndex == 1) {
            NSURL *url = [ [ NSURL alloc ] initWithString:rssItem.link ];
            [[UIApplication sharedApplication] openURL:url];
        }
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    };
    
    DTAlertView *alertView = [DTAlertView alertViewUseBlock:block
                                                      title:NSLocalizedString(@"Jobs", @"Title in popup to open rss item in safari")
                                                    message:NSLocalizedString(@"This article has no description, do you want to open it using Safari?", @"Question in popup to open rss item in safari")
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel button in popup to open rss item in safari")
                                        positiveButtonTitle:NSLocalizedString(@"Sure", @"OK button in popup to open rss item in safari")];
    [alertView showWithAnimation:DTAlertViewAnimationSlideRight];
}

- (void)fetchData
{
    switch (self.feed) {
        case BDJNewsFeedFlash:
            [self.feedWorker fetchFlashNewsWithSuccessBlock:self.fetchFeedDidSucceedBlock errorBlock:self.fetchFeedDidFail];
            break;
        case BDJNewsFeedSpecials:
            [self.feedWorker fetchSpecialsNewsWithSuccessBlock:self.fetchFeedDidSucceedBlock errorBlock:self.fetchFeedDidFail];
            break;
        case BDJNewsFeedJobs:
            [self.feedWorker fetchJobsNewsWithSuccessBlock:self.fetchFeedDidSucceedBlock errorBlock:self.fetchFeedDidFail];
            break;
    }
}


- (void)defineWorkerBlocks
{
    weakify(self);
    self.fetchFeedDidSucceedBlock = ^void (id resultData, BOOL cached) {
        strongify(self);
        
        self.feedChannel = resultData;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    };
    
    self.fetchFeedDidFail = ^void (NSError *error) {
        strongify(self);

        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:NSLocalizedString(@"Error fetching the news",
                                                                                        @"Error message. Error fetching news")]];
        [self.refreshControl endRefreshing];
    };
}

- (BDJRSSItem *)rssItemForRow:(NSInteger)row {
    return [self.feedChannel.rssItems objectAtIndex:row];
}

- (NSInteger)sizeOfText:(NSString *)text withFont:(UIFont *)font{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(304, 150)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    return  MAX(rect.size.height, 30);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    BDJRSSItem *rssItem = [self rssItemForRow:indexPath.row];
    CGFloat titleLabelHeight = [self sizeOfText:rssItem.title withFont:[UIFont fontWithName:@"Helvetica" size:17.0]];
    CGFloat bodyLabelHeight = [self sizeOfText:[rssItem.description stringByConvertingHTMLToPlainText] withFont:[UIFont fontWithName:@"Helvetica" size:12.0]]
    ;
    NSInteger padding = 30;

    return bodyLabelHeight + padding + titleLabelHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDJRSSItem *rssItem = [self.feedChannel.rssItems objectAtIndex:indexPath.row];
 
    if (![[rssItem.descriptionText stringByConvertingHTMLToPlainText] isEqualToString:@""]) {
        BDJPieceOfNewsViewController *pieceOfNewsViewController = [[BDJPieceOfNewsViewController alloc] initWithRSSItem:rssItem];
        [self.navigationController pushViewController:pieceOfNewsViewController animated:YES];
    }
    else {
        [self openInSafari:rssItem];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.feedChannel.rssItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teacherCell";
    BDJNewsListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[BDJNewsListViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    BDJRSSItem *rssItem = [self.feedChannel.rssItems objectAtIndex:indexPath.row];
    if (rssItem) {
        cell.titleLabel.text = rssItem.title;
        cell.descriptionLabel.text = [rssItem.descriptionText stringByConvertingHTMLToPlainText];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"· dd/MM/yyyy hh:mm"];

        cell.dateLabel.text = [dateFormat stringFromDate:rssItem.date];
    }
    else {
        DLog(@"Error getting rssItem");
    }
    
    return cell;
}


@end
