//
//  CityPlaceModel.h
//  WaitingWeekend
//
//  Created by scjy on 16/3/1.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityPlaceModel : NSObject
@property(nonatomic,copy) NSString *cityId;
@property(nonatomic,copy) NSString *cityName;
- (instancetype) initWithDictionary:(NSDictionary *)dict;
@end
