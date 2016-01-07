//
//  HWTools.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "HWTools.h"

@implementation HWTools
#pragma mark ---时间转化相关的方法

+(NSString *)getDateFromString:(NSString *)timestamp{
    NSTimeInterval timeInterval = [timestamp doubleValue];
      NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
          
    NSDateFormatter *formater1 = [[NSDateFormatter alloc]init];
                      
        [formater1 setDateFormat:@"yyyy.MM.dd"];
                      
     NSString *showTime = [formater1 stringFromDate:date];
                      
                      
                      
    return showTime;
    
                      
}
@end
