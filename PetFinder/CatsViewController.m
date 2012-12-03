//
//  CatsViewController.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "CatsViewController.h"


@interface CatsViewController ()

@end

@implementation CatsViewController
@synthesize unfilteredData, filteredData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cats";
        self.tabBarItem.title = @"Cats";
        self.tabBarItem.image = [UIImage imageNamed:@"CatsTab"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.unfilteredData = [[AnimalData sharedAnimalData].animalOfType mutableArrayValueForKey:@"Cat"];
    self.filteredData = [[AnimalData sharedAnimalData] returnFilteredWithAnimalData: self.unfilteredData];
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
    return [self.filteredData count];
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
    Animal *animal = [self.filteredData objectAtIndex:[indexPath row]];
    [cell setAnimalModel: animal];
    //Set cell image to dogs
    cell.animalImage.image = [UIImage imageNamed:@"Cats"];
    
    return cell;
}

-(void)refresh
{
    AnimalData * animalData = [AnimalData sharedAnimalData];
    
    // Load animal data with CSV parser
    CSVAnimalController* dataLoader = [[CSVAnimalController alloc] initWithStringUrl:@"http://www.venexmedia.com/AnimalShelterApp/animals.csv"];
    
    //Populate singleton data with CSV parsed data
    [animalData populateAnimalData:[dataLoader getAnimalDataAsArray]];
    
    // - - - - - - - - - - - - - - -
    
    //Invalidate invalid favorites
    
    FavoriteAnimalStore * favorites = [FavoriteAnimalStore singletonFavorites];
    
    for(FavoriteAnimal * fave in [favorites allFavorites])
    {
        BOOL exists = NO;
        
        for(Animal * beast in [animalData animalData])
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
    
    self.unfilteredData = [[AnimalData sharedAnimalData].animalOfType mutableArrayValueForKey:@"Cat"];
    self.filteredData = [[AnimalData sharedAnimalData] returnFilteredWithAnimalData: self.unfilteredData];
    [self.tableView reloadData];
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController * dvc = [[DetailViewController alloc] init];
    
    dvc.hidesBottomBarWhenPushed = YES;
    
    Animal * theAnimal = [filteredData objectAtIndex:[indexPath row]];
    
    [dvc setAnimal:theAnimal];
    
    [[self navigationController] pushViewController:dvc animated:YES];
}

@end
