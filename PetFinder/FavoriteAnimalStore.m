//
//  FavoriteAnimalStore.m
//  PetFinder
//
//  Created by gregory jean baptiste on 11/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteAnimalStore.h"

@implementation FavoriteAnimalStore

+(FavoriteAnimalStore *)singletonFavorites
{
    static FavoriteAnimalStore * singletonFavorites = nil;
    
    if(!singletonFavorites)
        singletonFavorites = [[super allocWithZone:nil] init];
    
    return singletonFavorites;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self singletonFavorites];
}

-(id)init
{
    self = [super init];
    
    if(self)
    {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator * psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSString * path = [self itemArchivePath];
        NSURL * storeURL = [NSURL fileURLWithPath:path];
        
        NSError * error = nil;
        
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            [NSException raise:@"Open Failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        [context setUndoManager:nil];
        
        [self loadAllItems];
    }
    
    return self;
}

-(NSArray *)allFavorites
{
    return allFavorites;
}

-(NSString *)itemArchivePath
{
    NSArray * documentDirectorties = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentDirectory = [documentDirectorties objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

-(BOOL)saveChanges
{
    NSError * err = nil;
    BOOL successful = [context save:&err];
    
    if(!successful)
    {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    
    return successful;
}

-(void)addAnimal:(FavoriteAnimal *)newFavorite
{
    [allFavorites addObject:newFavorite];
}

-(FavoriteAnimal *)createFavoriteAnimal
{
    double order;
    
    if([allFavorites count] == 0)
    {
        order = 1.0;
    }
    else
    {
        order = [[allFavorites lastObject] orderingValue] + 1.0;
    }
    
    FavoriteAnimal * newFave = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteAnimal" inManagedObjectContext:context];
    
    [newFave setOrderingValue:order];
    
    return newFave;
}

-(BOOL)isDuplicate:(Animal *)theAnimal
{
    for(FavoriteAnimal * fave in allFavorites)
    {
        if([[fave animalID] compare:[theAnimal AnimalID]] == NSOrderedSame)
        {
            NSLog(@"They are the same");
            return YES;
        }
    }
    
    return NO;
}

-(void)removeAnimal:(FavoriteAnimal *)theAnimal
{
    [context deleteObject:theAnimal];
    [allFavorites removeObjectIdenticalTo:theAnimal];
}

-(void)loadAllItems
{
    if(!allFavorites)
    {
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription * e = [[model entitiesByName] objectForKey:@"FavoriteAnimal"];
        [request setEntity:e];
        
        NSSortDescriptor * sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError * error;
        
        NSArray * result = [context executeFetchRequest:request error:&error];
        
        if(!result)
        {
            [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        allFavorites = [[NSMutableArray alloc] initWithArray:result];
    }
}


















@end
