//
//  SelectViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SelectViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "CityPlaceModel.h"
@interface SelectViewController ()
@property(nonatomic,strong) NSMutableArray *cityPlaceArray;
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"切换城市";
    //self.view.backgroundColor = [UIColor orangeColor];
   
   // self.navigationController.navigationBar.barTintColor =
  self.navigationController.navigationBar.barTintColor = mainColor;
    [self showBackButton:@"camera_cancel_up"];
    [self loandAction];
    self.scrollView.frame = self.view.frame;
    //pagingEnabled整屏滑动yes显示整个 默认no
    self.scrollView.pagingEnabled = YES;
    
}
- (void)backAction:(UIButton *)btn{
   
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
//解析
-(void)loandAction{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager GET:citiyPlace parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"]integerValue];
        
        if ([status isEqualToString:@"success"] && code == 0) {
        
            NSDictionary *dic = resultDic[@"success"];
             NSArray *cityListArray = dic[@"list"];
            for (NSDictionary *listDict in cityListArray) {
                CityPlaceModel *cityModel = [[CityPlaceModel alloc]initWithDictionary:listDict];
                [self.cityPlaceArray addObject:cityModel.cityName];
                
            }
            [self cityNameAction];
        
        }else{
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
}

-(void)cityNameAction{
    float width = kWideth/3;
    float height = 80.0f;
    NSInteger row;
    NSInteger cityNumber = self.cityPlaceArray.count;
    if (cityNumber % 3 == 0) {
        row = cityNumber / 3;
    }else{
        row = cityNumber / 3 + 1;
    }
    
    
    NSInteger number = 0;
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < 3; j++) {
            if (number >= cityNumber) {
                break;
            }
            UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cityBtn.frame = CGRectMake(width * j, height * i, width, height);
            [cityBtn setTitle:[NSString stringWithFormat:@"%@",self.cityPlaceArray[number]] forState:UIControlStateNormal];
            [cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cityBtn.tag = number;
            [cityBtn addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
            
            number++;
            [self.scrollView addSubview:cityBtn];
           
            UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(width * j, height * i, 1, height)];
            line1.image = [UIImage imageNamed:@"grayLine2"];
            [self.scrollView addSubview:line1];
            
            
        }
        
        UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, height * i, kWideth, 1)];
        line2.image = [UIImage imageNamed:@"grayLine2"];
        [self.scrollView addSubview:line2];
    }
    
    //是否能滚动
    
    self.scrollView.scrollEnabled = YES;
    
    [self.scrollView setContentSize:CGSizeMake(kWideth, row * height)];
    
    
}

-(void)touchAction:(UIButton *)btn{
    self.cityNameLabel.text = self.cityPlaceArray[btn.tag];
    
}


#pragma mark --- 懒加载
-(NSMutableArray *)cityPlaceArray{
    if (_cityPlaceArray == nil) {
        self.cityPlaceArray = [NSMutableArray new];
    }
    return _cityPlaceArray;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame];
    }
    return _collectionView;
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

- (IBAction)dingweiButton:(id)sender {
}
@end
