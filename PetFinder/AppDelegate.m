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
#import "FavoritesViewController.h"
#import "AnimalData.h"
#import "CSVAnimalController.h"

@implementation AppDelegate
AnimalData* animalData;

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // - - - - - - - - - - - - - - - - - - - - - - - - -
    // Use animal data singleton

    animalData = [AnimalData sharedAnimalData];
    
    // Load animal data with CSV parser
    CSVAnimalController* dataLoader = [[CSVAnimalController alloc] initWithStringUrl:@"http://www.venexmedia.com/AnimalShelterApp/animals.csv"];
    
    //Populate singleton data with CSV parsed data
    [animalData populateAnimalData:[dataLoader getAnimalDataAsArray]];
    
    // - - - - - - - - - - - - - - - - - - - - - - - - -
    // Load views with tab bar controller
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[DogsViewController alloc] initWithNibName:@"DogsViewController" bundle:nil];
    UIViewController *viewController2 = [[CatsViewController alloc] initWithNibName:@"CatsViewController" bundle:nil];
    UIViewController *viewController3 = [[FavoritesViewController alloc] initWithNibName:@"FavoritesViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2, viewController3];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.682353 green:0.062745 blue:0.121569 alpha:1];
    self.window.rootViewController = self.tabBarController;
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
