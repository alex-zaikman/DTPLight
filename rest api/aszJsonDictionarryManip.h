//
//  aszJsonDictionarryManip.h
//  DTPLight
//
//  Created by alex zaikman on 6/1/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszJsonDictionarryManip : NSObject

+ (NSDictionary*) mergeTopLevelDictionarry:(NSDictionary*) dic1 with:(NSDictionary*) dic2;

+ (NSString *) dictionarryToPrintableString:(NSDictionary*) dic;

+ (id) deepCopyOf:(id) obj;

+(NSArray*)allObjFrom:(NSDictionary*)dic forkey:(NSString*)key;


@end
