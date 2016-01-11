//
//  HotTableViewCell.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/11.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotThemModel.h"
@interface HotTableViewCell : UITableViewCell
@property(nonatomic,retain) HotThemModel *hotModel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *countsLabel;

@end
