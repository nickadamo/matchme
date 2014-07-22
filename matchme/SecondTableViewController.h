//
//  SecondTableViewController.h
//  matchme
//
//  Created by Nick Adamo on 7/21/14.
//
//

#import <UIKit/UIKit.h>
#import "GameCategory.h"
#import <Parse/Parse.h>
#import "Card.h"
#import "CardViewController.h"

@interface SecondTableViewController : UITableViewController

//declare *category as a pointer to the GameCategory class
@property GameCategory *category;

@end
