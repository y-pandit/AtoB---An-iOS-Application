//
//  ViewController.m
//  AtoB
//
//  Created by Yashodhara Pandit on 12/11/16.
//  Copyright © 2016 Yashodhara Pandit. All rights reserved.
//


#import "AppState.h"
#import "ViewController.h"
#import "BookRideViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    //[[GIDSignIn sharedInstance] signIn];
    // Do any additional setup after loading the view, typically from a nib.
    checked = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
        [self signedIn:user];
    }
}



- (void)signedIn:(FIRUser *)user {

    
    [AppState sharedInstance].displayName = user.displayName.length > 0 ? user.displayName : user.email;
    [AppState sharedInstance].photoURL = user.photoURL;
    [AppState sharedInstance].signedIn = YES;
    //[[NSNotificationCenter defaultCenter] postNotificationName:NotificationKeysSignedIn object:nil userInfo:nil];
    //[self performSegueWithIdentifier:SeguesSignInToFp sender:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged-In!" message:@"You have successfully logged-in" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
    BookRideViewController *bookRideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bookView"];
    [self.navigationController pushViewController:bookRideViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender{

    // Sign In with credentials.
    NSString *email = _emailField.text;
    NSString *password = _passwordField.text;
    [[FIRAuth auth] signInWithEmail:email
                           password:password
                         completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                             if (error) {
                                 NSLog(@"%@", error.localizedDescription);
                                 return;
                             }
                             [self signedIn:user];
                         }];
    
    
//    BookRideViewController *bookRideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bookView"];
//    [self.navigationController pushViewController:bookRideViewController animated:YES];

}

- (IBAction)signUpClick:(id)sender{

    NSString *email = _emailField.text;
    NSString *password = _passwordField.text;
    [[FIRAuth auth] createUserWithEmail:email
                               password:password
                             completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                                 if (error) {
                                     NSLog(@"%@", error.localizedDescription);
                                     return;
                                 }
                                 [self setDisplayName:user];
                                 
                             }];


}

- (void)setDisplayName:(FIRUser *)user {
    FIRUserProfileChangeRequest *changeRequest =
    [user profileChangeRequest];
    // Use first part of email as the default display name
    changeRequest.displayName = [[user.email componentsSeparatedByString:@"@"] objectAtIndex:0];
    [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        [self signedIn:[FIRAuth auth].currentUser];
    }];
}


- (IBAction)didRequestPasswordReset:(id)sender {
    UIAlertController *prompt =
    [UIAlertController alertControllerWithTitle:nil
                                        message:@"Email:"
                                 preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakPrompt = prompt;
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   UIAlertController *strongPrompt = weakPrompt;
                                   NSString *userInput = strongPrompt.textFields[0].text;
                                   if (!userInput.length)
                                   {
                                       return;
                                   }
                                   [[FIRAuth auth] sendPasswordResetWithEmail:userInput
                                                                   completion:^(NSError * _Nullable error) {
                                                                       if (error) {
                                                                           NSLog(@"%@", error.localizedDescription);
                                                                           return;
                                                                       }
                                                                   }];
                                   
                               }];
    [prompt addTextFieldWithConfigurationHandler:nil];
    [prompt addAction:okAction];
    [self presentViewController:prompt animated:YES completion:nil];
}

- (IBAction)rememberMeClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have successfully clicked" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];

        if(!checked){
            [_rememberMeButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
            checked = YES;
        }
        else if(checked){
            [_rememberMeButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            checked = NO;
        }
    


}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        [[FIRAuth auth] signInWithCredential:credential
                                           completion:^(FIRUser *user, NSError *error) {
                                               // ...
                                               UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                                               //.......
                                               BookRideViewController *bookRideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bookView"];
                                               [self.navigationController pushViewController:bookRideViewController animated:YES];
         
                                                                                     if (error) {
                                                   // ...
                                                   return;
                                               }
         
                                           }];
        
    }
}


@end
