//
//  BookRideViewController.h
//  AtoB
//
//  Created by Yashodhara Pandit on 12/12/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@import Firebase;
@import GoogleSignIn;
@import GoogleMaps;
@import GooglePlaces;


@interface BookRideViewController : UIViewController <GMSAutocompleteResultsViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *sourceText;
@property (weak, nonatomic) IBOutlet UITextField *destText;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *distance;
- (IBAction)findRideClick:(id)sender;
- (IBAction)signOutRegClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sampleButton;
@property GMSAutocompleteResultsViewController *resultsViewController;
@property GMSAutocompleteResultsViewController *resultsViewController1;
@property UISearchController *searchController;
@property UISearchController *searchController1;
@property NSString *sourceString;
@property NSString *destString;
@property double latOrigin;
@property double longOrigin;
@property double latDest;
@property double longDest;
-(void) getDistance;

@end
