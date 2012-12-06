//
//  AnimalConnection.h
//  PetFinder
//
//  Created by Raymond Gonzalez on 12/5/12.
//
//
#import <Foundation/Foundation.h>
#import "CHCSV.h"
#import "AnimalDataParser.h"

@interface AnimalConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSURLConnection *internalConnection;
    NSMutableData *container;
}

- (id)initWithRequest:(NSURLRequest *)req;

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *err);
@property (nonatomic, strong) id <AnimalDataParser> xmlData;
@property (nonatomic, strong) id <AnimalDataParser> csvData;
- (void)start;

@end
