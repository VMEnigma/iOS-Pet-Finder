//
//  AnimalConnection.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "AnimalConnection.h"
#import "XMLAnimalController.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation AnimalConnection
@synthesize request, completionBlock;
@synthesize xmlData, csvData;

//(RG) - Initialize with NSURLREquest
- (id)initWithRequest:(NSURLRequest *)req
{
    self = [super init];
    if(self) {
        [self setRequest:req];
    }
    return self;
}

//(RG) - Start the connection
- (void)start
{
    // Initialize container for data collected from NSURLConnection
    container = [[NSMutableData alloc] init];
    
    // Spawn connection
    internalConnection = [[NSURLConnection alloc] initWithRequest:[self request]
                                                         delegate:self
                                                 startImmediately:YES];
    
    // If this is the first connection started, create the array
    if(!sharedConnectionList)
        sharedConnectionList = [[NSMutableArray alloc] init];
    
    // Add connection to array so that ARC does not destroy it
    [sharedConnectionList addObject:self];
}

//(RG) - Add dada from NSURLConnection to the NSMutableData container
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [container appendData:data];
}

//(RG) - Once connection finished loading, start the parsing process
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id rootObject = nil;
    
    // Parse using XML 
    if([self xmlData])
    {
        NSLog(@"Parsing with XML");

        XMLAnimalController *xmlParser = [[XMLAnimalController alloc] init];
        [xmlParser loadAnimalWithData:container];
        
        // Have the root object pull its data
        [[self xmlData] populateAnimalDataFromXMLParser: xmlParser.animalData];
        
        rootObject = [self xmlData];
        
    }
    //Parse using CSV
    else if([self csvData])
    {
        NSLog(@"Parsing with CSV");
        // Turn CSV file into a NSString
        NSString *csvData  = [[NSString alloc] initWithData:container encoding: NSUTF8StringEncoding];

        // Parse CSV with CHCSVParser
        NSMutableArray* csvParsedData = [[NSMutableArray alloc] initWithContentsOfCSVString:csvData encoding:NSUTF8StringEncoding error:nil];
        //Remove first row with CSV Header
        [csvParsedData removeObjectAtIndex:0];     
        
        // Have the root object pull its data
        [[self csvData] populateAnimalData: csvParsedData];

        rootObject = [self csvData];
    }
    
    // Pass the root object to the completion block supplied by the controller
    if([self completionBlock])
    {
        [self completionBlock](rootObject, nil);
        
    }
        
    
    // Destroy connection when finished
    [sharedConnectionList removeObject:self];
}

//(RG) - If there is an error, pass it back to the completion block
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    if([self completionBlock])
        [self completionBlock](nil, error);
    
    // Destroy connection when finished
    [sharedConnectionList removeObject:self];
}

@end
