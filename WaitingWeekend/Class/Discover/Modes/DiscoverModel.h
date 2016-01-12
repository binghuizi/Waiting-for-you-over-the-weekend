//
//  DiscoverModel.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *discoverId;
@property(nonatomic,copy) NSString *image;
@property(nonatomic,copy) NSString *type;
- (instancetype) initWithDictionary:(NSDictionary *)dict;
@end
