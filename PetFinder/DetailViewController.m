//
//  DetailViewController.m
//  PetFinder
//
//  Created by gregory jean baptiste on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "FavoriteAnimalStore.h"
#import "FavoriteAnimal.h"
#import "AsyncImageView.h"
#import <MessageUI/MFMailComposeViewController.h>

@implementation DetailViewController
@synthesize animal, nameField, idField, dateField, descriptionField, animalImageView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
   // UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backPressed:)];
    
  // [[self navigationItem] setLeftBarButtonItem:back];
    
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FavoriteNavButton"] style:UIBarButtonItemStylePlain target:self action:@selector(addToFavorites)];
    favoriteButton.tintColor = [UIColor colorWithRed:1.000000 green:0.627451 blue:0.168627 alpha:1];
    self.navigationItem.rightBarButtonItem = favoriteButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Set Animal Name, ID and Description
    [self.nameField setText:[animal Name]];
    [self.idField setText:[NSString stringWithFormat:@"#%@", [self.animal AnimalID]]];
    [self.descriptionField setText:[NSString stringWithFormat:@"%@ %@ %@", [self.animal Description1], [self.animal Description2], [self.animal Description3]]];
    
    //Set Date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate: [self.animal ShelterDate]];
    [self.dateField setText: stringFromDate];

    //Set animal image in background
    self.animalImageView.imageURL = [NSURL  URLWithString:[NSString stringWithFormat:@"http://www.venexmedia.com/AnimalShelterApp/images/%@.jpeg", [self.animal AnimalID]]];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    BOOL success = [self becomeFirstResponder];
    
    if(success)
    {
        NSLog(@"Win");
    }
    else
    {
        NSLog(@"Lose");
    }
    
    [super viewDidAppear:animated];
}

- (void)viewDidUnload {
    [self setNameField:nil];
    [self setIdField:nil];
    [self setDateField:nil];
    [self setDescriptionField:nil];
    [self setAnimalImageView:nil];
    [super viewDidUnload];
}

-(IBAction)adoptThisPet:(id)sender
{
    NSString * body = [NSString stringWithFormat:@"I would like more information on adopting %@ (%@)",[animal Name], [animal AnimalID]];
    MFMailComposeViewController * mfmvc = [[MFMailComposeViewController alloc] init];
    mfmvc.mailComposeDelegate = self;
    [mfmvc setSubject:@"Adoption Request"];
    [mfmvc setMessageBody:body isHTML:NO];
    [mfmvc setToRecipients:[NSArray arrayWithObject:@"gjean011@fiu.edu"]];
    
    if(mfmvc)
    {
        [self presentModalViewController:mfmvc animated:YES];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if(result == MFMailComposeResultSent)
    {
        NSLog(@"good email");
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)backPressed:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion == UIEventSubtypeMotionShake && [animal isKindOfClass:[Animal class]])
    {
        [self addToFavorites];
    }
}

-(void)addToFavorites
{
    if(![[FavoriteAnimalStore singletonFavorites] isDuplicate:animal])
    {
        NSString * theMessage  = [[NSString alloc] initWithFormat:@"%@ has been added to your favorites.", [self.animal Name]];
        
        FavoriteAnimal * fave = [[FavoriteAnimal alloc] initWithAnimal:animal];
        [[FavoriteAnimalStore singletonFavorites] addAnimal:fave];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Success" message:theMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        NSString * theMessage = @"This animal is already on your favorites list.";
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hmm..?" message:theMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }

}

@end
