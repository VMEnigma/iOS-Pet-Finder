//
//  CatsViewController.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "CatsViewController.h"
#import "DetailViewController.h"
#import "AnimalData.h"
#import "CSVAnimalController.h"
#import "FavoriteAnimalStore.h"

@interface CatsViewController ()

@end

@implementation CatsViewController
@synthesize unfilteredData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cats";
        self.tabBarItem.title = @"Cats";
        self.tabBarItem.image = [UIImage imageNamed:@"CatsTab"];
        
        UIBarButtonItem * bbi = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
        
        [[self navigationItem] setLeftBarButtonItem:bbi];        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.unfilteredData = [[AnimalData sharedAnimalData].animalOfType mutableArrayValueForKey:@"Cat"];
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
    cell.animalImage.image = [UIImage imageNamed:@"Cats"];
    
    return cell;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController * dvc = [[DetailViewController alloc] init];
    
    dvc.hidesBottomBarWhenPushed = YES;
    
    Animal * theAnimal = [unfilteredData objectAtIndex:[indexPath row]];
    
    [dvc setAnimal:theAnimal];
    
    [[self navigationController] pushViewController:dvc animated:YES];
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
            if([[fave AnimalID] compare:[beast AnimalID]] == NSOrderedSame)
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
    [self.tableView reloadData];
}

@end
