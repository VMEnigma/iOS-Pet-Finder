//
//  FilterViewController.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "FilterViewController.h"
#import "Utilities.h"


// (RG)
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
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneFilter)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    //Load filter data from plist
    pListPath = [Utilities getFilterPath];
	filterData = [[NSMutableArray alloc] initWithContentsOfFile:pListPath];
}
// Done button on navigation bar
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
    //3 rows for Gender and Age
    if (section == 0 || section == 1)
    {
        return 3;
    }
    // rows for Size
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
