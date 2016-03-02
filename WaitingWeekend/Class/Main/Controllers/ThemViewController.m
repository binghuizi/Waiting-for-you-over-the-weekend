//
//  ThemViewController.m
//  WaitingWeekend
// 活动专题
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ThemViewController.h"
#import <AFHTTPSessionManager.h>
#import "ActivityThemView.h"

@interface ThemViewController ()
@property(nonatomic,strong) ActivityThemView *themeView;
@end

@implementation ThemViewController

-(void)loadView{
    
    [super loadView];
    self.themeView = [[ActivityThemView alloc]initWithFrame:self.view.frame];
    //网络请求
    [self getModel];
    [self.view addSubview:self.themeView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"推荐专题";
    
    [self showBackButton:@"back"];
    
}
#pragma mark --- model
- (void)getModel{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:[NSString stringWithFormat:@"%@&id=%@",kActivityThem,self.themId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress)
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        
        NSDictionary *dic = responseObject;
       NSString *status = dic[@"status"] ;
        NSInteger code = [dic[@"code"] intValue];
        if ([status isEqualToString:@"success"] && code == 0) {
                   NSDictionary *successDic = dic[@"success"];
            self.themeView.dataDic = successDic;
         //标题
            self.navigationItem.title = dic[@"success"][@"title"];
            
           
            
            
        }else{
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
