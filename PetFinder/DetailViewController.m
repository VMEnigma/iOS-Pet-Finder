//
//  DetailViewController.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "DetailViewController.h"
#import "FavoriteAnimalStore.h"
#import "FavoriteAnimal.h"
#import "AsyncImageView.h"
#import "FavoriteImageStore.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MFMailComposeViewController.h>

@implementation DetailViewController
@synthesize animal, nameField, idField, dateField, descriptionField, animalImageView, faveAnimal;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
   // UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backPressed:)];
    
    self.navigationItem.title = @"Details";
    
    //Rounded corners for animal image
    UIView *viewContainer1 = [self.view viewWithTag:2];
    viewContainer1.layer.cornerRadius = 10;
    viewContainer1.clipsToBounds = YES;

    
    [self checkIfFavorite];
}

//Set navigation bar to favorite star when animal is a favortie
-(void)checkIfFavorite
{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,28,28)];
    if([[FavoriteAnimalStore singletonFavorites] isDuplicate:animal] || faveAnimal)
    {
        [iv setImage:[UIImage imageNamed:@"Favorite-Selected"]];
    }
    else
    {
        [iv setImage:[UIImage imageNamed:@"Favorite-NotSelected"]];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iv];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!faveAnimal)
    {
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
    else
    {
        //Set Animal Name, ID and Description
        [self.nameField setText:[faveAnimal name]];
        [self.idField setText:[NSString stringWithFormat:@"#%@", [self.faveAnimal animalID]]];
        [self.descriptionField setText:[NSString stringWithFormat:@"%@ %@ %@", [self.faveAnimal description1], [self.faveAnimal description2], [self.faveAnimal description3]]];
        
        //Set Date
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yyyy"];
        
        NSDate * date = [NSDate dateWithTimeIntervalSinceReferenceDate:[faveAnimal shelterDate]];
        
        [self.dateField setText: [formatter stringFromDate:date]];
        
        //Set animal image in background
        [animalImageView setImage:[[FavoriteImageStore sharedImages] imageForKey:[faveAnimal animalID]]];
    }
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
    NSString * body;
    
    if(!faveAnimal)
    {
        body = [NSString stringWithFormat:@"I would like more information on adopting %@ (%@)",[animal Name], [animal AnimalID]];
    }
    else
    {
        body = [NSString stringWithFormat:@"I would like more information on adopting %@ (%@)",[faveAnimal name], [faveAnimal animalID]];
    }
    
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
    if(motion == UIEventSubtypeMotionShake && [self animal])
    {
        [self addToFavorites];
    }
}

-(void)addToFavorites
{
    if(![[FavoriteAnimalStore singletonFavorites] isDuplicate:animal])
    {
        NSString * theMessage  = [[NSString alloc] initWithFormat:@"%@ has been added to your favorites.", [self.animal Name]];
        
        FavoriteAnimal * fave = [[FavoriteAnimalStore singletonFavorites] createFavoriteAnimal];
        
        [fave setAnimalID:[animal AnimalID]];
        [fave setBreed:[animal Breed]];
        [fave setType:[animal Type]];
        [fave setName:[animal Name]];
        [fave setDescription1:[animal Description1]];
        [fave setDescription2:[animal Description2]];
        [fave setDescription3:[animal Description3]];
        [fave setAge:[[animal Age] intValue]];
        [fave setShelterDate:[[animal ShelterDate] timeIntervalSinceReferenceDate]];
        [fave setSize:[animal Size]];
        [fave setSex:[animal Sex]];
        [fave setValidity:YES];
        
        [[FavoriteAnimalStore singletonFavorites] addAnimal:fave];
        
        [[FavoriteImageStore sharedImages] setImage:[animalImageView image] forKey:[fave animalID]];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Success" message:theMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        NSString * theMessage = @"This animal is already on your favorites list.";
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hmm..?" message:theMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }

    [self checkIfFavorite];
}

@end
