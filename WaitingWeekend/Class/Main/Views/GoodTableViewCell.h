//
//  GoodTableViewCell.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodActivityModel.h"
#import"GoodActivityModel.h"
@interface GoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ageImageView;

@property(nonatomic,strong) GoodActivityModel *goodModel;

@end
