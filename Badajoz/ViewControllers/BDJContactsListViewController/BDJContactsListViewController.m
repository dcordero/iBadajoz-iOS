//
//  BDJContactsListViewController.m
//  Badajoz
//
//  Created by David Cordero on 16/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJContactsListViewController.h"

#import "BDJDirectorio.h"
#import "BDJNavigationController.h"
#import "BDJDirectorioWorker.h"
#import "BDJContactCategory.h"
#import "BDJContact.h"
#import "WeakifyStrongify.h"
#import "BDJBackgroundView.h"
#import "UIColor+BadajozColors.h"
#import "BDJContactsListHeaderViewCell.h"
#import "BDJContactViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface BDJContactsListViewController ()

@property (strong, nonatomic) BDJDirectorioWorker *directorioWorker;
@property (strong, nonatomic) BDJDirectorio *directorio;
@property (nonatomic, strong) NSIndexPath *indexPathForSelectedRow;

@end

@implementation BDJContactsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _directorio = [[BDJDirectorio alloc] init];
        _directorioWorker = [[BDJDirectorioWorker alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupTitle];
    [self configureNavigationBar];
    [self showBackgroundView];
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

- (void)showBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
}

- (void)fetchData
{
    weakify(self);
    [self.directorioWorker fetchAllContactsWithSuccessBlock:^(id resultData, BOOL cached) {
        strongify(self);
        self.directorio = resultData;
        [self.tableView reloadData];

    } errorBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:NSLocalizedString(@"Error fetching contacts",
                                                                                        @"Error message. Error fetching contacts")]];
    }];
}

- (void)setupTitle
{
    [self setTitle:NSLocalizedString(@"Contacts", @"Title for Contacts")];
}

- (void)configureNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu icon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(BDJNavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDJContactCategory *contactCategory = [self.directorio.contactCategories objectAtIndex:indexPath.section];
    BDJContact *contact = [contactCategory.contacts objectAtIndex:indexPath.row];
    
    BDJContactViewController *contactViewController = [[BDJContactViewController alloc] initWithContact:contact];
    [self.navigationController pushViewController:contactViewController animated:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.directorio.contactCategories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.directorio.contactCategories objectAtIndex:section] contacts] count];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BDJContactCategory *contactCategory = [self.directorio.contactCategories objectAtIndex:section];
    BDJContactsListHeaderViewCell *headerCell = [[BDJContactsListHeaderViewCell alloc] init];
    headerCell.headerLabel.text = contactCategory.label;
    
    return headerCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teacherCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    BDJContactCategory *contactCategory = [self.directorio.contactCategories objectAtIndex:indexPath.section];
    BDJContact *contact = [contactCategory.contacts objectAtIndex:indexPath.row];

    cell.textLabel.text = contact.name;
    [cell.textLabel setFont: [UIFont fontWithName:@"Helvetica" size:18.0f]];
    [cell.textLabel setTextColor:[UIColor badajozTintColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}


@end
