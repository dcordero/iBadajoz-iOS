//
//  BDJKMLViewController.h
//  Badajoz
//
//  Created by David Cordero on 05/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

typedef NS_ENUM(NSInteger, KMLSource) {
    BIBA,
    HANDICAPTED
};

@interface BDJKMLMapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)mapTypeChanged:(UISegmentedControl *)segmentedControl;
- (void)setGeometries:(NSArray *)geometries;

@end
