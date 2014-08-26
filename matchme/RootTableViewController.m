//
//  RootTableViewController.m
//  matchme
//
//  Created by Nick Adamo on 7/21/14.
//
//

#import "RootTableViewController.h"
#import "SecondTableViewController.h"
#import "GameCategory.h"

@interface RootTableViewController ()

//create an array where the categories retrieved from Parse.com will be stored
@property NSMutableArray *categories;

@end

@implementation RootTableViewController

//Add categories from parse.com to the "categories" mutable array
- (void) loadCategories  {
    PFQuery *query = [PFQuery queryWithClassName:@"Category"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu categories.", (unsigned long)objects.count);
            // Display found objects
            int count=0;
            for (PFObject *object in objects) {
                count++;
                NSLog(@"%@", object.objectId);
                GameCategory *item = [[GameCategory alloc] init];
                int categoryIDValue = [object[@"categoryID"] intValue];
                item.categoryID = categoryIDValue;
                item.categoryName = object[@"categoryName"];
                [self.categories addObject:item];
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
    
    //instantiate array of categories
    self.categories = [[NSMutableArray alloc] init];
    
    //load the query returned from Parse.com
    [self loadCategories];
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
    // Return the number of rows in the section.
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"categoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell... The user selection sets the "categoryTitle" pointer which points to "categoryName" property which is encapsulated in the GameCategory class
    GameCategory *categoryTitle = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = categoryTitle.categoryName;
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
    // Segue to the next tableViewController
    
    if ([segue.identifier isEqualToString:@"showCategoryDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        //created second tableView conroller object secondViewController
        SecondTableViewController *secondViewController = segue.destinationViewController;
        
        // Pass the selected object to the new view controller.
        secondViewController.category = [self.categories objectAtIndex:indexPath.row];
       
        //the title of second view controller is whatever category is selected
        secondViewController.title = secondViewController.category.categoryName;
    }
    
}


//Returns user back to login/registration screen
- (IBAction)logoutButton:(id)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
    
     }

@end
