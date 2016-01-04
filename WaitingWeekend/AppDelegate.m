//
//  AppDelegate.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   
    //标签控制器
    UITabBarController *tabBarVc = [[UITabBarController alloc]init];
    
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
  //添加标签图片
    //点击选中时候的 显示颜色
//    tabBarVc.tabBar.tintColor = [UIColor colorWithRed:27/255.0f green:185/255.0f blue:189/255.0f alpha:1.0];
    
    
    
    //添加被管理的控制器
    
    tabBarVc.viewControllers = @[mainNav ,discoverNav,mineNav];
    
    self.window.rootViewController = tabBarVc;
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
