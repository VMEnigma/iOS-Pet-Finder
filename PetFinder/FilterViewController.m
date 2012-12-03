//
//  FilterViewController.m
//  PetFinder
//
//  Created by Raymond G on 11/22/12.
//
//

#import "FilterViewController.h"

@interface FilterViewController ()

{
    NSMutableArray *filterData;
    NSString *pListPath;
}

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Filter";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *navigationBarColor = [UIColor colorWithRed:0.172549 green:0.643137 blue:0.905882 alpha:1];
    [self.navigationController.navigationBar setTintColor: navigationBarColor];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancelFilter)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneFilter)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    //Get plist path in documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    pListPath = [documentsDirectory stringByAppendingPathComponent:@"Filter.plist"];

    
    //load filter data array with plist
	filterData= [[NSMutableArray alloc] initWithContentsOfFile:pListPath];
    
    NSLog(@"%@", filterData);
    
}

-(void)cancelFilter
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)doneFilter
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 3;
    }
    else
    {
        return 4;
    }
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"filterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"filterCell"];
    }
    
    //Load plist data for sections and rows
    NSDictionary *currentSectionDictionary = [filterData objectAtIndex: indexPath.section];
    NSArray *currentRowArray = [currentSectionDictionary objectForKey: @"Rows"];
    cell.textLabel.text = [currentRowArray objectAtIndex: indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    
    //Add checkmark to selected row and make font bold
    NSNumber *currentCheckMark = [currentSectionDictionary objectForKey: @"Selected"];
    if ([currentCheckMark isEqualToNumber:[NSNumber numberWithInteger: indexPath.row]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.font  = [UIFont boldSystemFontOfSize:15.0];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDictionary *currentSectionDictionary = [filterData objectAtIndex: section];
    return [currentSectionDictionary objectForKey: @"Title"];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 26;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark -
#pragma mark Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Load plist data for sections and rows
    NSMutableDictionary *currentSectionDictionary = [filterData objectAtIndex: indexPath.section];
    [currentSectionDictionary setObject:[NSNumber numberWithInteger:indexPath.row] forKey:@"Selected"];
    
    //reload filter data
    [filterData writeToFile:pListPath atomically:YES];
    filterData = [[NSMutableArray alloc] initWithContentsOfFile:pListPath];
    
    
    //reload tableview
    [tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


@end
