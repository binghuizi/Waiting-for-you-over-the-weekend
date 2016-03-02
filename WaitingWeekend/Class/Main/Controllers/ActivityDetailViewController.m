//
//  ActivityDetailViewController.m
//  WaitingWeekend
// 活动详情
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
///#import <MBProgressHUD.h>
#import "ActivityDetailView.h"
@interface ActivityDetailViewController (){
    NSString *reminder;
}

@property (strong, nonatomic) IBOutlet ActivityDetailView *activityDataView;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;

@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property(nonatomic,retain) NSString *phoneNumber;


@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动详情";
      self.tabBarController.tabBar.hidden = YES;//隐藏tabar；
//去地图界面
    [self .addressButton addTarget:self action:@selector(addressTouchAction:) forControlEvents:UIControlEventTouchUpInside];
//电话界面
    [self .phoneButton addTarget:self action:@selector(phoneTouchAction:) forControlEvents:UIControlEventTouchUpInside];
    
  
    
    
    [self showBackButton:@"back"];
    [self getModel];
}
#pragma mark ---数据
- (void)getModel{
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
     sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
        [sessionManager GET:[NSString stringWithFormat:@"%@&id=%@",kActivityDetail,self.activityId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    //三方菊花的使用
    //  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      // NSLog(@"%@",responseObject);
       // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSDictionary *dic = responseObject;
        NSString *status = dic[@"status"] ;
        NSInteger code = [dic[@"code"] intValue];
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *successDic = dic[@"success"];
            self.activityDataView.dataDic = successDic;
            _phoneNumber = dic[@"tel"];
            
        }else{
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      //  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ZJHLog(@"%@",error);
    }];
    
    
}

//电话
- (void)phoneTouchAction:(UIButton *)btn{
    //程序外打电话。打完电话之后不返回当前应用
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneNumber]]];
    
    //程序内打电话。打完电话之后还返回当前应用
    
    UIWebView *call=[[UIWebView alloc]init];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneNumber]]];
    
    
    [call loadRequest:request];
}
//地址
- (void)addressTouchAction:(UIButton *)btn{
    
    
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
