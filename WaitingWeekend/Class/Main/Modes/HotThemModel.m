//
//  HotThemModel.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/11.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "HotThemModel.h"

@implementation HotThemModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self =  [super init];
    if (self) {
        self.title = dict[@"title"];
        self.img = dict[@"img"];
        self.counts = dict[@"counts"];
        self.activityId = dict[@"id"];
        self.hotDescription = dict[@"description"];
    }
    return self;
}
@end
