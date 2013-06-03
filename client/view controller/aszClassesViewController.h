//
//  aszClassesViewController.h
//  DTPLight
//
//  Created by alex zaikman on 6/3/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface aszClassesViewController : UICollectionViewController <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSDictionary *data;

@end
