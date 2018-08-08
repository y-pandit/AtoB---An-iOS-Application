//
//  CompareRidesViewController.h
//  AtoB
//
//  Created by Yashodhara Pandit on 12/16/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@import Firebase;
@import GoogleSignIn;
@import GoogleMaps;
@import GooglePlaces;


@interface CompareRidesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end
