//
//  LoginViewController.h
//  matchme
//
//  Created by Nick Adamo on 7/21/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *loginUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordField;

- (IBAction)loginButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *registerOverlayView;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordField;


- (IBAction)signUpAction:(id)sender;
- (IBAction)registerSegueButton:(id)sender;
- (IBAction)hideRegisterOverlayView:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)quickPlayButton:(id)sender;


@end
