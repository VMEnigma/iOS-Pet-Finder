//
//  DetailViewController.h
//  PetFinder
//
//  Created by gregory jean baptiste on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"

@interface DetailViewController : UIViewController
{
    
    __weak IBOutlet UILabel *dateField;
    __weak IBOutlet UILabel *nameField;
    __weak IBOutlet UILabel *idField;
    __weak IBOutlet UILabel *descriptionField;
    __weak IBOutlet UIImageView *animalImageView;
}
@property (nonatomic, strong) Animal * animal;

-(IBAction)adoptThisPet:(id)sender;

@end
