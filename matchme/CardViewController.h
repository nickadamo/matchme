//
//  CardViewController.h
//  matchme
//
//  Created by Nick Adamo on 7/21/14.
//
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "Score.h"
#import <Parse/Parse.h>


@interface CardViewController : UIViewController
{
    CGPoint pos;
    IBOutlet UIImageView *confetti;
    NSTimer *timer;
}

//declare *card as a pointer to the Card class
@property Card *card;
//declare *scoreObject as a pointer to the Score class
@property Score *scoreObject;

@property IBOutlet UIImageView *ImageView1;
@property IBOutlet UIImageView *ImageView2;
@property IBOutlet UIImageView *ImageView3;
@property IBOutlet UIButton *button1;
@property IBOutlet UIButton *button2;
@property IBOutlet UIButton *button3;
@property IBOutlet UILabel *scoreLabel;

-(IBAction)selectImage1:(id)sender;
-(IBAction)selectImage2:(id)sender;
-(IBAction)selectImage3:(id)sender;

@end
