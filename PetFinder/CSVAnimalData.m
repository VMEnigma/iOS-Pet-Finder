//
//  CSVAnimalController.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "CSVAnimalData.h"
#import "Utilities.h"
#import "CHCSV.h"
#import "AnimalStore.h"


@interface CSVAnimalData ()
{
    NSString* _url;
}
@end

@implementation CSVAnimalData

//(RG) - Initialize URL
-(id) initWithStringUrl: (NSString*)url
{
    self = [super init];
    if ( self )
    {
        _url = url;
    }
    return self;
}

//(RG) - Get Array of parsed CSV Animal Data 
-(NSArray*) getAnimalDataAsArray
{
    NSString *urlContents = [Utilities getContentsFromUrlAsString:_url];
    
    //Init array with CSV parser with URL data
    NSMutableArray* urlDataParsed = [[NSMutableArray alloc] initWithContentsOfCSVString:urlContents encoding:NSUTF8StringEncoding error:nil];
    
    //remove CSV header row
    [urlDataParsed removeObjectAtIndex:0];
    
    return urlDataParsed;
}

@end
