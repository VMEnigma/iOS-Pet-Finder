//
//  Animal.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/


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

//(RG) - Initialize Model
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

//(RG) - Override Description method
- (NSString*)description
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy.MM.dd"];
    
    //Print Name, AnimalID, Type, Date
    return [NSString stringWithFormat:@"%-13s - %-10s - %-5s - %@", [Name UTF8String], [AnimalID UTF8String], [Type UTF8String], [dateFormat stringFromDate:ShelterDate]];
}

@end
