//
//  BaseViewController.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "BaseViewController.h"
#import "DetailViewController.h"
#import "AnimalStore.h"
#import "CSVAnimalData.h"
#import "FavoriteAnimalStore.h"


@interface BaseViewController ()

@end

@implementation BaseViewController


//(RG) - Base Class NIB initializer
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _typeOfAnimal = [[NSString alloc] init];
    }
    return self;
}

//(RG)
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self fetchEntries];
    
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
    
    //Add filter button to navigation controller
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterData)];
    self.navigationItem.leftBarButtonItem = filterButton;
    
    //Add refresh button to navigation controller
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    self.navigationItem.rightBarButtonItem = refreshButton;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)filterData
{
    FilterViewController *filterController = [[FilterViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:filterController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//
//}

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
    DetailViewController * dvc = [[DetailViewController alloc] init];
    
//    Animal * theAnimal = [unfilteredData objectAtIndex:[indexPath row]];
    Animals *theAnimal = [[_unfilteredAnimalData animalData] objectAtIndex:[indexPath row]];
    
    [dvc setAnimal: theAnimal];
    
    [[self navigationController] pushViewController:dvc animated:YES];
}

//(RG) - Fetch Entries
- (void)fetchEntries
{
    //First check if this is a Dog or a Cat since Favorties does not need to fetch entries
    if ([_typeOfAnimal isEqualToString:@"Dog"] || [_typeOfAnimal isEqualToString:@"Cat"])
    {
        UIView *currentTitleView = [[self navigationItem] titleView];
        UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc]
                                           initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [[self navigationItem] setTitleView:aiView];
        [aiView startAnimating];
        
        
        void (^completionBlock)(Animals *obj, NSError *err) = ^(Animals *obj, NSError *err) {
            NSLog(@"block recieved");
              [[self navigationItem] setTitleView:currentTitleView];
            
            //If there are no errors, load the data and reload tableview
            if(!err) {
                _unfilteredAnimalData = obj;
                NSLog(@"%@", _unfilteredAnimalData);
                _unfilteredData = [_unfilteredAnimalData.animalOfType mutableArrayValueForKey:_typeOfAnimal];
                NSLog(@"%@", _unfilteredData);
                _filteredData = [_unfilteredAnimalData returnFilteredWithAnimalData: _unfilteredData];
                
                [[self tableView] reloadData];
                
            }
            //Else, error detected, show AlertView error message
            else
            {

                NSString *errorString = [NSString stringWithFormat:@"At this moment, Pet Finder can't load data from the shelter. Please try again later."];
                NSLog(@"FETCH ERROR - %@", [err localizedDescription]);
                
                // Create and show an alert view with this error displayed
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:errorString
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
                [alertView show];
            }
        };
        //Requested data from sharedAnimalData singleton
        [[AnimalStore sharedAnimalData] fetchAnimalsWithCompletion:completionBlock];
    }        
}

-(void)refreshData
{
    [self fetchEntries];
    
    // - - - - - - - - - - - - - - -
    
    //Invalidate invalid favorites
    
    FavoriteAnimalStore * favorites = [FavoriteAnimalStore singletonFavorites];
    
    for(FavoriteAnimal * fave in [favorites allFavorites])
    {
        BOOL exists = NO;
        
        for(Animal * beast in [_unfilteredAnimalData animalData])
        {
            if([[fave animalID] compare:[beast AnimalID]] == NSOrderedSame)
            {
                exists = YES;
                break;
            }
        }
        
        if(exists == NO)
        {
            fave.validity = NO;
        }
    }
    _searching = NO;
    [self.search setText:@""];
    [self.search resignFirstResponder];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //searching = YES;
    //canSelectRows = NO;
    
    //self.tableView.scrollEnabled = NO;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_copiedData removeAllObjects];
    
    _searching = YES;
    _canSelectRows = YES;
    self.tableView.scrollEnabled = YES;
    [self searchTableView];
    
    if([searchBar.text length] == 0)
        _searching = NO;
    
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if([searchBar text].length == 0)
    {
        _searching = NO;
    }
    
    [searchBar resignFirstResponder];
    _canSelectRows = YES;
    self.tableView.scrollEnabled = YES;
    [self.tableView reloadData];
}

-(void)searchTableView
{
    NSString * theText = [self.search text];
    
    for(Animal * currentAnimal in _filteredData)
    {
        if([currentAnimal.Name rangeOfString:theText options:NSCaseInsensitiveSearch].length > 0 || [currentAnimal.Breed rangeOfString:theText options:NSCaseInsensitiveSearch].length > 0)
        {
            [_copiedData addObject:currentAnimal];
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    if(touch.phase == UITouchPhaseBegan)
    {
        [self.search resignFirstResponder];
    }
}

@end
