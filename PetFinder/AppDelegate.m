//
//  AppDelegate.m
//  PetFinder
//
//  Created by  on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "DogsViewController.h"
#import "CatsViewController.h"
#import "XMLAnimalController.h"
#import "FavoritesViewController.h"
#import "AnimalData.h"
#import "CSVAnimalController.h"
#import "FavoriteAnimalStore.h"
#import "Utilities.h"

@implementation AppDelegate
AnimalData* animalData;

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Load Filter data
    
    //Get plist path in documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pListPath = [documentsDirectory stringByAppendingPathComponent:@"Filter.plist"];
    
    //Check if plist does not exist in documents directory
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:pListPath];
    
    //Copy plist to documents directory if it does not exist
    if(!success){
        NSString *defaultPlistPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Filter.plist"];
        success = [fileManager copyItemAtPath:defaultPlistPath  toPath:pListPath error:&error];
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Load Animal Data Singleton
    
    animalData = [AnimalData sharedAnimalData];
    
    int dataSourceValue = [[[NSUserDefaults standardUserDefaults] stringForKey:@"app_data_source"] integerValue];
    
    if (dataSourceValue == 1) {
        XMLAnimalController *dataloader = [[XMLAnimalController alloc] init];
        //dataloader loadAnimalData:<#(NSURL *)#>]
        if ([dataloader loadAnimalWithData:nil]) {
            [animalData populateAnimalDataFromXMLParser:dataloader.animalData];
        }
        else
        {
            [animalData populateAnimalData:nil];
        }
    }
    else
    {
        // Load animal data with CSV parser
        CSVAnimalController* dataLoader = [[CSVAnimalController alloc] initWithStringUrl:@"http://www.venexmedia.com/AnimalShelterApp/animals.csv"];
        
        //Populate singleton data with CSV parsed data
        [animalData populateAnimalData:[dataLoader getAnimalDataAsArray]];
    }
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    //Invalidate invalid favorites
    
    FavoriteAnimalStore * favorites = [FavoriteAnimalStore singletonFavorites];
    
    for(FavoriteAnimal * fave in [favorites allFavorites])
    {
        BOOL exists = NO;
        
        for(Animal * beast in [animalData animalData])
        {
            if([[fave animalID] compare:[beast AnimalID]] == NSOrderedSame)
            {
                exists = YES;
                break;
            }
        }
        
        if(exists == NO)
        {
            fave.validity = NO;
        }
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Load main views with tab bar controller
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Initialize 3 view controllers for tabs
    UIViewController *viewController1 = [[DogsViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    UIViewController *viewController2 = [[CatsViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    UIViewController *viewController3 = [[FavoritesViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    
    //Initialize 3 navigation controllers for tabs
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    UINavigationController *navigationController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    UIColor *navigationBarColor = [UIColor colorWithRed:0.172549 green:0.643137 blue:0.905882 alpha:1];
    [navigationController1.navigationBar setTintColor: navigationBarColor];
    [navigationController2.navigationBar setTintColor: navigationBarColor];
    [navigationController3.navigationBar setTintColor: navigationBarColor];
    
    //Create tab bar controller with 3 tabs and make it the rootViewController
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.682353 green:0.062745 blue:0.121569 alpha:1];
    self.tabBarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0.992157 green:0.772549 blue:0.188235 alpha:1];
    NSArray* controllers = [NSArray arrayWithObjects: navigationController1, navigationController2, navigationController3, nil];
    [self.tabBarController setViewControllers: controllers];
    
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    BOOL success = [[FavoriteAnimalStore singletonFavorites] saveChanges];
    
    if(success)
    {
        NSLog(@"Good");
    }
    else
    {
        NSLog(@"Fuck you");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
