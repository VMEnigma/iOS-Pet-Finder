//
//  FavoriteAnimal.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "FavoriteAnimal.h"

@implementation FavoriteAnimal

@dynamic animalID;
@dynamic name;
@dynamic type;
@dynamic breed;
@dynamic description1;
@dynamic description2;
@dynamic description3;
@dynamic sex;
@dynamic age;
@dynamic size;
@dynamic shelterDate;
@dynamic validity;
@dynamic orderingValue;

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
        [self setAge:[[theAnimal Age] intValue]];
        [self setSize:[theAnimal Size]];
        [self setSex:[theAnimal Sex]];
        [self setShelterDate:[[theAnimal ShelterDate] timeIntervalSinceReferenceDate]];
        [self setType:[theAnimal Type]];
        self.validity = YES;
    }
    
    return self;
}

@end
