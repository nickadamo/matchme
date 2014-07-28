//
//  LoginViewController.m
//  matchme
//
//  Created by Nick Adamo on 7/21/14.
//
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//Check if User is already registered
- (void) viewDidAppear: (BOOL) animated {
 
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [self  performSegueWithIdentifier:@"login" sender: self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButton:(id)sender {
    [PFUser logInWithUsernameInBackground:_loginUsernameField.text password:_loginPasswordField.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            NSLog(@"Login user!");
            _loginPasswordField.text = nil;
            _loginUsernameField.text = nil;
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"Sorry we had a problem logging you in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}



- (IBAction)registerSegueButton:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _registerOverlayView.frame = self.view.frame;
    }];
}

- (IBAction)hideRegisterOverlayView:(id)sender {
    [_registerOverlayView setHidden:YES];
}

- (IBAction)signUpAction:(id)sender {
    //Get rid of keyboard
    [_usernameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_reEnterPasswordField resignFirstResponder];
    [self checkFieldsComplete];
}


- (void) checkFieldsComplete {
    if ([_usernameField.text isEqualToString:@""] || [_emailField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"Please complete all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatch];
    }
}

- (void) checkPasswordsMatch {
    if (![_passwordField.text isEqualToString:_reEnterPasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"Please make sure the both passwords match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}

- (void) registerNewUser {
    NSLog(@"registering....");
    PFUser *newUser = [PFUser user];
    newUser.username = _usernameField.text;
    NSLog(@"username: %@",_usernameField.text);
    newUser.email = _emailField.text;
    newUser.password = _passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success!");
            _loginPasswordField.text = nil;
            _loginUsernameField.text = nil;
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else {
            NSLog(@"There was an error in registration");
        }
    }];
}


//Play as a guest "quick play"
- (IBAction)quickPlayButton:(id)sender {
    
    [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (error) {
            NSLog(@"Anonymous login failed.");
        } else {
            NSLog(@"Anonymous user logged in.");
            [self  performSegueWithIdentifier:@"login" sender: self];

        }
    }];
}

//Get rid of keyboard if user taps the background
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}
@end
