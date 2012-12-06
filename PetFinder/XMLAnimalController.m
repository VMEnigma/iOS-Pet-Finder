//
//  XMLAnimalController.m
//  PetFinder
//
//  Created by Reyneiro Hernandez on 12/5/12.
//
//

#import "XMLAnimalController.h"
#import "Animal.h"

@interface XMLAnimalController()
{

NSXMLParser *xmlParser;
NSMutableString *currentElementValue;
int currentAnimalProperty;

Animal *animal;

}

typedef enum
{
    kAnimalID = 0,
    kName = 1,
    kType = 2,
    kBreed = 3,
    kDescription1 = 4,
    kSex = 5,
    kAge = 6,
    kSize = 7,
    kShelterDate = 8,
    kDescription2 = 9,
    kDescription3 = 10
    
}AnimalProperty;

@end


@implementation XMLAnimalController
@synthesize animalData, delegate;


-(BOOL)loadAnimalData: (NSURL*)xmlURL
{
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    xmlParser.delegate = self;
    return [xmlParser parse];
}

-(BOOL)loadAnimalWithData:(NSData*)data
{
    data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"animals"
                                                                          ofType:@"xml"]];
//    NSString * s = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"animals"
//                                                                       ofType:@"xml"] encoding:NSStringEncodingConversionAllowLossy error:nil];
//    
    xmlParser = [[NSXMLParser alloc] initWithStream:[[NSInputStream alloc] initWithData:data]];
//    xmlParser = [[NSXMLParser alloc] initWithData:data];
    xmlParser.delegate = self;
    return [xmlParser parse];
}

-(id)init
{
    if (self = [super init])
    {
        self.animalData = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
	
    if ([elementName isEqualToString:@"Row"]) {
        NSLog(@"Parsing Animal Row");
        animal = [[Animal alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        // init the ad hoc string with the value
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else if(animal){
        // append value to the ad hoc string
//        [currentElementValue appendString:string];
        currentElementValue = [string mutableCopy];
        NSLog(@"Processing value for : %@", string);
    }
    
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    
    if ([elementName isEqualToString:@"Table"]) {
        // We reached the end of the XML row
        
        
//        [self.animalData addObject:animal];
        
        NSLog(@"Number of animals in Shelter %d", [self.animalData count]);
        
        currentAnimalProperty = kAnimalID;
        animal = nil;
        
        [parser abortParsing];
        
        return;
    }
    else if ([elementName isEqualToString:@"Row"]) {
        // We reached the end of the XML row
        if(animal)
            [self.animalData addObject:animal];
        
        NSLog(@"Number of animals in Shelter %d", [self.animalData count]);
        
        currentAnimalProperty = kAnimalID;
        animal = nil;
        
        return;
    }
    
    
    if (animal){
        if(![currentElementValue isEqualToString:@"\n"] && ![currentElementValue isEqualToString:@""] && ![currentElementValue isEqualToString:@" "] && currentElementValue)
        switch (currentAnimalProperty) {
            case kAnimalID:
                animal.AnimalID = currentElementValue;
                currentAnimalProperty = kName;
                break;
            case kName:
                animal.Name = currentElementValue;
                currentAnimalProperty = kType;
                break;
            case kType:
                animal.Type = currentElementValue;
                currentAnimalProperty = kBreed;
                break;
            case kBreed:
                animal.Breed = currentElementValue;
                currentAnimalProperty = kDescription1;
                break;
            case kDescription1:
                animal.Description1 = currentElementValue;
                currentAnimalProperty = kDescription2;
                break;
            case kDescription2:
                animal.Description2 = currentElementValue;
                currentAnimalProperty = kDescription3;
                break;
            case kDescription3:
                animal.Description3 = currentElementValue;
                currentAnimalProperty = kSex;
                break;
            case kSex:
                animal.Sex = currentElementValue;
                currentAnimalProperty = kAge;
                break;
            case kAge:
                animal.Age = [NSNumber numberWithInt:[currentElementValue integerValue]];
                currentAnimalProperty = kSize;
                break;
            case kSize:
                animal.Size = currentElementValue;
                currentAnimalProperty = kShelterDate;
                break;
            case kShelterDate:
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy.MM.dd"];
                animal.ShelterDate = [dateFormat dateFromString: currentElementValue];
                currentAnimalProperty = kAnimalID;
            }
                break;
                
        }
    }
    
    
    currentElementValue = nil;
}

@end
