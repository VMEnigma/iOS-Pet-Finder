//
//  Utility.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "Utilities.h"

@implementation Utilities

//(RG) - Get Contents of URL as NSString
+(NSString*)getContentsFromUrlAsString:(NSString*) stringUrl
{
    return [[NSString alloc]
            initWithContentsOfURL: [[NSURL alloc]
                                    initWithString: stringUrl]
            encoding:NSUTF8StringEncoding error:nil];
}

//(RG) - Get filter plist path
+(NSString*)getFilterPath
{
    //Get Filter data from Plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Filter.plist"];
}

@end
