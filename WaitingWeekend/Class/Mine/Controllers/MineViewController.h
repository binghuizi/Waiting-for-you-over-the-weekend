//
//  MineViewController.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "WBHttpRequest+WeiboToken.h"
#import "ShareView.h"

@interface MineViewController : UIViewController<WBHttpRequestDelegate>
{
    enum WXScene _scene;
}
//@property(nonatomic,retain) ShareView *shareView2;

@end
