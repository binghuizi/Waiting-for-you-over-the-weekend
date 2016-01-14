//
//  ShareView.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "WBHttpRequest+WeiboToken.h"
#import "AppDelegate.h"
#import "WeiboSDK.h"
@interface ShareView : UIView <WBHttpRequestDelegate>
{
    enum WXScene _scene;
}

@property(nonatomic,strong) UIView *shareView;
@end
