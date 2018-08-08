//
//  User.h
//  AtoB
//
//  Created by Yashodhara Pandit on 12/11/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property NSString *name;
@property NSString *phoneNumber;
@property NSString *zipcode;
@property NSString *email;
@property NSMutableArray *rides;
@end
