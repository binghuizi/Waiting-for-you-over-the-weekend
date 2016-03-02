//
//  SelectCityViewController.h
//  WaitingWeekend
//
//  Created by scjy on 16/3/1.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义协议
@protocol SelectCityDelegate <NSObject>

//协议方法

-(void)getCityName:(NSString *)cityName cityId:(NSString *)cityId;

@end
@interface SelectCityViewController : UIViewController

//声明代理协议的属性，关键字一定要用assign！！！
@property(nonatomic,assign)id<SelectCityDelegate>delegateSelect;
@property(nonatomic,copy) NSString *cityName;

@end
