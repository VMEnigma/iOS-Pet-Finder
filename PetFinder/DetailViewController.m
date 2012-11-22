//
//  DetailViewController.m
//  PetFinder
//
//  Created by gregory jean baptiste on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize animal;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //can set exact shade later
    [[self view] setBackgroundColor:[UIColor lightGrayColor]];
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
}

- (void)viewDidUnload {
    dateField = nil;
    nameField = nil;
    idField = nil;
    descriptionField = nil;
    animalImageView = nil;
    [super viewDidUnload];
}
@end
