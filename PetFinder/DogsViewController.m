//
//  DogsViewController.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "DogsViewController.h"
#import "Animal.h"
#import "AnimalCell.h"
#import "AnimalData.h"
#import "Utilities.h"
#import "CSVAnimalController.h"
#import <QuartzCore/QuartzCore.h>


@interface DogsViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dogs;

@end

@implementation DogsViewController

@synthesize filteredData, unfilteredData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Dogs";
        self.tabBarItem.title = @"Dogs";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //Outer view without clipping (shadow + rounded)
    UIView *viewContainer1 = [self.view viewWithTag:2];
    viewContainer1.layer.cornerRadius = 10;
    viewContainer1.layer.shadowColor = [[UIColor blackColor] CGColor];
    viewContainer1.layer.shadowOpacity = 0.5;
    viewContainer1.layer.shadowRadius = 10.0;
    viewContainer1.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    //Inner view with clipping that contains the table view (rounded)
    UIView *viewContainer2 = [self.view viewWithTag:3];
    viewContainer2.layer.cornerRadius = 10;
    
    //Load custom tableview cell
    UINib* nib = [UINib nibWithNibName:@"AnimalCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier: @"AnimalCell"];
    self.tableView.rowHeight = ((UITableViewCell*)[[nib instantiateWithOwner:self options:nil] objectAtIndex:0]).bounds.size.height;
    
    
    self.unfilteredData = [AnimalData sharedAnimalData].animalData;
    [self.tableView reloadData];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.unfilteredData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    static NSString *CellIdentifier = @"AnimalCell";
    
    AnimalCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil)
    {
        cell = [[AnimalCell alloc] init];
    }
    
    // Configure the cell...
    
    Animal *animal = [self.unfilteredData objectAtIndex:[indexPath row]];
    [cell setAnimalModel: animal];
    cell.animalImage.image = [UIImage imageNamed:@"Dogs"];
    
    
    return cell;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

/*
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 return 44.0f;
 }
 */

@end
