//
//  DetailViewController.h
//  PetFinder
//
//  Created by Raymond Gonzalez on 12/2/12.
//
//

#import <UIKit/UIKit.h>
#import "Animal.h"
#import "FavoriteAnimal.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *idField;
@property (weak, nonatomic) IBOutlet UILabel *dateField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionField;
@property (weak, nonatomic) IBOutlet UIImageView *animalImageView;

@property (nonatomic, strong) id animal;
@property (nonatomic, strong) FavoriteAnimal * faveAnimal;

-(IBAction)adoptThisPet:(id)sender;

-(void)addToFavorites;
-(void)checkIfFavorite;

@end

