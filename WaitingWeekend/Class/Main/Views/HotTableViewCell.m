//
//  HotTableViewCell.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/11.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "HotTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation HotTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.frame = CGRectMake(0, 0, kWideth, 90);
}
-(void)setHotModel:(HotThemModel *)hotModel{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.img] placeholderImage:nil];
    
    self.countsLabel.text = hotModel.counts;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
