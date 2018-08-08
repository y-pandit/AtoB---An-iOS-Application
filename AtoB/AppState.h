//
//  AppState.h
//  AtoB
//
//  Created by Yashodhara Pandit on 12/12/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppState : NSObject
+ (AppState *)sharedInstance;

@property (nonatomic) BOOL signedIn;
@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, retain) NSURL *photoURL;
@end
