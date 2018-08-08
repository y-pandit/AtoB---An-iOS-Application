//
//  AppState.m
//  AtoB
//
//  Created by Yashodhara Pandit on 12/12/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//

#import "AppState.h"

@implementation AppState
+ (AppState *)sharedInstance {
    static AppState *sharedMyInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyInstance = [[self alloc] init];
    });
    return sharedMyInstance;
}

@end
