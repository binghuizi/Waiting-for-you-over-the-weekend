//
//  CityPlaceModel.m
//  WaitingWeekend
//
//  Created by scjy on 16/3/1.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "CityPlaceModel.h"

@implementation CityPlaceModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.cityId = dict[@"cat_id"];
        self.cityName = dict[@"cat_name"];
        
    }
    return self;
}
@end
