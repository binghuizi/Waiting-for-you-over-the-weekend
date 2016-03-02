//
//  SearchViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SearchViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) NSMutableArray *activityNameArray;
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索";
    
    [self loadDate];
    [self.view addSubview:self.collectionView];
}
-(void)loadDate{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:KsearchActiviyt parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseSerializer);
      
        NSDictionary *resultDic = responseObject;
        NSString *code = resultDic[@"code"];
        NSString *status = resultDic[@"status"];
        if ([code isEqualToString:@"0"] && [status isEqualToString:@"status"]) {
            
            NSDictionary *successDic = resultDic[@"success"];
            NSArray *searchArray = successDic[@"search"];
            
            for (NSDictionary *itemDic in searchArray) {
                [self.activityNameArray addObject:itemDic[@"search_name"]];
                
            }
            
        }
        
        
    
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
    
    
    
}

#pragma mark -- collectionView 代理方法
//个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.activityNameArray.count;
}
//定义多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

#pragma mark -- 懒加载
-(NSMutableArray *)activityNameArray{
    if (_activityNameArray == nil) {
        self.activityNameArray = [NSMutableArray new];
    }
    return _activityNameArray;
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
