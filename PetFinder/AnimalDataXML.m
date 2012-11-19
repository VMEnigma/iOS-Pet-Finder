//
//  AnimalDataXML.m
//  XMLParser
//
//  Created by Reyneiro Hernandez on 11/18/12.
//  Copyright (c) 2012 Reyneiro Hernandez. All rights reserved.
//

#import "AnimalDataXML.h"
#import "Animal.h"

@interface AnimalDataXML()
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



@implementation AnimalDataXML

-(void)populateAnimalData: (NSURL*)xmlURL
{
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    xmlParser.delegate = self;
    [xmlParser parse];
}

-(void)populateAnimalWithData:(NSData*)data
{
    data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"animals"
                                                                          ofType:@"xml"]];
    xmlParser = [[NSXMLParser alloc] initWithData:data];
    xmlParser.delegate = self;
    [xmlParser parse];
}

-(id)initSingleton
{
    if ((self = [super init]))
    {
        self.animalData = [[NSMutableArray alloc] init];
//        self.animalOfType = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}


+(AnimalDataXML*)sharedAnimalData
{

    static AnimalDataXML *_default = nil;
    
    if (_default != nil)
    {
        return _default;
    }

    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void)
                  {
                      _default = [[AnimalDataXML alloc] initSingleton];
                  });

    return _default;
}

//#pragma mark NSXMLParserDelegate

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
        [currentElementValue appendString:string];
        NSLog(@"Processing value for : %@", string);
    }
    
}  

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    
    if ([elementName isEqualToString:@"Table"]) {
        // We reached the end of the XML row
        
        [self.animalData addObject:animal];
        
        NSLog(@"Number of animals in Shelter %d", [self.animalData count]);
        
        currentAnimalProperty = kAnimalID;
        animal = nil;
        
        if (self.delegate) {
            [self.delegate animalDataXMLdidFinishParsing];
        }
        
        return;
    }
    else if ([elementName isEqualToString:@"Row"]) {
        // We reached the end of the XML row
        
        [self.animalData addObject:animal];
        
        NSLog(@"Number of animals in Shelter %d", [self.animalData count]);
        
        currentAnimalProperty = kAnimalID;
        animal = nil;
        
        return;
    }
    

    if (animal){
        switch (currentAnimalProperty) {
            case kAnimalID:
                    animal.AnimalID = currentElementValue;
                    currentAnimalProperty = kName;
                break;
            case kName:
                    animal.Name = currentElementValue;
                    currentAnimalProperty = kName;
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
