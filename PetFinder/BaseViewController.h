//
//  BaseViewController.h
//  PetFinder
//
//  Created by Raymond G on 11/22/12.
//
//

#import <UIKit/UIKit.h>
#import "Animal.h"
#import "AnimalCell.h"
#import "AnimalStore.h"
#import "FavoriteAnimalStore.h"
#import "Utilities.h"
#import "CSVAnimalData.h"
#import "DetailViewController.h"
#import "FilterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Animals.h"

@interface BaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    Animals *unfilteredAnimalData;
    NSArray *unfilteredData;
    NSArray *filteredData;
    NSString *_typeOfAnimal;
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray* copiedData;
@property (nonatomic,strong)IBOutlet UISearchBar * search;

-(void)fetchEntries;
-(void)refreshData;
-(void)filterData;
@end
