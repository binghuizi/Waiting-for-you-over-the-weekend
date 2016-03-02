//
//  LoginViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/15.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/BmobObject.h>
@interface LoginViewController ()
- (IBAction)addButton:(UIButton *)sender;
- (IBAction)delegateButton:(UIButton *)sender;
- (IBAction)updataButton:(UIButton *)sender;
- (IBAction)selectButton:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton:@"back"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addButton:(UIButton *)sender {
    
    BmobObject *user = [BmobObject objectWithClassName:@"Memberuser"];
    [user setObject:@"玛莎拉蒂" forKey:@"user_Name"];
    [user setObject:@16 forKey:@"user_Age"];
    [user setObject:@"女" forKey:@"uesr_Gender"];
    [user setObject:@"66666666" forKey:@"uesr_cellPhone"];
    
    [user setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    
    [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        ZJHLog(@"成功");
        
    }];
    
}

- (IBAction)delegateButton:(UIButton *)sender {
}

- (IBAction)updataButton:(UIButton *)sender {
}

- (IBAction)selectButton:(UIButton *)sender {
    }
@end
