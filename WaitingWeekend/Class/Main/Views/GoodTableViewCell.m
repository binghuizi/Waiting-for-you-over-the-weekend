//
//  GoodTableViewCell.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "GoodTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation GoodTableViewCell

- (void)awakeFromNib {
    // Initialization code
     self.frame=CGRectMake(0, 0,kWideth, 90);
    
}
-(void)setGoodModel:(GoodActivityModel *)goodModel{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:goodModel.image] placeholderImage:nil];
   
    self.titleLabel.text         = goodModel.title;
    self.activityPriceLabel.text = goodModel.price;
    self.ageLabel.text           = goodModel.age;
   
    [self.loveCountLabel setTitle:[NSString stringWithFormat:@"%@",goodModel.counts] forState:UIControlStateNormal];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
