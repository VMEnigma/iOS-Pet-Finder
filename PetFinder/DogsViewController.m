//
//  DogsViewController.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "DogsViewController.h"

@interface DogsViewController ()

@property (nonatomic, strong) NSMutableArray *dogs;

@end

@implementation DogsViewController

//@synthesize filteredData, unfilteredData, dogs, search, searching, canSelectRows;
@synthesize dogs, search, searching, canSelectRows;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Dogs";
        self.tabBarItem.title = @"Dogs";
        self.tabBarItem.image = [UIImage imageNamed:@"DogsTab"];
        self.copiedData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.search.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.search setDelegate:self];
    searching = NO;
    canSelectRows = YES;
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Load Animal Data from Singleton
    [self fetchEntries];
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
    if(searching)
        return [self.copiedData count];
    
    return [filteredData count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnimalCell";
    AnimalCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    Animal * animal;
    if (cell == nil)
    {
        cell = [[AnimalCell alloc] init];
    }
    
    // Configure the cell...
    
    if(searching)
    {
        animal = [self.copiedData objectAtIndex:[indexPath row]];
    }
    else
    {
        animal = [filteredData objectAtIndex:[indexPath row]];
    }
    
    [cell setAnimalModel: animal];
    
    //Set cell image to dogs
    cell.animalImage.image = [UIImage imageNamed:@"Dogs"];
    
    return cell;
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
        
        for(Animal * beast in [unfilteredAnimalData animalData])
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
    [self fetchEntries];
    
    searching = NO;
    [self.search setText:@""];
    [self.search resignFirstResponder];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(canSelectRows)
    {
        DetailViewController * dvc = [[DetailViewController alloc] init];
    
        dvc.hidesBottomBarWhenPushed = YES;
        
        Animal * theAnimal;
    
        if(searching)
        {
            theAnimal = [self.copiedData objectAtIndex:[indexPath row]];
        }
        else
        {
            theAnimal = [filteredData objectAtIndex:[indexPath row]];
        }
        
        //[search setText:@""];
        [self.search resignFirstResponder];
    
        [dvc setAnimal:theAnimal];
    
        [[self navigationController] pushViewController:dvc animated:YES];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //searching = YES;
    //canSelectRows = NO;
    
    //self.tableView.scrollEnabled = NO;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.copiedData removeAllObjects];
    
        searching = YES;
        canSelectRows = YES;
        self.tableView.scrollEnabled = YES;
        [self searchTableView];
    
    if([searchBar.text length] == 0)
        searching = NO;
    
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if([searchBar text].length == 0)
    {
        searching = NO;
    }
    
    [searchBar resignFirstResponder];
    canSelectRows = YES;
    self.tableView.scrollEnabled = YES;
    [self.tableView reloadData];
}

-(void)searchTableView
{
     NSString * theText = [self.search text];
    
    for(Animal * currentAnimal in filteredData)
    {
        if([currentAnimal.Name rangeOfString:theText options:NSCaseInsensitiveSearch].length > 0 || [currentAnimal.Breed rangeOfString:theText options:NSCaseInsensitiveSearch].length > 0)
        {
            [self.copiedData addObject:currentAnimal];
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
//(RG) - Fetch Entries
- (void)fetchEntries
{
    //    UIView *currentTitleView = [[self navigationItem] titleView];
    //    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc]
    //                                       initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //    [[self navigationItem] setTitleView:aiView];
    //    [aiView startAnimating];
    
    
    void (^completionBlock)(Animals *obj, NSError *err) = ^(Animals *obj, NSError *err) {
        // When the request completes, this block will be called.
        //  [[self navigationItem] setTitleView:currentTitleView];
        
        if(!err) {
            // If everything went ok, grab the channel object and
            // reload the table.
            unfilteredAnimalData = obj;
            unfilteredData = [unfilteredAnimalData.animalOfType mutableArrayValueForKey:@"Dog"];
            filteredData = [unfilteredAnimalData returnFilteredWithAnimalData: unfilteredData];
            
            [[self tableView] reloadData];
        } else {
            
            // If things went bad, show an alert view
            NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",
                                     [err localizedDescription]];
            
            // Create and show an alert view with this error displayed
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:errorString
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
            [av show];
        }
    };
    
    [[AnimalStore sharedAnimalData] fetchAnimalsWithCompletion:completionBlock];
}


@end
