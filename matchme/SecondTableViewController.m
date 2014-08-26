//
//  SecondTableViewController.m
//  matchme
//
//  Created by Nick Adamo on 7/21/14.
//
//

#import "SecondTableViewController.h"

@interface SecondTableViewController ()

//Create an array of categories to chose from
@property NSMutableArray *displayResult;

@end

@implementation SecondTableViewController

//A method that retrieves a query from Parse.com of all of the cards that are in the selected category
- (void) loadCards  {
    PFQuery *query = [PFQuery queryWithClassName:@"Card"];
    NSNumber *x = [NSNumber numberWithInt:(self.category.categoryID)];
    [query whereKey:@"categoryID" equalTo:x];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu cards.", (unsigned long)objects.count);
            // Do something with the found objects
            int count=0;
            for (PFObject *object in objects) {
                count++;
                NSLog(@"%@", object.objectId);
                Card *item1 = [[Card alloc] init];
                int cardIDValue = [object[@"cardID"] intValue];
                int categoryIDValue = [object[@"categoryID"] intValue];
                item1.cardID = cardIDValue;
                item1.categoryID = categoryIDValue;
                item1.cardName = object[@"cardName"];
                item1.image1 = object[@"imageName1"];
                item1.image2 = object[@"imageName2"];
                item1.image3 = object[@"imageName3"];
                item1.answer = object[@"answer"];
                [self.displayResult addObject:item1];
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.tableView reloadData];
    }];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //call loadCards method
    [self loadCards];
    
    //instantiate array of the selected cards
    _displayResult = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the displayResult array
    return [self.displayResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cardCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell... the User selection sets the “*card” pointer which points the the cardName property encapsulated in the Card class
    Card *card = [self.displayResult objectAtIndex:indexPath.row];
    cell.textLabel.text = card.cardName;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //segue to next view controller
    if ([segue.identifier isEqualToString:@"showCard"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CardViewController *cardViewController = segue.destinationViewController;//created card view conroller object
        
        //pass the selected object in the displayResult array to the next view controller
        cardViewController.card = [_displayResult objectAtIndex:indexPath.row];
        
        //push the selected card's name as the title for the next view controller (CardViewConroller)
        cardViewController.title = cardViewController.card.cardName;
    }
}

 
 
@end
