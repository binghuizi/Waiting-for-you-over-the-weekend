//
//  ActivityDetailView.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ActivityDetailView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ActivityDetailView ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *activityTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *favouriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;



@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;




@end
@implementation ActivityDetailView
-(void)awakeFromNib{
     self.mainScrollView.contentSize =CGSizeMake(kWideth, 1000);
    
}



-(void)setDataDic:(NSDictionary *)dataDic{
    NSArray *array = dataDic[@"urls"];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:nil];
    NSString *startTime = dataDic[@"new_start_date"];
     NSString *endTime = dataDic[@"new_end_date"];
    
    self.activityTimeLabel.text = [NSString stringWithFormat:@"正在进行：%@-%@",[HWTools getDateFromString:startTime],[HWTools getDateFromString:endTime]];
    
    
    self.activityTitleLabel.text = dataDic[@"title"];
    NSLog(@"%@",dataDic);
    self.favouriteLabel.text = [NSString stringWithFormat:@"%@人喜欢",dataDic[@"fav"]];
    NSString *pariceString = [NSString stringWithFormat:@"价格参考：%@",dataDic[@"pricedesc"]];
    self.activityPriceLabel.text =pariceString;
    self.addressLabel.text = dataDic[@"address"];
    self.phoneLabel.text = dataDic[@"tel"];
    
}




@end
