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
#import "AppDelegate.h"
#import "WeiboSDK.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic,retain) UIButton *headImageButton;
@property(nonatomic,strong) NSArray *imageArray;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong) UILabel *ueserName;

@property(nonatomic,strong) UIView *shareView;
@property(nonatomic,strong) UIView *grayView;
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
    
    self.grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWideth, kHeight)];
    self.grayView.backgroundColor = [UIColor darkGrayColor];
    self.grayView.alpha = 0.8;
    [windw addSubview:self.grayView];
    
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(0, kWideth + 20 , kWideth, 300)];
   
    self.shareView.backgroundColor = [UIColor colorWithRed:233/255.0f green:243/255.0f blue:245/255.0f alpha:1.0];
    
    [windw addSubview:self.shareView];
    //微博
    
    
    UIButton *weiBoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    weiBoButton.frame = CGRectMake(50, 60, 35, 35);
    [weiBoButton setImage:[UIImage imageNamed:@"sina_normal"] forState:UIControlStateNormal];
    [weiBoButton addTarget:self action:@selector(weiboShareAction:) forControlEvents:UIControlEventTouchUpInside];
    weiBoButton.tag = 1;
    [self.shareView addSubview:weiBoButton];
    
    UILabel *weiBoLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 100, 80, 40)];
    weiBoLabel.font = [UIFont systemFontOfSize:13];
    weiBoLabel.text = @"新浪微博";
    [self.shareView addSubview:weiBoLabel];
    
    //微信
    
    UIButton *weiXinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    weiXinButton.frame = CGRectMake(150, 60, 35, 35);
    [weiXinButton setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
    [weiXinButton addTarget:self action:@selector(weixinShareAction:) forControlEvents:UIControlEventTouchUpInside];
    weiXinButton.tag = 2;
    
    UILabel *weixinLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, 100, 80, 40)];
    weixinLabel.font = [UIFont systemFontOfSize:13];
    weixinLabel.text = @"微信";
    [self.shareView addSubview:weixinLabel];
    [self.shareView addSubview:weiXinButton];
    
    //盆友圈
    
    
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    friendButton .frame = CGRectMake(250, 60, 35, 35);
    [friendButton  setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    
    UILabel *friendLabel = [[UILabel alloc]initWithFrame:CGRectMake(252, 100, 80, 40)];
    friendLabel.font = [UIFont systemFontOfSize:13];
    friendLabel.text = @"朋友圈";
    
    [friendButton addTarget:self action:@selector(friendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:friendLabel];

    [self.shareView addSubview:friendButton];
    //清除
    
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    removeButton .frame = CGRectMake(20, 160,kWideth - 40, 44);
    
    [removeButton setTitle:@"取消" forState:UIControlStateNormal];
    [removeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    removeButton.backgroundColor = mainColor;
    [self.shareView addSubview:removeButton];
    
    
    
    [UIView animateWithDuration:1.0 animations:^{
        
        
    }];
}
//取消按钮
- (void)cancelAction{
    //隐藏
    self.shareView.hidden = YES;
    self.grayView.hidden = YES;
}
#pragma mark ----微博分享
//微博分享
-(void)weiboShareAction:(UIButton *)btn{
    self.shareView.hidden = YES;//隐藏
     self.grayView.hidden = YES;
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
   
//授权
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";

//第三方向微博发送请求
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    
    //request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
   //可以为空
    
    request.userInfo = nil;
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare
{
  
    
    WBMessageObject *message = [WBMessageObject message];
    
    
//    WBImageObject *image = [WBImageObject object];
//    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"meimei2" ofType:@".png"]];
//    message.imageObject = image;
   
    message.text = @"想回家!";
    
    return message;
    
}

//微信分享
#pragma mark ----微信分享-----
-(void)weixinShareAction:(UIButton *)btn{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
  
   //取消授权
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"1"];
    
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
    req.bText = YES;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}
//朋友圈
-(void)friendAction{
    

    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@""]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6" ofType:@".gif"];
    
    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    
    //朋友圈
    req.scene =WXSceneTimeline;
    
    [WXApi sendReq:req];
    
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

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    // NSString *title = nil;
    //    UIAlertView *alert = nil;
    //
    //    title = @"收到网络回调";
    //    alert = [[UIAlertView alloc] initWithTitle:title
    //                                       message:[NSString stringWithFormat:@"%@",result]
    //                                      delegate:nil
    //                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
    //                             otherButtonTitles:nil];
    //    [alert show];
    NSLog(@"收到网络回调");
    
    
    
    
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    //    NSString *title = nil;
    //    UIAlertView *alert = nil;
    //
    //    title = NSLocalizedString(@"请求异常", nil);
    //    alert = [[UIAlertView alloc] initWithTitle:title
    //                                       message:[NSString stringWithFormat:@"%@",error]
    //                                      delegate:nil
    //                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
    //                             otherButtonTitles:nil];
    //    [alert show];
    
    NSLog(@"请求异常");
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
