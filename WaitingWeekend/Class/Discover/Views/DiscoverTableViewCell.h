//
//  DiscoverTableViewCell.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"
@interface DiscoverTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImaheView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,retain) DiscoverModel *discoverModel;
@end
