//
//  CatsViewController.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "CatsViewController.h"


@interface CatsViewController ()

@end

@implementation CatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cats";
        self.tabBarItem.title = @"Cats";
        self.tabBarItem.image = [UIImage imageNamed:@"CatsTab"];
        _copiedData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.search.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.search setDelegate:self];
    _searching = NO;
    _canSelectRows = YES;
    _typeOfAnimal = @"Cat";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Fetch new entries
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
    if(_searching)
        return [_copiedData count];
    
    return [_filteredData count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnimalCell";
    Animal * animal;
    AnimalCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil)
    {
        cell = [[AnimalCell alloc] init];
    }
    
    // Configure the cell...
    //Animal *animal = [self.filteredData objectAtIndex:[indexPath row]];
    
    if(_searching)
    {
        animal = [_copiedData objectAtIndex:[indexPath row]];
    }
    else
    {
        animal = [_filteredData objectAtIndex:[indexPath row]];
    }
    
    [cell setAnimalModel: animal];
    
    //Set cell image to dogs or favorite
    if([[FavoriteAnimalStore singletonFavorites] isDuplicate:animal])
    {
        cell.animalImage.image = [UIImage imageNamed:@"Favorite"];
    }
    else
    {
        cell.animalImage.image = [UIImage imageNamed:@"Cats"];
    }
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController * dvc = [[DetailViewController alloc] init];
    
    dvc.hidesBottomBarWhenPushed = YES;
    
    Animal * theAnimal;
    
    if(_searching)
    {
        theAnimal = [_copiedData objectAtIndex:[indexPath row]];
    }
    else
    {
        theAnimal = [_filteredData objectAtIndex:[indexPath row]];
    }
    
    //[search setText:@""];
    [self.search resignFirstResponder];
    
    [dvc setAnimal:theAnimal];
    
    [[self navigationController] pushViewController:dvc animated:YES];
}


@end
