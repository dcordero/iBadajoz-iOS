//
//  BDJBusesLinesViewController.m
//  Badajoz
//
//  Created by David Cordero on 29/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJBusesLinesViewController.h"

#import "BDJBackgroundView.h"
#import "BDJTransporteWorker.h"
#import "BDJLines.h"
#import "BDJLinea.h"
#import "BDJParada.h"
#import "BDJLineViewCell.h"
#import "BDJNavigationController.h"
#import "BDJBusLineViewController.h"
#import "UIColor+BadajozColors.h"
#import "UIColor+Helper.h"

@interface BDJBusesLinesViewController ()

@property (strong, nonatomic) BDJTransporteWorker *transportWorker;
@property (strong, nonatomic) NSArray *lineas;

@end

@implementation BDJBusesLinesViewController

- (id)init
{
    self = [super init];
    if (self) {
        _transportWorker = [[BDJTransporteWorker alloc] init];
        _lineas = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTitle];
    [self configureNavigationBar];
    [self showBackgroundView];
    [self fetchLines];
}

#pragma mark - Private

- (void)setupTitle
{
    [self setTitle:NSLocalizedString(@"Tubasa", @"Title for Tubasa")];
}

- (void)configureNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu icon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(BDJNavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

- (void)showBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
}

- (void)fetchLines
{
    [self.transportWorker fetchAllLinesWithSuccessBlock:^(id resultData, BOOL cached) {
        BDJLines *lines = (BDJLines *)resultData;
        self.lineas = lines.lineas;
        
        [self.tableView reloadData];
    }
    errorBlock:^(NSError *error) {
         self.lineas = [[NSArray alloc] init];
         [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lineas count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teacherCell";
    BDJLineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[BDJLineViewCell alloc] init];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    BDJLinea *linea = [self.lineas objectAtIndex:indexPath.row];
    NSString *lineLabel = [NSString stringWithFormat:NSLocalizedString(@"Line %@", @"Label for lines in list of bus lines"), linea.label];

    [cell.lineLabel setText:lineLabel];
    [cell setIconColor:[UIColor colorWithHexString:linea.color]];
    
    [cell.lineDescription setText:[linea labelDescriptor]];
    [cell setBackgroundColor:[UIColor clearColor]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BDJLinea *linea = [self.lineas objectAtIndex:indexPath.row];

    BDJBusLineViewController *busLineViewController = [[BDJBusLineViewController alloc] initWithLine:(BDJLinea *)linea];
    [self.navigationController pushViewController:busLineViewController animated:YES];
}


@end
