//
//  aszUIWebViewDelegate.h
//  DTPLight
//
//  Created by alex zaikman on 6/24/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszUIWebViewDelegate : NSObject <UIWebViewDelegate>

@property (nonatomic,strong) NSArray *data;

-(id)initWtihData:(NSArray*)data;
    


@end
