//
//  BookRideViewController.m
//  AtoB
//
//  Created by Yashodhara Pandit on 12/12/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//
#import "AppState.h"
#import "BookRideViewController.h"
#import "ViewController.h"
@import GoogleMaps;
@import GooglePlaces;



@interface BookRideViewController (){

    GMSMapView *mapView;
    GMSPolyline *polyline;
}

@end

@implementation BookRideViewController {
    GMSPlacesClient *_placesClient;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    UIImage* image3 = [UIImage imageNamed:@"logout.png"];
    CGRect frameimg = CGRectMake(15,5, 25,25);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(sOAction)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *sObutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =sObutton;
    
    _placesClient = [GMSPlacesClient sharedClient];
    NSString *placeID = @"ChIJ0THH2xt644kRA-oJAjoLXqo";

    
//    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
//        if (error != nil) {
//            NSLog(@"Pick Place error %@", [error localizedDescription]);
//            return;
//        }
//        
//        self.sourceText.text = @"No current place";
//        self.destText.text = @"";
//        
//        if (placeLikelihoodList != nil) {
//            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
//            if (place != nil) {
//                self.sourceText.text = place.name;
//                self.destText.text = [[place.formattedAddress componentsSeparatedByString:@", "]
//                                          componentsJoinedByString:@"\n"];
//            }
//        }
//    }];
    
    [_placesClient lookUpPlaceID:placeID callback:^(GMSPlace *place, NSError *error){
                if (error != nil) {
                    NSLog(@"Pick Place error %@", [error localizedDescription]);
                    return;
                }
        
                self.sourceText.text = @"No current place";
                self.destText.text = @"";
        
                    if (place != nil) {
                         NSLog(@"The source is %@", place.name);
                        _sourceString = place.placeID;
                       // _latOrigin = place.coordinate.latitude;
                       // _longOrigin = place.coordinate.longitude;
                        _latOrigin = 42.343750;
                        _longOrigin = -71.0894;
//                        self.destText.text = [[place.formattedAddress componentsSeparatedByString:@", "]
//                                                  componentsJoinedByString:@"\n"];
                    }
                
            }];
    
    
    
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 500; // meters
    
    [_locationManager startUpdatingLocation];
    
    
    
    
    
    
    
    
    
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:42.343750
                                                            longitude:-71.0894
                                                                 zoom:8];
    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    //self.view = mapView;
    [self.view insertSubview:mapView atIndex:0];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(42.343750, -71.0894);
    marker.title = @"You are here";
    //marker.snippet = @"Australia";
    marker.map = mapView;
    
    
    
    

    _resultsViewController = [[GMSAutocompleteResultsViewController alloc] init];
    _resultsViewController.delegate = self;
    
//    _resultsViewController1 = [[GMSAutocompleteResultsViewController alloc] init];
//    _resultsViewController1.delegate = self;
    
    _searchController = [[UISearchController alloc]
                         initWithSearchResultsController:_resultsViewController];
    _searchController.searchResultsUpdater = _resultsViewController;
    
//    _searchController1 = [[UISearchController alloc]
//                         initWithSearchResultsController:_resultsViewController1];
//    _searchController1.searchResultsUpdater = _resultsViewController1;
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 65.0, 375, 50)];
    
//    UIView *subView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 130.0, 375, 100)];
    
    [subView addSubview:_searchController.searchBar];
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.placeholder=@"Where You Want To Go";
    
    [self.view addSubview:subView];
//    
//    [subView1 addSubview:_searchController1.searchBar];
//    [_searchController1.searchBar sizeToFit];
//    _searchController1.searchBar.placeholder=@"To";
//    [self.view addSubview:subView1];

    
    // When UISearchController presents the results view, present it in
    // this view controller, not one further up the chain.
    self.definesPresentationContext = YES;
    self.navigationController.navigationBar.translucent = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    // This makes the view area include the nav bar even though it is opaque.
    // Adjust the view placement down.
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    
    
}

// Handle the user's selection.
- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
 didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    _searchController.searchBar.text=place.name;
    //_sourceString=@"Northeastern University";
    _destString=place.placeID;
    _latDest = place.coordinate.latitude;
    _longDest = place.coordinate.longitude;
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    [self getDistance];
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}




- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
//        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_locationManager.location.coordinate.latitude
//                                                                longitude:_locationManager.location.coordinate.longitude
//                                                                     zoom:6];
//        mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
//        mapView.myLocationEnabled = YES;
//        //self.view = mapView;
//        [self.view insertSubview:mapView atIndex:0];
//        
//        // Creates a marker in the center of the map.
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = CLLocationCoordinate2DMake(_locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude);
//        marker.title = @"You are here";
//        marker.snippet = @"Northeastern University";
//        marker.map = mapView;

    }
    
    
}


-(void) getDistance {
    
    NSString *urlPath = [NSString stringWithFormat:@"/maps/api/distancematrix/json?origins=42.343750, -71.0894&destinations=%g,%g&language=en-EN&sensor=false&key=AIzaSyCcPQCN1zwYIX4xyu1uDy_3wLE7lf2aqUg" ,_latDest, _longDest];
    NSURL *url = [[NSURL alloc]initWithScheme:@"https" host:@"maps.googleapis.com" path:urlPath];
//    AIzaSyCcPQCN1zwYIX4xyu1uDy_3wLE7lf2aqUg
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response ;
    NSError *error;
    NSData *data;
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSMutableDictionary *jsonDict= (NSMutableDictionary*)[NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableDictionary *newdict=[jsonDict valueForKey:@"rows"];
    NSArray *elementsArr=[newdict valueForKey:@"elements"];
    NSArray *arr=[elementsArr objectAtIndex:0];
    NSDictionary *dict=[arr objectAtIndex:0];
    NSMutableDictionary *distanceDict=[dict valueForKey:@"distance"];
    NSLog(@"distance:%@",[distanceDict valueForKey:@"text"]);
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //address.text = [distanceDict valueForKey:@"text"];
    
    [self fetchPolylineWithCompletionHandler];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(_latDest, _longDest);
    marker.title = @"You are going here";
    //marker.snippet = @"Australia";
    marker.map = mapView;
    marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
    
    CLLocationCoordinate2D from = CLLocationCoordinate2DMake(42.343750, -71.0894);
    CLLocationCoordinate2D to = CLLocationCoordinate2DMake(_latDest, _longDest);
    GMSCoordinateBounds *bounds =
    [[GMSCoordinateBounds alloc] initWithCoordinate:from coordinate:to];
    GMSCameraPosition *camera = [mapView cameraForBounds:bounds insets:UIEdgeInsetsZero];
    mapView.camera = camera;
    _distance.text=[NSString  stringWithFormat: @"Distance: %@",[distanceDict valueForKey:@"text"]];
    //[mapView animateToZoom:15];
 
    
}


- (void)fetchPolylineWithCompletionHandler
{
    polyline.map = nil;
    NSString *originString = [NSString stringWithFormat:@"%g,%g", _latOrigin, _longOrigin];
    NSString *destinationString = [NSString stringWithFormat:@"%g,%g", _latDest, _longDest];
    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&mode=driving&key=AIzaSyANFnPTettemwkp4gGu7uO1vqyEbSzx6M0", directionsAPI, originString, destinationString];
    NSURL *directionsUrl = [NSURL URLWithString:directionsUrlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:directionsUrl];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response ;
    NSError *error;
    NSData *data;
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSMutableDictionary *json= (NSMutableDictionary*)[NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:&error];
    
    
    NSArray *routesArray = [json objectForKey:@"routes"];
    
//GMSPolyline *polyline = nil;
    if ([routesArray count] > 0)
    {
        NSDictionary *routeDict = [routesArray objectAtIndex:0];
        NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
        NSString *points = [routeOverviewPolyline objectForKey:@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:points];
        polyline = [GMSPolyline polylineWithPath:path];
    }
    
    if(polyline)
        polyline.map = mapView;
    
}



-(void) viewWillAppear:(BOOL)animated
{
//    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    locationButton.frame = CGRectMake(0, 30, self.view.frame.size.width/6, self.view.frame.size.height/6);
//    [locationButton setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
//    [self.view addSubview:locationButton];
}


//- (void)loadView {
//    // Create a GMSCameraPosition that tells the map to display the
//    // coordinate -33.86,151.20 at zoom level 6.
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
//                                                            longitude:151.20
//                                                                 zoom:6];
//   GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//        mapView.myLocationEnabled = YES;
//        self.view = mapView;
//
//    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView;
//}
//



-(void) sOAction {
    
    FIRAuth *firebaseAuth = [FIRAuth auth];
    NSError *signOutError;
    BOOL status = [firebaseAuth signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    [AppState sharedInstance].signedIn = false;
    [self dismissViewControllerAnimated:YES completion:nil];
    //    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    //    [self.navigationController pushViewController:viewController animated:YES];
    
    
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[ViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            
            break;
        }
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signOutRegClick:(id)sender{
    FIRAuth *firebaseAuth = [FIRAuth auth];
    NSError *signOutError;
    BOOL status = [firebaseAuth signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    [AppState sharedInstance].signedIn = false;
    [self dismissViewControllerAnimated:YES completion:nil];
//    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[ViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            
            break;
        }
    }

    
    
    
}



//- (IBAction)signOutGoogleClick:(id)sender{
//
//    NSError *signOutError;
//    BOOL status = [[FIRAuth auth] signOut:&signOutError];
//    if (!status) {
//        NSLog(@"Error signing out: %@", signOutError);
//        return;
//        }
//    if(![FIRAuth auth].currentUser)
//    {
//        ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
