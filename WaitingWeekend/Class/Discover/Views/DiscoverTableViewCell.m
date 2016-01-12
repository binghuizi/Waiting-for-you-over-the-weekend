//
//  DiscoverTableViewCell.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setDiscoverModel:(DiscoverModel *)discoverModel{
    self.headImaheView.layer.cornerRadius = 50;
    self.headImaheView.clipsToBounds = YES;
    [self.headImaheView sd_setImageWithURL:[NSURL URLWithString:discoverModel.image]
                          placeholderImage:nil];
    
    self.titleLabel.text = discoverModel.title;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
