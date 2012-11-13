//
//  DogsViewController.h
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import <UIKit/UIKit.h>

@interface DogsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong)NSArray* filteredData;
@property (nonatomic,strong)NSArray* unfilteredData;

@end
