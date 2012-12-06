//
//  FavoritesViewController.h
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface FavoritesViewController : BaseViewController
//@property (strong, nonatomic) NSArray * unfilteredData;
@property (strong, nonatomic) IBOutlet UISearchBar * search;
@property BOOL searching;
@property BOOL canSelectRows;

-(IBAction)editing:(id)sender;
-(void)searchTableView;
@end
