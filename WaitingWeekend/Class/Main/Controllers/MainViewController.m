//
//  MainViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//
#define kWideth  [UIScreen mainScreen].bounds.size.width
#import "MainViewController.h"
#import "MainTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "MainModel.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *listArray;//全部列表数据
//推荐活动数组
@property(nonatomic,strong) NSMutableArray *activityArray;//全部列表数据
//推荐专题数组
@property(nonatomic,strong) NSMutableArray *specialArray;//全部列表数据
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
 
    [self configTableView];
    
    //请求网络数据
    [self requestModel];
   
}
//自定义头部
- (void)configTableView{
    UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, kWideth, 343);
    view.backgroundColor = [UIColor redColor];
        self.tableView.tableHeaderView = view;//tableView区头
}







#pragma marks 代理方法
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.activityArray.count;
    }
    return  self.specialArray.count;
}
//
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    MainTableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    NSMutableArray *array = self.listArray[indexPath.section];
    mainCell.mainModel = array[indexPath.row];
    
    return mainCell;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 203;
}
//左按钮选择城市
-(void)selectCityAction:(UIBarButtonItem *)bar{
    
}
//右按钮查找
- (void)rightBarAction{
    
}
-(void)requestModel{
   NSString *str = @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1";
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
   
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [sessionManager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);//json数据
       
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
            
            NSString *cityname = dic[@"cityname"];
//请求城市
            self.navigationItem.backBarButtonItem.title = cityname;
            
        }else{
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//          return 343;
//    }
//    return 0;
//}
//自定义分区头部
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]init];
//    view.frame = CGRectMake(0, 0, kWideth, 343);
//    
//    self.tableView.tableHeaderView = view;//tableView区头
//    
//    return view;
//}




//懒加载
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
