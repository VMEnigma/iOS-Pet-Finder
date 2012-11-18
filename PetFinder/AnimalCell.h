//
//  AnimalCell.h
//  PetFinder
//
//  Created by Raymond G on 11/17/12.
//
//

#import <UIKit/UIKit.h>
@class Animal;

@interface AnimalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *animalImage;

-(void)setAnimalModel: (Animal *)animal;

@end
