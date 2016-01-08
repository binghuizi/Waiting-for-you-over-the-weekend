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
+(CGFloat )getTextHeightWithText:(NSString *)text   Bigsize:(CGSize)bigSize textFont:(CGFloat)font{
    
    CGRect textRect = [text boundingRectWithSize:bigSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return textRect.size.height;
}

+ (NSDate *)getSystemNowDate{
    //创建一个NSDataFormatter显示刷新时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:dateStr];
    return date;
}
@end
