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
@synthesize animalOfSex = _animalOfSex;
@synthesize animalOfAge = _animalOfAge;
@synthesize animalOfSize = _animalOfSize;


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
        
        
        //- - - - - - - - - - - - - - - - - - - - - -
        //Create dictionary with animal sex as key
        
        //Check if dictionary exists for type, if not then create it.
        NSArray* animalArrayOfSex = [_animalOfSex objectForKey:animalModel.Sex];
        if (animalArrayOfSex == nil)
        {
            animalArrayOfSex = [[NSMutableArray alloc]init];
            [self.animalOfSex setObject:animalArrayOfSex forKey:animalModel.Sex];
        }
        
        //Dictionary is now guaranteed to exist for type. Add the animal to the corresponding type.
        [[self.animalOfSex objectForKey: animalModel.Sex] addObject: animalModel];
        
        //- - - - - - - - - - - - - - - - - - - - - -
        //Create dictionary with animal Age as key
        
        //Check if dictionary exists for type, if not then create it.
        NSArray* animalArrayOfAge = [_animalOfAge objectForKey:animalModel.Age];
        if (animalArrayOfAge == nil)
        {
            animalArrayOfAge = [[NSMutableArray alloc]init];
            [self.animalOfAge setObject:animalArrayOfAge forKey:animalModel.Age];
        }
        
        //Dictionary is now guaranteed to exist for type. Add the animal to the corresponding type.
        [[self.animalOfAge objectForKey: animalModel.Age] addObject: animalModel];
        
        //- - - - - - - - - - - - - - - - - - - - - -
        //Create dictionary with animal Size as key
        
        //Check if dictionary exists for type, if not then create it.
        NSArray* animalArrayOfSize = [_animalOfSize objectForKey:animalModel.Size];
        if (animalArrayOfSize == nil)
        {
            animalArrayOfSize = [[NSMutableArray alloc]init];
            [self.animalOfSize setObject:animalArrayOfSize forKey:animalModel.Size];
        }
        
        //Dictionary is now guaranteed to exist for type. Add the animal to the corresponding type.
        [[self.animalOfSize objectForKey: animalModel.Size] addObject: animalModel];

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
        self.animalOfSex = [[NSMutableDictionary alloc] init];
        self.animalOfAge = [[NSMutableDictionary alloc] init];
        self.animalOfSize = [[NSMutableDictionary alloc] init];
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
    //return _default;
    
    return _default;
    
}
//return filtered animal data array
-(id)returnFilteredWithAnimalData: (id) currentData
{    
    //Get plist path in documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pListPath = [documentsDirectory stringByAppendingPathComponent:@"Filter.plist"];
    
    //load filter data array with plist
	NSArray *filterData= [[NSMutableArray alloc] initWithContentsOfFile:pListPath];
    
    // #################################### $$$$$$$$$$$$$$$$$$$$$$$$$ #################################### $$$$$$$$$$$$$$$$$$$$$$$$$
    //Check Sex Selection
    NSMutableArray *filteredSex = [[NSMutableArray alloc] init];
    NSDictionary *currentSexDictionary = [filterData objectAtIndex: 0];
    NSNumber *currentSex = [currentSexDictionary objectForKey: @"Selected"];
    switch ([currentSex intValue])
    {
        case 0:
            filteredSex = [_animalOfSex mutableArrayValueForKey:@"M"];
            break;
        case 1:
            filteredSex = [_animalOfSex mutableArrayValueForKey:@"F"];
            break;
        case 2:
            filteredSex = [_animalData mutableCopy];
            break;
    }
    //Check Size Selection
    NSMutableArray *filteredSize = [[NSMutableArray alloc] init];
    NSDictionary *currentSizeDictionary = [filterData objectAtIndex: 2];
    NSNumber *currentSize = [currentSizeDictionary objectForKey: @"Selected"];
    switch ([currentSize intValue])
    {
        case 0:
            filteredSize = [_animalOfSize mutableArrayValueForKey:@"S"];
            break;
        case 1:
            filteredSize = [_animalOfSize mutableArrayValueForKey:@"M"];
            break;
        case 2:
            filteredSize = [_animalOfSize mutableArrayValueForKey:@"L"];
            break;
        case 3:
            filteredSize = [_animalData mutableCopy];
            break;
    }
    
    
    NSMutableSet *intersection = [NSMutableSet setWithArray:filteredSex];
    [intersection intersectSet:[NSSet setWithArray:filteredSize]];
    
    NSArray *finalarray = [intersection allObjects];

//    
//    for(Animal* obj in finalarray)
//    {
//        NSLog(@"%@ - %@", obj.Sex, obj.Size);
//        
//    }

    

    
    return nil;

}
@end
