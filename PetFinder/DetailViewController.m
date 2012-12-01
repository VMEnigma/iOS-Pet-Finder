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
#import <MessageUI/MFMailComposeViewController.h>

@implementation DetailViewController
@synthesize animal;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //can set exact shade later
    [[self view] setBackgroundColor:[UIColor lightGrayColor]];
    
    UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backPressed:)];
    
    [[self navigationItem] setLeftBarButtonItem:back];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [nameField setText:[animal Name]];
    [idField setText:[NSString stringWithFormat:@"#%@", [animal AnimalID]]];
    [descriptionField setText:[animal Description1]];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateField setText:[dateFormatter stringFromDate:[animal ShelterDate]]];
    NSLog(@"%@", [animal Type]);
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
    dateField = nil;
    nameField = nil;
    idField = nil;
    descriptionField = nil;
    animalImageView = nil;
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
        if(![[FavoriteAnimalStore singletonFavorites] isDuplicate:animal])
        {
            NSString * theMessage  = [[NSString alloc] initWithFormat:@"%@ has been added to your favorites.", [animal Name]];
        
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
}

@end
