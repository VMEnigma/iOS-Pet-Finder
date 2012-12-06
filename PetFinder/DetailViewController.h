//
//  DetailViewController.h
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

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

