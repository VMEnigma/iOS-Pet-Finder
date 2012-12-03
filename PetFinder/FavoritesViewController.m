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
@synthesize unfilteredData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Favorites";
        self.tabBarItem.title = @"Favorites";
        self.tabBarItem.image = [UIImage imageNamed:@"FavoriteTab"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    unfilteredData = [[FavoriteAnimalStore singletonFavorites] allFavorites];
    
    [[self tableView] reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    unfilteredData = [[FavoriteAnimalStore singletonFavorites] allFavorites];
    
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [unfilteredData count];
}

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
    
    if([[animal Type] compare:@"Dog"] == NSOrderedSame)
        cell.animalImage.image = [UIImage imageNamed:@"Dogs"];
    else
        cell.animalImage.image = [UIImage imageNamed:@"Cats"];
    
    
    if([[self.unfilteredData objectAtIndex:[indexPath row]] validity] == NO)
    {
        //can use an image to signify invalidity
        cell.animalImage.image = nil;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController * dvc = [[DetailViewController alloc] init];
    
    dvc.hidesBottomBarWhenPushed = YES;
    
    FavoriteAnimal * theAnimal = [unfilteredData objectAtIndex:[indexPath row]];
    
    [dvc setFaveAnimal:theAnimal];
    
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
        [[FavoriteImageStore sharedImages] deleteImageForKey:[fave AnimalID]];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(IBAction)editing:(id)sender
{
    if([[self tableView] isEditing])
    {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
        [[self tableView] setEditing:NO animated:YES];
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = @"Done";
        [[self tableView] setEditing:YES animated:YES];
    }
}

@end
