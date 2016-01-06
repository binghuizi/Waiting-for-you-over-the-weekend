//
//  MainViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "MainModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SelectViewController.h"
#import "SearchViewController.h"
#import "ActivityDetailViewController.h"
#import "ThemViewController.h"
#import "ClassityViewController.h"
#import "GoodViewController.h"
#import "HotActivityViewController.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *listArray;//全部列表数据
//推荐活动数组
@property(nonatomic,strong) NSMutableArray *activityArray;
//推荐专题数组
@property(nonatomic,strong) NSMutableArray *specialArray;
//广告
@property(nonatomic,strong) NSMutableArray *adArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//导航栏上按钮和文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//导航栏颜色
  //  self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:27/255.0f green:185/255.0f blue:189/255.0f alpha:1.0];
    
//导航栏上navigationItem
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightBarAction)];
//1.设置导航栏上的左右按钮  把leftBarButton设置为navigationItem左按钮
    self.navigationItem.rightBarButtonItem = rightBarButton;

//左按钮
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"杭州≡" style:UIBarButtonItemStylePlain target:self action:@selector(selectCityAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
//设置按钮的透明度
   // self.automaticallyAdjustsScrollViewInsets = NO;
//注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

//自定义头部cell
    [self configTableView];

//请求网络数据
    [self requestModel];
   
}
#pragma mark -----自定义TableView头部
//自定义头部
- (void)configTableView{
    UIView *tableHeaderView = [[UIView alloc]init];
        tableHeaderView.frame = CGRectMake(0, 0, kWideth, 343);
    
    
    
#pragma mark --------给ScrollView添加图片
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWideth, 186)];
//控制滑动属性
    scrollView.contentSize = CGSizeMake(self.adArray.count*kWideth, 186);
    
    for (int i = 0; i < self.adArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWideth * i, 0, kWideth, 186)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.adArray[i]] placeholderImage:nil];
        [scrollView addSubview:imageView];
        
    }
    
    [self.tableView addSubview:scrollView];
     self.tableView.tableHeaderView = tableHeaderView;//tableView区头
#pragma mark -----添加六个按钮
    //按钮
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * kWideth / 4, 186, kWideth / 4, kWideth / 4);
        NSString *imageStr = [NSString stringWithFormat:@"home_icon_%d",i + 1];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        button.tag = i + 1;
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [tableHeaderView addSubview:button];
    }
    //精选
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * kWideth / 2 , 260 , kWideth / 2, kWideth / 4);
        NSString *imageStr = [NSString stringWithFormat:@"home_%d",i + 1];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        button.tag = 101 + i;
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [tableHeaderView addSubview:button];
    }
    
}







#pragma marks 实现代理方法
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.activityArray.count;
    }
    return  self.specialArray.count;
}
//分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    MainTableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    NSMutableArray *array = self.listArray[indexPath.section];
    mainCell.mainModel = array[indexPath.row];
    
    
    return mainCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ActivityDetailViewController *active = [[ActivityDetailViewController alloc]init];
        [self.navigationController pushViewController:active animated:YES];
        
    }else{
        ThemViewController *themVc = [[ThemViewController alloc]init];
        [self.navigationController pushViewController:themVc animated:YES];
    }
    
    
}
#pragma mark -----每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 203;
}
//左按钮选择城市
-(void)selectCityAction:(UIBarButtonItem *)bar{
    SelectViewController *selectCity = [[SelectViewController alloc]init];
    
    
    [self.navigationController presentViewController:selectCity animated:YES completion:nil];
    
}
//右按钮查找
- (void)rightBarAction{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark ------网络请求解析 获得数据
-(void)requestModel{
   NSString *str = kMainDataInterList;
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
   
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [sessionManager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  ZJHLog(@"%@",responseObject);//json数据
     
#pragma mark -----获取数据传值到model里面
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"]integerValue];
      
        if ([status isEqualToString:@"success"] && code == 0) {
            
            NSDictionary *dic = resultDic[@"success"];
//推荐活动
             NSArray *acDataArray = dic[@"acData"];
            for (NSDictionary *dic in acDataArray) {
                MainModel *mainModel = [[MainModel alloc]initWithDictionary:dic];
                [self.activityArray addObject:mainModel];
            }
            [self.listArray addObject:self.activityArray];
            
//推荐专题
            NSArray *rcDataArray = dic[@"rcData"];
            for (NSDictionary *rc in rcDataArray) {
                MainModel *model = [[MainModel alloc]initWithDictionary:rc];
                [self.specialArray addObject:model];
                
            }
            [self.listArray addObject:self.specialArray];
//刷新数据
            [self.tableView reloadData];
            
//广告
            NSArray *adDataArray = dic[@"adData"];
            for (NSDictionary *dic in adDataArray) {
                [self.adArray addObject:dic[@"url"]];
            }
//刷新数据 重新加载该方法configTableView
            [self configTableView];

//请求城市
            NSString *cityname = dic[@"cityname"];
            self.navigationItem.leftBarButtonItem.title = cityname;
            
        }else{
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
    
    
}
#pragma mark -----分区标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 26;
}
#pragma mark ------自定义分区头部view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    
    UIImageView *sectionView = [[UIImageView alloc]init];
    sectionView.frame = CGRectMake(kWideth/2 - 160, 5,320, 16);
    
    if (section == 0) {
        
       sectionView.image = [UIImage imageNamed:@"home_recommed_ac"];
      
    }else{
        
          sectionView.image = [UIImage imageNamed:@"home_recommd_rc"];
    
        }
    [view addSubview:sectionView];
 
    return view;
    
}
#pragma mark ---- 点击图片按钮   
-(void)actionButton:(UIButton *)btn{
//分类列表
    if (btn.tag == 1) {
    
        
        
        
        
    }else if (btn.tag == 2){
        
    }else if (btn.tag == 3){
        
    }else if (btn.tag == 4){
//精选活动
    }else if (btn.tag == 101){
        GoodViewController *gooVc = [[GoodViewController alloc]init];
        [self.navigationController pushViewController:gooVc animated:YES];
//热门专题
    }else if (btn.tag == 102){
        HotActivityViewController *hotVc =[[HotActivityViewController alloc]init];
        [self.navigationController pushViewController:hotVc animated:YES];
    }
}

#pragma mark -----懒加载listArray   activityArray  specialArray
-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}
-(NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        self.activityArray = [NSMutableArray new];
    }
    return _activityArray;
}

-(NSMutableArray *)specialArray{
    if (_specialArray == nil) {
        self.specialArray = [NSMutableArray new];
    }
    return _specialArray;
}

-(NSMutableArray *)adArray{
    if (_adArray == nil) {
        self.adArray = [NSMutableArray new];
    }
    return _adArray;
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
