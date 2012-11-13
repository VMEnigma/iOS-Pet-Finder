//
//  CSVAnimalController.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "CSVAnimalController.h"
#import "Utilities.h"
#import "CHCSV.h"
#import "AnimalData.h"


@interface CSVAnimalController ()
{
    NSString* _url;
}
@end

@implementation CSVAnimalController

-(id) initWithStringUrl: (NSString*)url
{
    self = [super init];
    if ( self )
    {
        _url = url;
    }
    return self;
}

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
