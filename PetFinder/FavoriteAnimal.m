//
//  FavoriteAnimal.m
//  PetFinder
//
//  Created by gregory jean baptiste on 11/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteAnimal.h"

@implementation FavoriteAnimal
@synthesize AnimalID, Name, Breed, Description1, Description2, Description3, Age, Size, Sex, ShelterDate, Type, validity;

-(id)initWithAnimal:(Animal *)theAnimal
{
    self = [super init];
    
    if(self)
    {
        [self setAnimalID:[theAnimal AnimalID]];
        [self setName:[theAnimal Name]];
        [self setBreed:[theAnimal Breed]];
        [self setDescription1:[theAnimal Description1]];
        [self setDescription2:[theAnimal Description2]];
        [self setDescription3:[theAnimal Description3]];
        [self setAge:[theAnimal Age]];
        [self setSize:[theAnimal Size]];
        [self setSex:[theAnimal Sex]];
        [self setShelterDate:[theAnimal ShelterDate]];
        [self setType:[theAnimal Type]];
        self.validity = YES;
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:AnimalID forKey:@"id"];
    [aCoder encodeObject:Name forKey:@"name"];
    [aCoder encodeObject:Breed forKey:@"breed"];
    [aCoder encodeObject:Description1 forKey:@"d1"];
    [aCoder encodeObject:Description2 forKey:@"d2"];
    [aCoder encodeObject:Description3 forKey:@"d3"];
    [aCoder encodeObject:Age forKey:@"age"];
    [aCoder encodeObject:Size forKey:@"size"];
    [aCoder encodeObject:Sex forKey:@"sex"];
    [aCoder encodeObject:ShelterDate forKey:@"shelterdate"];
    [aCoder encodeObject:Type forKey:@"type"];
    [aCoder encodeBool:validity forKey:@"valid"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        [self setAnimalID:[aDecoder decodeObjectForKey:@"id"]];
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setBreed:[aDecoder decodeObjectForKey:@"breed"]];
        [self setDescription1:[aDecoder decodeObjectForKey:@"d1"]];
        [self setDescription2:[aDecoder decodeObjectForKey:@"d2"]];
        [self setDescription3:[aDecoder decodeObjectForKey:@"d3"]];
        [self setAge:[aDecoder decodeObjectForKey:@"age"]];
        [self setSize:[aDecoder decodeObjectForKey:@"size"]];
        [self setSex:[aDecoder decodeObjectForKey:@"sex"]];
        [self setShelterDate:[aDecoder decodeObjectForKey:@"shelterdate"]];
        [self setType:[aDecoder decodeObjectForKey:@"type"]];
        self.validity = [aDecoder decodeBoolForKey:@"valid"];
    }
    
    return self;
}

@end
