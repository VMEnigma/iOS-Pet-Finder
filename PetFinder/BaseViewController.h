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
    Animals *_unfilteredAnimalData;
    NSArray *_unfilteredData;
    NSArray *_filteredData;
    NSString *_typeOfAnimal;
    BOOL _searching;
    BOOL _canSelectRows;
    NSMutableArray* _copiedData;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong)IBOutlet UISearchBar * search;

-(void)searchTableView;
-(void)fetchEntries;
-(void)refreshData;
-(void)filterData;
@end
