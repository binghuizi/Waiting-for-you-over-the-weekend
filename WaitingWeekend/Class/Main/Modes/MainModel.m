//
//  MainModel.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MainModel.h"
typedef enum {
    RecommendTypeActivity = 1,//推荐活动
    RecommendTypethem//推荐专题
    
}RecommendType;
@implementation MainModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
         self.type = dict[@"type"];
      
        if ([self.type integerValue] == RecommendTypeActivity) {
            self.price     = dict[@"price"];
            self.lat       = [dict[@"lat"] floatValue];
            self.lng       = [dict[@"lng"] floatValue];
            self.address   = dict[@"address"];
            self.counts    = dict[@"counts"];
            self.startTime = dict[@"startTime"];
            self.endTime   = dict[@"endTime"];
        } else{
  
  self.activityDescription = dict[@"description"];
        
        
        }
        self.image_big  = dict[@"image_big"];
        self.activityId = dict[@"activityId"];
       self.title       = dict[@"title"];
       
        
    }
    return self;
}
@end
