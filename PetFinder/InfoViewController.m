//
//  InfoViewController.m
//  PetFinder
//
//  Created by Raymond Gonzalez on 12/6/12.
//
//

#import "InfoViewController.h"
#import "AsyncImageView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Info";
        self.tabBarItem.title = @"Info";
        self.tabBarItem.image = [UIImage imageNamed:@"InfoTab"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Load map image using Google Maps API
    // The URL you want to load (snipped for readability)
    NSString *mapurl = @"http://maps.google.com/maps/api/staticmap?center=25.924835,-80.155269&zoom=16&markers=color:blue|25.924835,-80.155269&size=307x132&sensor=true";
    mapurl = [mapurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Escape the string
    mapurl = [mapurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.mapImage.imageURL = [NSURL URLWithString: mapurl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapImage:nil];
    [super viewDidUnload];
}
@end
