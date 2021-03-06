//
//  AppDelegate.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "WeiboSDK.h"
#import <BmobSDK/Bmob.h>
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()<WeiboSDKDelegate,CLLocationManagerDelegate>{
    //1.引入框架CoreLocation 2.导入头文件
    CLLocationManager *_locationManger;//3.创建对象 定位
//CLGeocoder地理编码 1.创建地理编码对象
    CLGeocoder *_geocoder;
}

@end

@implementation AppDelegate
@synthesize wbtoken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

//初始化定位对象
    _locationManger = [[CLLocationManager alloc]init];
    
//判断定位是否可用
    if (![CLLocationManager locationServicesEnabled]) {
        ZJHLog(@"定位服务当前尚未打开");
    }
 //如果没有授权 请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManger requestAlwaysAuthorization];//请求同意
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManger.delegate = self;
        //设置定位的精度 精度越高 越耗电
        _locationManger.desiredAccuracy = kCLLocationAccuracyBest;
        //定位频率，每隔多少米定位
        CLLocationDistance distance = 10.0;
        _locationManger.distanceFilter = distance;
        //启动跟踪定位
        [_locationManger startUpdatingLocation];
        
        
    }
    
    //2.CLGeocoder地理编码     初始化
    _geocoder = [[CLGeocoder alloc]init];
    
    
    
    
    
//微博
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
//微信
    [WXApi registerApp:kAppId];
    
    [Bmob registerWithAppKey:kBmobAppk];
   
 
    
    
    
    
    
    //标签控制器
   self.tabBarVc = [[UITabBarController alloc]init];
    
    //创建被tablebar管理的控制器
   
    //主页
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *mainNav = mainStoryBoard.instantiateInitialViewController;
//    mainNav.tabBarItem.image = [UIImage imageNamed:@"53-house.png"];
    // mainNav.tabBarItem.title = @"主页";
    mainNav.tabBarItem.image = [UIImage imageNamed:@"ft_home_normal_ic.png"];
//按照图片原始状态显示
    UIImage *mainSelectedImage = [UIImage imageNamed:@"ft_home_selected_ic.png"];

    mainNav.tabBarItem.selectedImage = [mainSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    mainNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    
 //发现
    
    
 UIStoryboard *discoverStoryBoard = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    
    UINavigationController *discoverNav = discoverStoryBoard.instantiateInitialViewController;
//    discoverNav.tabBarItem.image = [UIImage imageNamed:@"71-compass.png"];
//    discoverNav.tabBarItem.title = @"发现";
    
    discoverNav.tabBarItem.image = [UIImage imageNamed:@"ft_found_normal_ic.png"];
    
//按照图片原始状态显示
    UIImage *discoverSelectedImage = [UIImage imageNamed:@"ft_found_selected_ic.png"];
    
    discoverNav.tabBarItem.selectedImage = [discoverSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    discoverNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

    
    //我
    
    
    UIStoryboard *mineStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    
    UINavigationController *mineNav = mineStoryBoard.instantiateInitialViewController;
//    mineNav.tabBarItem.image = [UIImage imageNamed:@"29-heart.png"];
//    mineNav.tabBarItem.title = @"我的";
   mineNav.tabBarItem.image = [UIImage imageNamed:@"ft_person_normal_ic.png"];
    
    mineNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
//按照图片原始状态显示
    UIImage *mineSelectedImage = [UIImage imageNamed:@"ft_person_selected_ic.png"];
    
    mineNav.tabBarItem.selectedImage = [mineSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    mineNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
  //添加标签图片
    //点击选中时候的 显示颜色
//    tabBarVc.tabBar.tintColor = [UIColor colorWithRed:27/255.0f green:185/255.0f blue:189/255.0f alpha:1.0];
    
    
    
    //添加被管理的控制器
    
    self.tabBarVc.viewControllers = @[mainNav ,discoverNav,mineNav];
    
    self.window.rootViewController = self.tabBarVc;
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark --- 微博代理方法   微信代理方法
//代理方法
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
}
//你的程序要实现和微信终端交互的具体请求与回应，因此需要实现WXApiDelegate协议的两个方法：
//onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面
-(void)onReq:(BaseReq *)req{
    
}
//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面
-(void)onResp:(BaseResp *)resp{
    
}
#pragma mark--- shareSDK 判断微博 或微信  打开

//
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
   
        return [WeiboSDK handleOpenURL:url delegate:self];
 
        return [WXApi handleOpenURL:url delegate:self];
   
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
 
        return [WeiboSDK handleOpenURL:url delegate:self];
 
        return [WXApi handleOpenURL:url delegate:self];
  
    
}
#pragma mark ---- 定位代理方法
//(CLLocationManager *)manager 当前使用定位对象
//locations返回定位的数据，是一个数组对象
//定位代理方法
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"定位 %f %f",manager.location.coordinate.longitude,manager.location.coordinate.latitude);

}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //从数组中 取出第一个位置
    CLLocation *location = [locations firstObject];
   //获取坐标 坐标系包含经度维度
    CLLocationCoordinate2D coordinate = location.coordinate;//经纬度
    ZJHLog(@"经度：%f,维度:%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
  NSLog(@"%@",location);
 //经度纬度
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    [userDefults setValue:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"lat"];
    [userDefults setValue:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"lng"];
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        NSLog(@"%@",placeMark.addressDictionary);
        
        [[NSUserDefaults standardUserDefaults]setValue:placeMark.addressDictionary[@"city"] forKey:@"city"];
        //保存
        [userDefults synchronize];
        
        
    }];
    
    
    //如果不需要实时定位，使用完即关闭定位服务
    [_locationManger stopUpdatingLocation];
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
