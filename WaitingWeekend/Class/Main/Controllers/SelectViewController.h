//
//  SelectViewController.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
- (IBAction)dingweiButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;




@end
