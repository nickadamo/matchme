//
//  CardViewController.m
//  matchme
//
//  Created by Nick Adamo on 7/21/14.
//
//

#import "CardViewController.h"

@interface CardViewController ()

@end

@implementation CardViewController

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
    _ImageView1.image = [UIImage imageNamed:self.card.image1];
    _ImageView2.image = [UIImage imageNamed:self.card.image2];
    _ImageView3.image = [UIImage imageNamed:self.card.image3];
    
    //initialize scoreObject
    _scoreObject = [[Score alloc] init];
    
    //display score
    self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//User selects the 1st image
-(IBAction)selectImage1:(id)sender {
    
    //User taps the correct image their first attempt
    if (self.card.image1 == self.card.answer && self.scoreObject.wrongAttempt == 0){
        self.scoreObject.score = self.scoreObject.score + 10;
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView2.hidden = YES;
        _ImageView3.hidden = YES;
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
        confetti.hidden = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:(0.0) target:self selector:@selector(onTimer) userInfo:(nil) repeats:(YES)];
    }
    
    //User taps the correct image their second attempt
    if (self.card.image1 == self.card.answer && self.scoreObject.wrongAttempt == 1){
        self.scoreObject.score = self.scoreObject.score +7;
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView2.hidden = YES;
        _ImageView3.hidden = YES;
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
        confetti.hidden = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:(0.0) target:self selector:@selector(onTimer) userInfo:(nil) repeats:(YES)];
    }
    
    //User makes an incorrect attempt
    if (self.card.image1 != self.card.answer) {
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView1.hidden = YES;
        _button1.enabled = NO;
        self.scoreObject.wrongAttempt = self.scoreObject.wrongAttempt + 1;
        NSLog(@"Wrong Attempts = %i", (int) self.scoreObject.wrongAttempt);
    }
    
    //User makes two incorrect attempts
    if (self.scoreObject.wrongAttempt == 2){
        UIAlertView *alert = [[UIAlertView alloc]   initWithTitle:@"Too many incorrect attempts" message:@"Please return to the list of flashcards and try again" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
        [alert show];
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
    }
    
    //Update parse with score
    PFObject *gameScore = [PFObject objectWithClassName:@"Score"];
    NSNumber *y = [NSNumber numberWithInt:(self.scoreObject.score)];
    gameScore[@"score"] = y;
    [gameScore setObject:[PFUser currentUser] forKey:@"createdBy"];
    
    [gameScore saveInBackground];
}

//User selects the 2nd image
-(IBAction)selectImage2:(id)sender {
    
    //User gets it correct the first attempt
    if (self.card.image2 == self.card.answer && self.scoreObject.wrongAttempt == 0){
        self.scoreObject.score = self.scoreObject.score + 10;
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView1.hidden = YES;
        _ImageView3.hidden = YES;
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
        confetti.hidden = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:(0.0) target:self selector:@selector(onTimer) userInfo:(nil) repeats:(YES)];
    }
    
    //User taps the correct image their second attempt
    if (self.card.image2 == self.card.answer && self.scoreObject.wrongAttempt == 1){
        self.scoreObject.score = self.scoreObject.score +7;
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView1.hidden = YES;
        _ImageView3.hidden = YES;
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
        confetti.hidden = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:(0.0) target:self selector:@selector(onTimer) userInfo:(nil) repeats:(YES)];
    }
    
    //User makes an incorrect attempt
    if (self.card.image2 != self.card.answer) {
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView2.hidden = YES;
        _button2.enabled = NO;
        self.scoreObject.wrongAttempt = self.scoreObject.wrongAttempt + 1;
        NSLog(@"Wrong Attempts = %i", (int) self.scoreObject.wrongAttempt);
    }

    //User makes two incorrect attempts
    if (self.scoreObject.wrongAttempt == 2){
        UIAlertView *alert = [[UIAlertView alloc]   initWithTitle:@"Too many incorrect attempts" message:@"Please return to the list of flashcards and try again" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
        [alert show];
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
    }
    
    //Update parse with score
    PFObject *gameScore = [PFObject objectWithClassName:@"Score"];
    NSNumber *y = [NSNumber numberWithInt:(self.scoreObject.score)];
    gameScore[@"score"] = y;
    [gameScore setObject:[PFUser currentUser] forKey:@"createdBy"];
    [gameScore saveInBackground];

    
}

//User selectes the 3rd image
-(IBAction)selectImage3:(id)sender {
    
    //User gets it correct the first attempt
    if (self.card.image3 == self.card.answer && self.scoreObject.wrongAttempt == 0){
        self.scoreObject.score = self.scoreObject.score + 10;
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView1.hidden = YES;
        _ImageView2.hidden = YES;
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
        confetti.hidden = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:(0.0) target:self selector:@selector(onTimer) userInfo:(nil) repeats:(YES)];
    }
    
    //User taps the correct image their second attempt
    if (self.card.image3 == self.card.answer && self.scoreObject.wrongAttempt == 1){
        self.scoreObject.score = self.scoreObject.score +7;
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView1.hidden = YES;
        _ImageView2.hidden = YES;
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
        confetti.hidden = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:(0.0) target:self selector:@selector(onTimer) userInfo:(nil) repeats:(YES)];
    }
    
    //User makes an incorrect attempt
    if (self.card.image3 != self.card.answer) {
        self.scoreLabel.text= [NSString stringWithFormat:@"Score:     %i",self.scoreObject.score];
        NSLog(@"score = %i", (int) self.scoreObject.score);
        _ImageView3.hidden = YES;
        _button3.enabled = NO;
        self.scoreObject.wrongAttempt = self.scoreObject.wrongAttempt + 1;
        NSLog(@"Wrong Attempts = %i", (int) self.scoreObject.wrongAttempt);
    }

    //User makes two incorrect attempts
    if (self.scoreObject.wrongAttempt == 2){
        UIAlertView *alert = [[UIAlertView alloc]   initWithTitle:@"Too many incorrect attempts" message:@"Please return to the list of flashcards and try again" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
        [alert show];
        _button1.enabled = NO;
        _button2.enabled = NO;
        _button3.enabled = NO;
    }
    
    //Update parse with score
    PFObject *gameScore = [PFObject objectWithClassName:@"Score"];
    NSNumber *y = [NSNumber numberWithInt:(self.scoreObject.score)];
    gameScore[@"score"] = y;
    [gameScore setObject:[PFUser currentUser] forKey:@"createdBy"];
    
    [gameScore saveInBackground];

    
}

//timer for confetti animation
- (void) onTimer {
    confetti.center = CGPointMake(confetti.center.x+pos.x, confetti.center.y+pos.y);
    pos = CGPointMake(0.0, 0.1);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
