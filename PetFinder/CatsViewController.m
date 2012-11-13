//
//  CatsViewController.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "CatsViewController.h"

@interface CatsViewController ()

@end

@implementation CatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cats";
        self.tabBarItem.title = @"Cats";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
