//
//  DengLuViewController.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/15.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DengLuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *userText;

@property (strong, nonatomic) IBOutlet UIView *passwordText;
- (IBAction)touchDengLu:(id)sender;

- (IBAction)reginButton:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;


@end
