//
//  AnimalData.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "AnimalData.h"
#import "Animal.h"

@implementation AnimalData

@synthesize animalData = _animalData;
@synthesize animalOfType = _animalOfType;


#pragma mark - Animal Data Methods
-(void)populateAnimalData: (NSArray*)dataArray
{
    //Setup NSDataFormatter to match input string
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy.MM.dd"];
    
   // , , , , , , , , , , 
    //Iterate through data once and populate collections
    for (NSArray* animalData in dataArray)
    {
        //Build animal object with model. All collections will store this.
        Animal* animalModel = [[Animal alloc]
                               initWithAnimalId:[animalData objectAtIndex:AnimalID]
                               andName:[animalData objectAtIndex:Name]
                               andType:[animalData objectAtIndex:Type]
                               andBreed:[animalData objectAtIndex:Breed]
                               andDescription1:[animalData objectAtIndex:Description1]
                               andDescription2:[animalData objectAtIndex:Description2]
                               andDescription3:[animalData objectAtIndex:Description3]
                               andSex:[animalData objectAtIndex:Sex]
                               andAge:[animalData objectAtIndex:Age]
                               andSize:[animalData objectAtIndex:AnimalSize]
                               andShelterDate:[dateFormat dateFromString:[animalData objectAtIndex:ShelterDate]]];
        
        //Add object to general array
        [self.animalData addObject: animalModel];
        
        //- - - - - - - - - - - - - - - - - - - - - - 
        //Create dictionary with animal type as key
        
        //Check if dictionary exists for type, if not then create it.
        NSArray* animalArrayOfType = [_animalOfType objectForKey:animalModel.Type];
        if (animalArrayOfType == nil)
        {
            animalArrayOfType = [[NSMutableArray alloc]init];
            [self.animalOfType setObject:animalArrayOfType forKey:animalModel.Type];
        }
        
        //Dictionary is now guaranteed to exist for type. Add the animal to the corresponding type.
        [[self.animalOfType objectForKey: animalModel.Type] addObject: animalModel];
    }
}


#pragma mark - Singleton
//Singleton initalizer
-(id)initSingleton
{
    if ((self = [super init]))
    {
        // Initialization code here.
        self.animalData = [[NSMutableArray alloc] init];
        self.animalOfType = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

//Singleton with Shared Animal Data
+(AnimalData*)sharedAnimalData
{
    // Persistent instance.
    static AnimalData *_default = nil;
    
    // Small optimization to avoid wasting time after the
    // singleton being initialized.
    if (_default != nil)
    {
        return _default;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // Allocates once with Grand Central Dispatch (GCD) routine.
    // It's thread safe.
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void)
                  {
                      _default = [[AnimalData alloc] initSingleton];
                  });
#else
    // Allocates once using the old approach, it's slower.
    // It's thread safe.
    @synchronized([MySingleton class])
    {
        // The synchronized instruction will make sure,
        // that only one thread will access this point at a time.
        if (_default == nil)
        {
            _default = [[MySingleton alloc] initSingleton];
        }
    }
#endif
    return _default;
}
@end
