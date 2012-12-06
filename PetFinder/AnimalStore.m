//
//  AnimalData.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/
//

#import "AnimalStore.h"
#import "Animal.h"
#import "Animals.h"
#import "Utilities.h"
#import "AnimalConnection.h"

@implementation AnimalStore

#pragma mark - Singleton
//(RG) - Singleton with Shared Animal Data
+(AnimalStore*)sharedAnimalData
{
    // Persistent instance.
    static AnimalStore *animalStore = nil;
    if(!animalStore)
        animalStore = [[AnimalStore alloc] init];
    
    return animalStore;  
}
//(RG) - Fetches Animals with Animal Connection
- (void)fetchAnimalsWithCompletion:(void (^)(Animals *obj, NSError *err))block
{
    // ###########################################################
    // ############ LOGIC TO CHECK APP SETTINGS GOES HERE
    // BOOL FOR CONNECTION TYPE: 0 = CSV, 1 = XML
    // FOR NOW TEMPORARY BOOLEAN SET TO 0 FOR CSV
    BOOL connectionSetting = [[[NSUserDefaults standardUserDefaults] stringForKey:@"app_data_source"] integerValue];
    
    // ###########################################################
    
    //Start connection for CSV (connectionSetting = 0 means it is loading with CSV)
    if (!connectionSetting)
    {
        //URL of Animals CSV
        NSURL *url = [NSURL URLWithString:@"http://www.venexmedia.com/AnimalShelterApp/animals.csv"];
        
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        //Create an empty Animals
        Animals *animals = [[Animals alloc] init];
        
        //Create a connection "actor" object that will transfer data from the server
        AnimalConnection *connection = [[AnimalConnection alloc] initWithRequest: req];
        
        // When the connection completes, this block from the controller will be executed.
        [connection setCompletionBlock:block];
        
        // Let the empty animals parse the returning data from the website datasource
        [connection setCsvData:animals];
        
        // Begin the connection
        [connection start];
        
   }

    // ###########################################################
    // ############ LOGIC TO START XML CONNECTION GOES HERE
    if(connectionSetting)
    {
        
        //URL of Animals XML
        NSURL *url = [NSURL URLWithString:@"http://www.venexmedia.com/AnimalShelterApp/animals.xml"];
        
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        //Create an empty Animals
        Animals *animals = [[Animals alloc] init];
        
        //Create a connection "actor" object that will transfer data from the server
        AnimalConnection *connection = [[AnimalConnection alloc] initWithRequest: req];
        
        // When the connection completes, this block from the controller will be executed.
        [connection setCompletionBlock:block];
        
        // Let the empty animals parse the returning data from the website datasource
        [connection setXmlData:animals];
        
        // Begin the connection
        [connection start];

        
    }   
 }

@end
