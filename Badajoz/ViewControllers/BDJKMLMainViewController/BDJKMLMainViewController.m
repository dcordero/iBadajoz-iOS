//
//  BDJKMLMainViewController.m
//  Badajoz
//
//  Created by David Cordero on 18/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJKMLMainViewController.h"
#import "BDJKMLMapViewController.h"
#import "BDJKMLListViewController.h"
#import "BDJTransporteWorker.h"
#import "KML.h"
#import "KML+MapKit.h"
#import "WeakifyStrongify.h"
#import "BDJSwipeViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface BDJKMLMainViewController ()

@property (strong, nonatomic)BDJTransporteWorker *transporteWorker;

@property (nonatomic) KMLSource source;
@property (nonatomic) KMLRoot *kml;
@property (nonatomic) NSArray *geometries;

@property (nonatomic, copy) void (^fetchMapDidSucceedBlock)(id resultData, BOOL cached);
@property (nonatomic, copy) void (^fetchMapDidFail)(NSError *error);

@end

@implementation BDJKMLMainViewController

- (id)initWithSource:(KMLSource)source
{
    self = [super init];
    if (self) {
        _source = source;
        _transporteWorker = [[BDJTransporteWorker alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self defineWorkerBlocks];
    [self loadMap];
}

- (void)setupTitle
{
    if (self.source == BIBA) {
        [self setTitle:NSLocalizedString(@"BiBa", @"Title for BiBa")];
    }
    else {
        [self setTitle:NSLocalizedString(@"Handicapted Parking", @"Title for Handicapted Parking")];
    }
}

- (NSArray *)toolbarElements
{
    return @[ NSLocalizedString(@"Map", @"Title for map segment in kml toolbar"),
              NSLocalizedString(@"List", @"Title for list segment in kml toolbar")];
}

- (NSArray *)swipeViewControllers
{
    return @[
             [[BDJKMLMapViewController alloc] init],
             [[BDJKMLListViewController alloc] init],
             ];
}

#pragma mark - Private

- (void)loadMap
{
    if (self.source == BIBA) {
        [self.transporteWorker fetchBiBaMapWithSuccessBlock:self.fetchMapDidSucceedBlock errorBlock:self.fetchMapDidFail];
    }
    else if (self.source == HANDICAPTED) {
        [self.transporteWorker fetchHandicaptedMapWithSuccessBlock:self.fetchMapDidSucceedBlock errorBlock:self.fetchMapDidFail];
    }
}

- (void)defineWorkerBlocks
{
    BDJKMLMapViewController *mapViewController = [self.newsSwipeViewController.contentViewControllers objectAtIndex:0];
    BDJKMLListViewController *listViewController = [self.newsSwipeViewController.contentViewControllers objectAtIndex:1];
    
    weakify(self);
    self.fetchMapDidSucceedBlock = ^void (id resultData, BOOL cached) {
        strongify(self);
        self.kml = [KMLParser parseKMLWithData:resultData];
        if (self.kml) {
            self.geometries = self.kml.geometries;
        }
        
        [mapViewController setGeometries:self.geometries];
        [listViewController setGeometries:self.geometries];
    };
    
    self.fetchMapDidFail = ^void (NSError *error) {
        strongify(self);
        self.geometries = nil;
        self.kml = nil;
        
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:NSLocalizedString(@"Error fetching the map",
                                                                                        @"Error message. Error fetching map")]];
    };
}


@end
