//
//  MainTableViewCell.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MainTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
typedef enum {
    RecommendTypeActivity = 1,//推荐活动
    RecommendTypethem//推荐专题
    
}RecommendType;
@interface MainTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ActivityImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *activityDistanceBtn;

@end
@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//赋值
-(void)setMainModel:(MainModel *)mainModel{
    [self.ActivityImageView sd_setImageWithURL:[NSURL URLWithString:mainModel.image_big ] placeholderImage:nil];
    
    self.activityNameLabel.text = mainModel.title;
    self.activityPriceLabel.text = mainModel.price;
    
    if ([mainModel.type integerValue] != RecommendTypeActivity) {
        self.activityDistanceBtn.hidden = YES;
    }else{
            self.activityDistanceBtn.hidden = NO;
    }
    
}









@end
