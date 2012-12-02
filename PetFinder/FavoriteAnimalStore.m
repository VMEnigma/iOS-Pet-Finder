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
        NSString * path = [self itemArchivePath];
        allFavorites = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if(!allFavorites)
            allFavorites = [[NSMutableArray alloc] init];
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
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

-(BOOL)saveChanges
{
    NSString * path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:allFavorites toFile:path];
}

-(void)addAnimal:(FavoriteAnimal *)newFavorite
{
    [allFavorites addObject:newFavorite];
}

-(BOOL)isDuplicate:(Animal *)theAnimal
{
    for(FavoriteAnimal * fave in allFavorites)
    {
        if([[fave AnimalID] compare:[theAnimal AnimalID]] == NSOrderedSame)
        {
            NSLog(@"They are the same");
            return YES;
        }
    }
    
    return NO;
}

-(void)removeAnimal:(FavoriteAnimal *)theAnimal
{
    [allFavorites removeObjectIdenticalTo:theAnimal];
}






























@end
