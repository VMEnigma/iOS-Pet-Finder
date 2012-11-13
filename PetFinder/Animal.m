//
//  Animal.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "Animal.h"

@implementation Animal

@synthesize AnimalID;
@synthesize Name;
@synthesize Type;
@synthesize Breed;
@synthesize Description1;
@synthesize Description2;
@synthesize Description3;
@synthesize Sex;
@synthesize Age;
@synthesize Size;
@synthesize ShelterDate;


//initialize model
-(id)initWithAnimalId: (NSString *)animalID andName: (NSString*)name andType: (NSString*)type andBreed: (NSString*)breed andDescription1: (NSString*)description1 andDescription2: (NSString*)description2 andDescription3: (NSString*)description3 andSex: (NSString*)sex andAge: (NSNumber*)age andSize: (NSString*)size andShelterDate: (NSDate*)date
{
    self = [self init];
    if ( self )
    {
        self.AnimalID = animalID;
        self.Name = name;
        self.Type =  type;
        self.Breed = breed;
        self.Description1 = description1;
        self.Description2 = description2;
        self.Description3 = description3;
        self.Sex = sex;
        self.Age = age;
        self.Size = size;
        self.ShelterDate = date;
    }
    return self;
}

@end
