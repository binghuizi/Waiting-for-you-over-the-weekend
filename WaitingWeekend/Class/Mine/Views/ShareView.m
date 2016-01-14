//
//  ShareView.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configAction];
    }
    return self;
}
- (void)configAction{
    UIWindow *windw = [[UIApplication sharedApplication].delegate window];
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(0, kWideth + 20 , kWideth, 200)];
    self.shareView.backgroundColor = [UIColor colorWithRed:233/255.0f green:243/255.0f blue:245/255.0f alpha:1.0];
    [windw addSubview:self.shareView];
    //微博
    
    
    UIButton *weiBoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    weiBoButton.frame = CGRectMake(50, 60, 35, 35);
    [weiBoButton setImage:[UIImage imageNamed:@"sina_normal"] forState:UIControlStateNormal];
    [weiBoButton addTarget:self action:@selector(weiboShareAction:) forControlEvents:UIControlEventTouchUpInside];
    weiBoButton.tag = 1;
    [self.shareView addSubview:weiBoButton];
    
    //微信
    
    UIButton *weiXinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    weiXinButton.frame = CGRectMake(150, 60, 35, 35);
    [weiXinButton setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
    [weiXinButton addTarget:self action:@selector(weixinShareAction:) forControlEvents:UIControlEventTouchUpInside];
    weiXinButton.tag = 2;
    [self.shareView addSubview:weiXinButton];
    
    //盆友圈
    
    
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    friendButton .frame = CGRectMake(250, 60, 35, 35);
    [friendButton  setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
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
    
}
#pragma mark ----微博分享
//微博分享
-(void)weiboShareAction:(UIButton *)btn{
    self.shareView.hidden = YES;//隐藏
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    myDelegate.buttonTag = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
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
    
    
    WBImageObject *image = [WBImageObject object];
    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"meimei2" ofType:@".png"]];
    message.imageObject = image;
    
    
    
    return message;
    
}

//微信分享
#pragma mark ----微信分享-----
-(void)weixinShareAction:(UIButton *)btn{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    myDelegate.buttonTag = [NSString stringWithFormat:@"%lu",(long)btn.tag];
    //取消授权
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"1"];
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
    req.bText = YES;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}

@end
