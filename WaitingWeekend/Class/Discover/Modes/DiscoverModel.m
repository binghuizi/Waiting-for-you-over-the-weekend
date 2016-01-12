//
//  DiscoverModel.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        self.image = dict[@"image"];
        self.discoverId = dict[@"id"];
        self.type = dict[@"type"];
    }
    return self;
}
@end
