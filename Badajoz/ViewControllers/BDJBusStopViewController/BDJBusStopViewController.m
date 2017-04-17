//
//  BDJBusStopViewController.m
//  Badajoz
//
//  Created by David Cordero on 28/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJBusStopViewController.h"
#import "BDJTransporteWorker.h"
#import "BDJBackgroundView.h"
#import "BDJBusStopHeaderViewCell.h"
#import "BDJCustomHeaderGroupViewCell.h"
#import "DTAlertView.h"
#import "BDJStopInfo.h"
#import "UIColor+Helper.h"

@interface BDJBusStopViewController ()
@property (strong, nonatomic)BDJTransporteWorker *transportWorker;

@property (strong, nonatomic)BDJParada *parada;
@property (strong, nonatomic)BDJLinea *linea;

@property (strong, nonatomic)BDJStopInfo *stopInfo;
@end

@implementation BDJBusStopViewController

- (id)initWithParada:(BDJParada *)parada inLine:(BDJLinea *)linea
{
    self = [super init];
    if (self) {
        _transportWorker = [[BDJTransporteWorker alloc] init];
        _parada = parada;
        _linea = linea;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showBackgroundView];
    [self fetchStopInfo];
}

#pragma mark - Private

- (void)showBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.stopInfo.connections count] > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    
    return [self.stopInfo.connections count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        BDJBusStopHeaderViewCell *headerViewCell = [[BDJBusStopHeaderViewCell alloc] init];
        headerViewCell.busStopName.text = self.parada.label;
        headerViewCell.busStopDescriptor.text = [self.linea labelDescriptor];
        [headerViewCell setBusStopColor:[UIColor colorWithHexString:self.linea.color]];
        
        return headerViewCell;
    }
    else {
        BDJCustomHeaderGroupViewCell *headerViewCell = [[BDJCustomHeaderGroupViewCell alloc] init];
        headerViewCell.changeHereLabel.text = NSLocalizedString(@"Change here for",
                                                                @"Change here label in stop viewer");
        return headerViewCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex ==0) {
        return 70;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([self.stopInfo nextStop]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        if (indexPath.section == 0) {
            cell.textLabel.text = NSLocalizedString(@"Next stop",
                                                    @"Next stop label in stop viewer");
            cell.detailTextLabel.text = [self.stopInfo nextStop];
        }
        else {
            BDJStopInfo *stopInfo = [self.stopInfo.connections objectAtIndex:indexPath.row];
            cell.textLabel.text = stopInfo.name;
            cell.detailTextLabel.text = stopInfo.nextStop;
        }
    }
    else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = NSLocalizedString(@"Loading information...",
                                                @"Loading information in stop viewer");
    }
    
    return cell;
}

#pragma mark - Private

- (void)fetchStopInfo
{
    [self.transportWorker fetchStopInfoForParada:self.parada andLine:self.linea withSuccessBlock:^(id resultData, BOOL cached) {
        self.stopInfo = (BDJStopInfo *)resultData;
        
        [self.tableView reloadData];
    }
    errorBlock:^(NSError *error) {
                                          
    }];
}
@end
