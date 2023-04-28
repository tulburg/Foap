//
//  Linker.m
//  Foap
//
//  Created by Tolu Oluwagbemi on 27/04/2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Linker.h"


NSString *populationEndpoint = @"https://jsonmock.hackerrank.com/api/countries/search?alpha2Code=";

@implementation Linker

// Method to use parameters and send a POST request
- (instancetype)initWithParameters:(NSDictionary<NSString *,id> *)parameters completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    self = [super init];
    if (self) {
        _params = parameters;
        _url = [NSURL URLWithString: populationEndpoint];
        _method = @"POST";
        _completion = completion;
    }
    return self;
}

// Method to add extra path address and send as GET request
- (instancetype)initWithPath:(NSString *)path completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    self = [super init];
    if (self) {
        _url = [NSURL URLWithString: [populationEndpoint stringByAppendingString: path]];
        _method = @"GET";
        _completion = completion;
    }
    return self;
}

// Execution function using the completion callback
- (instancetype) execute {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: _url];
    [request setHTTPMethod: _method];
    [request setValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
    if(_params != nil) {
        NSError *error;
        NSData *json = [NSJSONSerialization dataWithJSONObject: _params options: NSJSONWritingPrettyPrinted error: &error];
        if(!error) {
            [request setHTTPBody: json];
        }
    }
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        if(self.completion != nil) {
            self.completion(data, response, error);
        }
    }];
    [task resume];
    
    return self;
}
@end

