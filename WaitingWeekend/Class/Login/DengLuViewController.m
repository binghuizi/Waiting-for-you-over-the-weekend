//
//  DengLuViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/15.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DengLuViewController.h"
#import <BmobSDK/BmobObject.h>
#import <BmobSDK/BmobQuery.h>
@interface DengLuViewController ()
- (IBAction)addButton:(UIButton *)sender;
- (IBAction)delegateButton:(UIButton *)sender;
- (IBAction)updataButton:(UIButton *)sender;
- (IBAction)selectButton:(UIButton *)sender;

@end

@implementation DengLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addButton:(UIButton *)sender {
    
    BmobObject *user = [BmobObject objectWithClassName:@"Memberuser"];
    [user setObject:@"玛莎拉蒂" forKey:@"user_Name"];
    [user setObject:@16 forKey:@"user_Age"];
    [user setObject:@"女" forKey:@"uesr_Gender"];
    [user setObject:@"66666666" forKey:@"uesr_cellPhone"];
    
    [user setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    
    [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        ZJHLog(@"成功");
        
    }];
}
//删
- (IBAction)delegateButton:(UIButton *)sender {
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Memberuser"];
    [bquery getObjectInBackgroundWithId:@"ba62e8ad7d" block:^(BmobObject *object, NSError *error){
        if (error) {
            //进行错误处理
        }
        else{
            if (object) {
                //异步删除object
                [object deleteInBackground];
                NSLog(@"删除成功");
            }
        }
    }];
}
//改
- (IBAction)updataButton:(UIButton *)sender {
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Memberuser"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"567d9c300a" block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDatatWithClassName:object.className objectId:object.objectId];
                //设置cheatMode为YES
                [obj1 setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
                //异步更新数据
                [obj1 updateInBackground];
            }
        }else{
            //进行错误处理
        }
    }];
}

- (IBAction)selectButton:(UIButton *)sender {
    
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Memberuser"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"567d9c300a" block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                NSString *playerName = [object objectForKey:@"playerName"];
                BOOL cheatMode = [[object objectForKey:@"cheatMode"] boolValue];
                NSLog(@"%@----%i",playerName,cheatMode);
            }
        }
    }];
    
    
    
}
@end
