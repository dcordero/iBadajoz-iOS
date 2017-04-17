//
//  BDJAddressAnnotation.h
//  Badajoz
//
//  Created by David Cordero on 28/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BDJAddressAnnotation : NSObject <MKAnnotation>

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
