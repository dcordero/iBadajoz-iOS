//
//  BDJContactHeaderViewCell.h
//  Badajoz
//
//  Created by David Cordero on 29/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BDJContactHeaderViewCell : UIView

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *contactName;

@end
