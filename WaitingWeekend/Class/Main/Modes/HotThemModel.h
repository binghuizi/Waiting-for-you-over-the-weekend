//
//  HotThemModel.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/11.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotThemModel : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *counts;
@property(nonatomic,copy) NSString *activityId;

@property(nonatomic,copy) NSString *hotDescription;

- (instancetype) initWithDictionary:(NSDictionary *)dict;
@end
