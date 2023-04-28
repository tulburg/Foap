//
//  CountryCacheManager.h
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

#ifndef CountryCacheManager_h
#define CountryCacheManager_h

@interface CountryCacheManager: NSObject 

@property (nonatomic, strong) NSMutableDictionary * _Nullable record;

+ (instancetype _Nullable )shared;
- (void)saveCountryWithCode:(NSString *_Nullable)code population:(NSInteger)population;
- (NSNumber * _Nullable)getCountryWithCode:(NSString *_Nullable)code;

@end

#endif /* CountryCacheManager_h */
