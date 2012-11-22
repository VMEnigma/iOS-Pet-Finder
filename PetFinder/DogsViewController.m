//
//  DogsViewController.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "DogsViewController.h"



@interface DogsViewController ()
{
    NSMutableDictionary* dictionaryDogs;
}

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.unfilteredData count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnimalCell";
    AnimalCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil)
    {
        cell = [[AnimalCell alloc] init];
    }
    
    // Configure the cell...
    Animal *animal = [self.unfilteredData objectAtIndex:[indexPath row]];
    [cell setAnimalModel: animal];
    //Set cell image to dogs
    cell.animalImage.image = [UIImage imageNamed:@"Dogs"];
    
    return cell;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


@end
