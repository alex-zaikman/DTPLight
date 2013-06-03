//
//  aszJsonDictionarryManip.m
//  DTPLight
//
//  Created by alex zaikman on 6/1/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszJsonDictionarryManip.h"

@interface aszJsonDictionarryManip()

+ (id) deepCopyOf:(id) obj;

+(NSString*) deepPrint:(id) obj withTab:(NSString*)tab;

+(NSMutableArray*)allObj:(id)obj forkey:(NSString*)key;

@end


@implementation aszJsonDictionarryManip


+ (id) deepCopyOf:(id) obj{
    
    id temp = [obj mutableCopy];
    
    if ([temp isKindOfClass:[NSArray class]]) {
        for (int i = 0 ; i < [temp count]; i++) {
            id copied = [[self class] deepCopyOf:[temp objectAtIndex:i]];
            [temp replaceObjectAtIndex:i withObject:copied];
        }
    } else if ([temp isKindOfClass:[NSDictionary class]]) {
        NSEnumerator *enumerator = [temp keyEnumerator];
        NSString *nextKey;
        while (nextKey = [enumerator nextObject])
            [temp setObject:[[self class] deepCopyOf:[temp objectForKey:nextKey]]
                     forKey:nextKey];
    }
    
    return temp;
    
}


+ (NSDictionary*) mergeTopLevelDictionarry:(NSDictionary*) dic1 with:(NSDictionary*) dic2{
    
    NSMutableDictionary * ret = [[self class] deepCopyOf: dic1];
    
    NSEnumerator *enumerator = [dic2 keyEnumerator];
    NSString *nextKey;
    while (nextKey = [enumerator nextObject]){
        if(![ret objectForKey:nextKey]){
            [ret setObject:[[self class] deepCopyOf:[dic2 valueForKey:nextKey]] forKey:nextKey];
        }
    }
    return [ret copy];
}

+(NSString*) deepPrint:(id) obj withTab:(NSString*)tab{
    
    NSMutableString *ret=[[NSMutableString alloc]init];
    
    if ([obj isKindOfClass:[NSArray class]]) {
        
        [ret appendString:tab];
        [ret appendString:@"[ "];
        [ret appendString:@"\n"];
        
        [ret appendString:tab];
        for (int i = 0 ; i < [obj count]; i++) {
            
            [ret appendString:[[self class] deepPrint: [obj objectAtIndex:i ] withTab:tab]];
            [ret appendString:@" ,"];
            
        }
        
        [ret appendString:@"\n"];
        [ret appendString:tab];
        [ret appendString:@" ]"];
        
    } else if ([obj isKindOfClass:[NSDictionary class]]) {
        NSEnumerator *enumerator = [obj keyEnumerator];
        NSString *nextKey;
        
        [ret appendString:tab];
        [ret appendString:@"{"];
        [ret appendString:@"\n"];
        
        while (nextKey = [enumerator nextObject]){
            
            [ret appendString:tab];
            [ret appendString:nextKey];
            [ret appendString:@" : "];
            [ret appendString:[[self class] deepPrint: [obj objectForKey:nextKey ] withTab:[tab stringByAppendingString:@"    "] ]];
            [ret appendString:@" ,"];
            [ret appendString:@"\n"];
        }
        
        [ret appendString:@"\n"];
        [ret appendString:tab];
        [ret appendString:@" }"];
        
        
    }else{
    if ([obj isKindOfClass:[NSString class]]) {
        [ret appendString:(NSString*)obj];
    }else if ([obj isKindOfClass:[NSNumber class]]) {
        [ret appendString:[(NSNumber*)obj stringValue]];
    }else{
        [ret appendString:@"err...."];
    }
    }
    
    
    return [ret copy];
    
}


+ (NSString *) dictionarryToPrintableString:(NSDictionary*) dic{
    return  [[self class]deepPrint:dic withTab:@""];
}


+(NSMutableArray*)allObj:(id)obj forkey:(NSString*)key{
    
    NSMutableArray * ret;
    
    if ([obj isKindOfClass:[NSArray class]])
    {
        for (int i = 0 ; i < [obj count]; i++)
        {
            
            if([  [obj objectAtIndex:i] isKindOfClass:[NSDictionary class]] || [  [obj objectAtIndex:i] isKindOfClass:[NSArray class]])
            {
                [ret addObjectsFromArray: [aszJsonDictionarryManip allObj:  [obj objectAtIndex:i] forkey:key]];
            }
            
        }
        
    } else if ([obj isKindOfClass:[NSDictionary class]])
    {
        NSEnumerator *enumerator = [obj keyEnumerator];
        NSString *nextKey;
        while (nextKey = [enumerator nextObject])
        {
            
            if([nextKey isEqualToString:key])
            {
                [ret addObject:[obj objectForKey:key]];
            }
            
            //and also
            if([[obj objectForKey:key] isKindOfClass:[NSDictionary class]] || [[obj objectForKey:key] isKindOfClass:[NSArray class]])
            {
                [ret addObjectsFromArray: [aszJsonDictionarryManip allObj:[obj objectForKey:key] forkey:key]];
            }
            
        }
    }
    return ret;
    
}

+(NSArray*)allObjFrom:(NSDictionary*)dic forkey:(NSString*)key{
    
    return [[aszJsonDictionarryManip allObj:[dic objectForKey:key] forkey:key]copy];
    
}




@end









