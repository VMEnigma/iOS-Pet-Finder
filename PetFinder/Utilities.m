//
//  Utility.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "Utilities.h"

@implementation Utilities

+(NSArray*)sortArray:(NSArray*) array forProperty:(NSString*) key ascending:(BOOL) ascending
{
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray * descriptors = [NSArray arrayWithObject:valueDescriptor];
    return [[array sortedArrayUsingDescriptors:descriptors] copy];
}

+(NSString*)getContentsFromUrlAsString:(NSString*) stringUrl
{
    return [[NSString alloc]
            initWithContentsOfURL: [[NSURL alloc]
                                    initWithString: stringUrl]
            encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*)getFilterPath
{
    //Get Filter data from Plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Filter.plist"];
}

@end
