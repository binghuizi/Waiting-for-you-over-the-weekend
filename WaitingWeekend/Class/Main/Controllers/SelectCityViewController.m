//
//  SelectCityViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/3/1.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SelectCityViewController.h"
#import "HeaderCollectionReusableView.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "CityPlaceModel.h"
#import "MainViewController.h"
static NSString *itemIndentifier=@"itemIndentifier";
static NSString *headIndentifier=@"headIndentifier";
@interface SelectCityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray  *cityPlaceArray;
@property(nonatomic,strong) NSMutableArray  *cityPlaceId;
@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = mainColor;
    [self loandAction];
    [self showBackButton:@"camera_cancel_up"];
    
    [self.view addSubview:self.collectionView];
    
}
- (void)backAction:(UIButton *)btn{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --- 解析
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
                [self.cityPlaceId addObject:cityModel.cityId];
            }
            [self.collectionView reloadData];
            
        }else{
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];

}





#pragma mark ---- 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cityPlaceArray.count;
    }
//定义有多少个组

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    //cell.backgroundColor = [UIColor lightGrayColor];
    //cell.label.text = self.cityPlaceArray[indexPath.row];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25, 6, 100, 50)];
    label.textColor = [UIColor blackColor];
    label.text = self.cityPlaceArray[indexPath.row];
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    
    return cell;
  
    
}

//头部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        
         HeaderCollectionReusableView *headView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headIndentifier forIndexPath:indexPath];
        headView.cityLabel.text = self.cityName;
        
        return headView;
    }
    
    return nil;
}
#pragma mark ----点击方法UICollectionViewDelegate
//点击每个cell执行的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
    ////一定要判断代理存在 且 代理方法可以被执行 ！！！！
    if (self.delegateSelect && [self.delegateSelect respondsToSelector:@selector(getCityName:cityId:)]) {
    [self.delegateSelect getCityName:self.cityPlaceArray[indexPath.row] cityId:self.cityPlaceId[indexPath.row]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
#pragma mark --- 懒加载
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //布局方向  UICollectionViewScrollDirectionHorizontal 水平方向 UICollectionViewScrollDirectionVertical //垂直方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直方向
        //大小
        layout.itemSize = CGSizeMake(100, 50);
        
        //每一行间距
        layout.minimumLineSpacing = 10;
        //item间距
        layout.minimumInteritemSpacing = 1;
        //边距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 6, 5);
        //区头区尾大小
        layout.headerReferenceSize = CGSizeMake(kWideth, 200);
     //   layout.footerReferenceSize = CGSizeMake(kWideth, 50);
        
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        
         self.collectionView.backgroundColor=[UIColor clearColor];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        //注册item
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
        //注册头部
        
        
        //  [self.collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIndentifier];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIndentifier];
        
        
        
    }
    return _collectionView;
}
//city数组
-(NSMutableArray *)cityPlaceArray{
        if (_cityPlaceArray == nil) {
            self.cityPlaceArray = [NSMutableArray new];
        }
        return _cityPlaceArray;
    }

-(NSMutableArray *)cityPlaceId{
    if (_cityPlaceId == nil) {
        self.cityPlaceId = [NSMutableArray new];
    }
    return _cityPlaceId;
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
