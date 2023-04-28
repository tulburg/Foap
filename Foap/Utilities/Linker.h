//
//  Linker.h
//  Foap
//
//  Created by Tolu Oluwagbemi on 27/04/2023.
//

#ifndef Linker_h
#define Linker_h
#import "Linker.h"
#import <UIKit/UIKit.h>


@interface Linker: NSObject

@property (nonatomic, strong) NSDictionary<NSString *, id> * _Nullable params;
@property (nonatomic, strong) NSURL * _Nullable url;
@property (nonatomic, strong) NSString * _Nullable method;
@property (nonatomic, copy) void (^ _Nullable completion)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable);

- (instancetype _Nullable ) initWithParameters: (NSDictionary<NSString * , id> * _Nullable)parameters completion:(void (^ _Nullable)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable)) completion;
- (instancetype _Nullable )initWithPath:(NSString * _Nullable)path completion:(void (^ _Nullable)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable) )completion;
- (instancetype _Nullable) execute;
@end

#endif /* Linker_h */
