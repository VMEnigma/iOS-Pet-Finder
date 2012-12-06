//
//  FavoritesViewController.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "FavoritesViewController.h"
#import "FavoriteImageStore.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController
//@synthesize unfilteredData, search, searching, canSelectRows;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Favorites";
        self.tabBarItem.title = @"Favorites";
        self.tabBarItem.image = [UIImage imageNamed:@"FavoriteTab"];
        _copiedData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = nil;
    
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editing:)];
    
    [[self navigationItem] setLeftBarButtonItem:bbi];

    
    _unfilteredData = [[FavoriteAnimalStore singletonFavorites] allFavorites];
    
    self.search.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.search setDelegate:self];
    _searching = NO;
    _canSelectRows = YES;
    
    [[self tableView] reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    _unfilteredData = [[FavoriteAnimalStore singletonFavorites] allFavorites];
    
    [[self tableView] reloadData];
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_searching)
        return [_copiedData count];
    
    return [_unfilteredData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnimalCell";
    FavoriteAnimal * temp;
    AnimalCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil)
    {
        cell = [[AnimalCell alloc] init];
    }
    
    // Configure the cell...
    //Animal *animal = [self.unfilteredData objectAtIndex:[indexPath row]];
    
    Animal * animal = [[Animal alloc] init];
    
    if(!_searching)
    {
        temp = [_unfilteredData objectAtIndex:[indexPath row]];
    }
    else
    {
        temp = [_copiedData objectAtIndex:[indexPath row]];
    }
    
    [animal setName:[temp name]];
    [animal setType:[temp type]];
    [animal setBreed:[temp breed]];
    [animal setSize:[temp size]];
    [animal setSex:[temp sex]];
    [animal setDescription1:[temp description1]];
    [animal setDescription2:[temp description2]];
    [animal setDescription3:[temp description3]];
    [animal setShelterDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[temp shelterDate]]];
    [animal setAge:[NSNumber numberWithInt:[temp age]]];
    [animal setAnimalID:[temp animalID]];

    [cell setAnimalModel: animal];
    
    if([[animal Type] compare:@"Dog"] == NSOrderedSame)
        cell.animalImage.image = [UIImage imageNamed:@"Dogs"];
    else
        cell.animalImage.image = [UIImage imageNamed:@"Cats"];
    
    
    if([[_unfilteredData objectAtIndex:[indexPath row]] validity] == NO)
    {
        //can use an image to signify invalidity
        cell.animalImage.image = nil;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController * dvc = [[DetailViewController alloc] init];
    
    dvc.hidesBottomBarWhenPushed = YES;
    
    FavoriteAnimal * theAnimal;
    
    if(!_searching)
    {
        theAnimal = [_unfilteredData objectAtIndex:[indexPath row]];
    }
    else
    {
        theAnimal = [_copiedData objectAtIndex:[indexPath row]];
    }
    
    [dvc setFaveAnimal:theAnimal];
    
    [self.search resignFirstResponder];
    
    [[self navigationController] pushViewController:dvc animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        FavoriteAnimalStore * favorites = [FavoriteAnimalStore singletonFavorites];
        NSArray * list = [favorites allFavorites];
        FavoriteAnimal * fave = [list objectAtIndex:[indexPath row]];
        [favorites removeAnimal:fave];
        [[FavoriteImageStore sharedImages] deleteImageForKey:[fave animalID]];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(IBAction)editing:(id)sender
{
    if([[self tableView] isEditing])
    {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
        [self.search setHidden:NO];
        [[self tableView] setEditing:NO animated:YES];
    }
    else
    {
        [self.search resignFirstResponder];
        [self.search setText:@""];
        _searching = NO;
        [self.search setHidden:YES];
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem.title = @"Done";
        [[self tableView] setEditing:YES animated:YES];
    }
}


@end
