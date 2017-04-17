//
//  BDJBusLineViewController.m
//  Badajoz
//
//  Created by David Cordero on 23/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJBusLineViewController.h"
#import "BDJBackgroundView.h"
#import "BDJContactsListHeaderViewCell.h"
#import "BDJParada.h"
#import "BDJParadaViewCell.h"
#import "BDJTransporteWorker.h"
#import "DTAlertView.h"
#import "BDJBusStopViewController.h"
#import "UIColor+Helper.h"

@interface BDJBusLineViewController ()
@property (strong, nonatomic)BDJLinea *linea;
@end

@implementation BDJBusLineViewController

- (id)initWithLine:(BDJLinea *)linea
{
    self = [super init];
    if (self) {
        _linea = linea;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showBackgroundView];
}

#pragma mark - Private

- (void)showBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.linea.paradasIda count];
            break;
        case 1:
            return [self.linea.paradasVuelta count];
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BDJContactsListHeaderViewCell *headerCell = [[BDJContactsListHeaderViewCell alloc] init];
    if (section == 0) {
        headerCell.headerLabel.text = @"Ida";
    }
    else {
        headerCell.headerLabel.text = @"Vuelta";
    }
    return headerCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teacherCell";
    BDJParadaViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[BDJParadaViewCell alloc] init];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    BDJParada *parada;
    if (indexPath.section == 0) {
        parada = [[self.linea paradasIda] objectAtIndex:indexPath.row];
        [cell.previousConnection setHidden:(indexPath.row == 0) ? YES : NO];
    }
    else {
        parada = [[self.linea paradasVuelta] objectAtIndex:indexPath.row];
        [cell.nextConnection setHidden:(indexPath.row == self.linea.paradasVuelta.count-1) ? YES : NO];
    }
    
    [cell.paradaLabel setText:parada.label];
    [cell setIconColor:[UIColor colorWithHexString:self.linea.color]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDJParada *parada;
    if (indexPath.section == 0) {
        parada = [[self.linea paradasIda] objectAtIndex:indexPath.row];
    }
    else {
        parada = [[self.linea paradasVuelta] objectAtIndex:indexPath.row];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
     
    BDJBusStopViewController *stopViewController = [[BDJBusStopViewController alloc] initWithParada:parada inLine:self.linea];
    [self.navigationController pushViewController:stopViewController animated:YES];
}

@end
