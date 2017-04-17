//
//  BDJKMLViewController.m
//  Badajoz
//
//  Created by David Cordero on 05/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJKMLMapViewController.h"
#import "BDJNavigationController.h"
#import "KML.h"
#import "KML+MapKit.h"
#import "BDJKMLDetailsViewController.h"
#import "WeakifyStrongify.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface BDJKMLMapViewController ()

@property (nonatomic) NSArray *geometries;

@end

@implementation BDJKMLMapViewController

- (IBAction)mapTypeChanged:(UISegmentedControl *)segmentedControl {
    self.mapView.mapType = segmentedControl.selectedSegmentIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureNavigationBar];
}

#pragma mark - Private

- (void)configureNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu icon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(BDJNavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

- (void)setGeometries:(NSArray *)geometries
{
    _geometries = geometries;
    [self reloadMap];
}



- (void)reloadMap
{
    NSMutableArray *annotations = @[].mutableCopy;
    NSMutableArray *overlays = @[].mutableCopy;
    
    [self.geometries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         KMLAbstractGeometry *geometry = (KMLAbstractGeometry *)obj;
         MKShape *mkShape = [geometry mapkitShape];
         if (mkShape) {
             if ([mkShape conformsToProtocol:@protocol(MKOverlay)]) {
                 [overlays addObject:mkShape];
             }
             else if ([mkShape isKindOfClass:[MKPointAnnotation class]]) {
                 [annotations addObject:mkShape];
             }
         }
     }];
    
    [self.mapView addAnnotations:annotations];
    [self.mapView addOverlays:overlays];
    
    [self centerZoomInContent];
}

- (void)centerZoomInContent
{
    dispatch_async(dispatch_get_main_queue(), ^{
        __block MKMapRect zoomRect = MKMapRectNull;
        [self.mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             id<MKAnnotation> annotation = (id<MKAnnotation>)obj;
             MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
             MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
             if (MKMapRectIsNull(zoomRect)) {
                 zoomRect = pointRect;
             } else {
                 zoomRect = MKMapRectUnion(zoomRect, pointRect);
             }
         }];
        [self.mapView setVisibleMapRect:zoomRect animated:NO];
    });
}

- (void)pushDetailViewControllerWithGeometry:(KMLAbstractGeometry *)geometry
{
    BDJKMLDetailsViewController *viewController = [[BDJKMLDetailsViewController alloc] init];
    if (viewController) {
        viewController.geometry = geometry;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    else if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKPointAnnotation *pointAnnotation = (MKPointAnnotation *)annotation;
        return [pointAnnotation annotationViewForMapView:mapView];
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKPointAnnotation *pointAnnotation = (MKPointAnnotation *)view.annotation;
        [self pushDetailViewControllerWithGeometry:pointAnnotation.geometry];
    }
}

@end
