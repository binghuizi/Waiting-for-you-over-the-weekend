//
//  MineViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MineViewController.h"
#import "RegisterViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic,retain) UIButton *headImageButton;
@property(nonatomic,strong) NSArray *imageArray;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong) UILabel *ueserName;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏颜色
    self.navigationController.navigationBar.barTintColor = mainColor;
    
    [self setupHeadView];
    [self.view addSubview:self.tableView];
    
    
    
    self.imageArray = @[@"icon_ordered",@"icon_user",@"icon_msg",@"icon_ele",@"icon_order"];
//
   // self.titleArray = @[@"清除缓存",@"用户反馈",@"分享给好友",@"给我评分",@"当前版本1.0"];
    self.titleArray =[NSMutableArray  arrayWithObjects:@"清除缓存",@"用户反馈",@"分享给好友",@"给我评分",@"当前版本1.0", nil] ;
    
    
    
   // self.titleArray = [NSMutableArray arrayWithObjects:cashStr,@"清除缓存",@"用户反馈",@"分享给好友",@"给我评分",@"当前版本1.0", nil];

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SDImageCache *cash = [SDImageCache sharedImageCache];
    NSInteger cashSize = [cash getSize];
    NSString *cashStr = [NSString stringWithFormat:@"缓存大小(%.02fM))",(float)cashSize/1024/1024];
    //替换
   [self.titleArray replaceObjectAtIndex:0 withObject:cashStr];
    //[self.titleArray insertObject:cashStr atIndex:0];
    
    NSIndexPath *indexPathf = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPathf] withRowAnimation:UITableViewRowAnimationFade];
    
}
//自定义
-(void)setupHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWideth, 205)];
    headView.backgroundColor = mainColor;
    [self.headImageButton setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [self.headImageButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.ueserName];
    [headView addSubview:self.headImageButton];
    self.tableView.tableHeaderView = headView;
    
}
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indefine = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefine];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indefine];
    }
   //去电cell选中的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSLog(@"%lu",(unsigned long)self.imageArray.count);
    NSLog(@"%lu",(unsigned long)self.titleArray.count);
    
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    return cell;
    
}
//点击注册
-(void)loginAction{
    LoginViewController *registeVc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:registeVc animated:YES];
    
}
//点击每一行触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            //清除缓存
            NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES));
            SDImageCache *cleanCache=[SDImageCache sharedImageCache];
            //删除所有的缓存图片
            [cleanCache clearDisk];
            
             [self.titleArray replaceObjectAtIndex:0 withObject:@"清除图片缓存"];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0 ];
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
          
        }
            break;
        case 1:
        { //发送邮件
            [self sendEmail];
            
        }
            break;
        case 2:
        {
        
            [self share];
        
        }
            
            break;
        case 3:
        {
            //给我评分
            NSString *str = [NSString stringWithFormat:
                             
                             @"itms-apps://itunes.apple.com/app"];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
            
            break;
        case 4:
        {
            [ProgressHUD show:@"正在检测版本....."];
            [self performSelector:@selector(checkAppVersion) withObject:nil afterDelay:2.0];
        }
            
            
            break;
        default:
            break;
    }
}
//发送邮件
- (void)sendEmail{
   
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
    picker.mailComposeDelegate = self;
    //设置主题
    [picker setSubject:@"用户反馈"];
    //设置收件人
    NSArray *toRecipients = [NSArray arrayWithObjects:@"1146623752@qq.com",
                             nil];
    
    [picker setToRecipients:toRecipients];
   
    
    // 设置邮件发送内容
    NSString *emailBody = @"请留下你宝贵的意见";
    [picker setMessageBody:emailBody isHTML:NO];
    
    //邮件发送的模态窗口
   // [self presentModalViewController:picker animated:YES];
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
    
}
//
-(void)checkAppVersion{
    [ProgressHUD showSuccess:@"检测成功..."];
}
//代理方法
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            NSLog(@"MFMailComposeResultCancelled-取消");
            break;
        case MFMailComposeResultSaved: // 保存
            NSLog(@"MFMailComposeResultSaved-保存邮件");
            break;
        case MFMailComposeResultSent: // 发送
            NSLog(@"MFMailComposeResultSent-发送邮件");
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            NSLog(@"MFMailComposeResultFailed: %@...",[error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ---- 微博分享
-(void)share{
    UIWindow *windw = [[UIApplication sharedApplication].delegate window];
    UIView *shareView = [[UIView alloc]initWithFrame:CGRectMake(0, kWideth - 350, kWideth, 350)];
   
    //微博
    shareView.backgroundColor = [UIColor lightGrayColor];
    [windw addSubview:shareView];
    UIButton *weiBoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    weiBoButton.frame = CGRectMake(20, 30, 35, 35);
    [weiBoButton setImage:[UIImage imageNamed:@"ic_com_sina_weibo_sdk_logo"] forState:UIControlStateNormal];
    [shareView addSubview:weiBoButton];
    
    //微信
    
    UIButton *weiXinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    weiXinButton.frame = CGRectMake(55, 30, 35, 35);
    [weiXinButton setImage:[UIImage imageNamed:@"icon_weixin"] forState:UIControlStateNormal];
    [shareView addSubview:weiXinButton];
    
    //盆友圈
    
    
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    friendButton .frame = CGRectMake(55, 30, 35, 35);
    [friendButton  setImage:[UIImage imageNamed:@"ic_com_sina_weibo_sdk_logo"] forState:UIControlStateNormal];
    [shareView addSubview:friendButton];
    //清除
    
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    removeButton .frame = CGRectMake(20, 100,kWideth - 40, 44);
    
    [removeButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [shareView addSubview:removeButton];
  
    
    
    [UIView animateWithDuration:1.0 animations:^{
        
        
    }];
    
    
    
        
        
   
}


//懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
    }
    return _tableView;
}
-(UIButton *)headImageButton{
    if (_headImageButton == nil) {
        self.headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headImageButton.frame = CGRectMake(10, 50, 150, 150);
        
    }
    return _headImageButton;
}
-(UILabel *)ueserName{
    if (_ueserName == nil) {
        self.ueserName = [[UILabel alloc]initWithFrame:CGRectMake(180, 90, kWideth - 200, 40)];
        self.ueserName.text =@"欢迎来到欢乐周末";
        self.ueserName.textColor = [UIColor whiteColor];
        self.ueserName.numberOfLines = 0;
    }
    return _ueserName;
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
