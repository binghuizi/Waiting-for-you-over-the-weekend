//
//  ActivityDetailViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <MBProgressHUD.h>
@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动详情";
    
    [self showBackButton];
   // [self getModel];
}
#pragma mark ---数据
- (void)getModel{
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
     sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    [sessionManager GET:[NSString stringWithFormat:@"%@&id=%@",kActivityDetail,self.activityId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ZJHLog(@"%@",error);
    }];
    
    
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

@end
