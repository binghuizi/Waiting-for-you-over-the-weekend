//
//  LoginViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/13.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property(nonatomic,retain) UILabel *userLabel;
@property(nonatomic,retain) UILabel *passordLabel;
@property(nonatomic,retain) UITextField *userTextField;

@property(nonatomic,retain) UITextField *passwordTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    [self showBackButton];
    self.navigationController.navigationBar.barTintColor = mainColor;
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    registerButton.frame = CGRectMake(0, 0, 100, 50);
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:registerButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 200, 30 )];
    self.userLabel.font = [UIFont systemFontOfSize:20];
    self.userTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 30 )];
    //self.userTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.userTextField.textAlignment = NSTextAlignmentCenter;
   // self.userTextField.backgroundColor = [UIColor colorWithRed:254.0f/255 green:216.0f/255 blue:1.0 alpha:1.0];
    //添加视图
    
    
    //LoginView *userName = [[LoginView alloc]initWithFrame:CGRectMake(30, 100, 200, 30)];
    
    self.userLabel.text = @"用户名";
    self.userTextField.placeholder = @"邮箱/手机号";
    
    self.passordLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 150, 200, 30 )];
     self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 150, 200, 30 )];
    self.passwordTextField.textAlignment = NSTextAlignmentCenter;
    self.passordLabel.text = @"密码";
   self.passwordTextField.placeholder = @"请输入密码";
    
    UIButton *dengButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 240, kWideth - 60, 40)];
    dengButton.backgroundColor = mainColor;
    [dengButton setTitle:@"登陆" forState:UIControlStateNormal];
    [dengButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    
    
    [self.view addSubview:self.userLabel];
    [self.view addSubview:self.userTextField];
    [self.view addSubview:self.passordLabel];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:dengButton];
}

//注册
-(void)registerAction{
    
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
