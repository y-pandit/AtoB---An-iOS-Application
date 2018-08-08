//
//  ViewController.h
//  AtoB
//
//  Created by Yashodhara Pandit on 12/11/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@import Firebase;
@import GoogleSignIn;

@interface ViewController : UIViewController <GIDSignInDelegate,
GIDSignInUIDelegate> {
    BOOL checked;

}
@property (weak, nonatomic) IBOutlet UIButton *rememberMeButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPwdButton;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)rememberMeClick:(id)sender;
- (IBAction)loginClick:(id)sender;
- (IBAction)signUpClick:(id)sender;
- (IBAction)forgotPwdClick:(id)sender;


@end

