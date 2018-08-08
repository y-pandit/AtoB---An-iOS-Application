//
//  Ride.h
//  AtoB
//
//  Created by Yashodhara Pandit on 12/12/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ride : NSObject
@property NSString *source;
@property NSString *destination;
@property NSString *provider;
@property NSNumber *price_min;
@property NSNumber *price_max;
@end
