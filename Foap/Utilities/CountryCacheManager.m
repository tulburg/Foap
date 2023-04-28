//
//  CountryCacheManager.m
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

#import <Foundation/Foundation.h>
#import "CountryCacheManager.h"

static NSString * const kCountryPopulationMap = @"CountryPopulationMap";

@implementation CountryCacheManager

+ (instancetype)shared {
    static CountryCacheManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CountryCacheManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _record = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kCountryPopulationMap].mutableCopy;
        if (_record == nil) {
            _record = [[NSMutableDictionary alloc] initWithCapacity: 10];
        }
    }
    return self;
}

- (void)saveCountryWithCode:(NSString *)code population:(NSInteger)population {
    [_record setValue:@(population) forKey:code];
    [[NSUserDefaults standardUserDefaults] setObject:_record forKey:kCountryPopulationMap];
}

- (nullable NSNumber *)getCountryWithCode:(NSString *)code {
    return [self.record objectForKey:code];
}

@end
