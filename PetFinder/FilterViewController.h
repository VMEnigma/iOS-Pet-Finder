//
//  FilterViewController.h
//  PetFinder
//
//  Created by Raymond G on 11/22/12.
//
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController

@property (weak, nonatomic) id delegate;


-(void)doneFilter;

@end
