//
//  ClassityViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ClassityViewController.h"
#import "PullingRefreshTableView.h"
#import "GoodTableViewCell.h"
#import <AFHTTPSessionManager.h>
#import "VOSegmentedControl.h"
@interface ClassityViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    NSInteger _pageCount;//定义请求页码
}
@property(nonatomic,strong) PullingRefreshTableView *tableView;
//用来显示数据的数组
@property(nonatomic,strong) NSMutableArray *showDataArray;
@property(nonatomic,strong) NSMutableArray *showArray;
@property(nonatomic,strong) NSMutableArray *touristArray;
@property(nonatomic,strong) NSMutableArray *studyArray;
@property(nonatomic,strong) NSMutableArray *familyArray;
@property(nonatomic,strong) NSMutableArray *acDataArray;
@property(nonatomic,assign) BOOL refreshing;
@property(nonatomic,retain) VOSegmentedControl *segctrl1;
@end

@implementation ClassityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //分裂列表
    
    [self showBackButton];
    
    [self getFourRequest];
   
    
   
    [self.view addSubview:self.segctrl1];
    
    [self.view addSubview:self.tableView];
    //显示多行
    //  self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableView launchRefreshing];
    
}

#pragma mark ---dataSouce
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showDataArray.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodTableViewCell *goodCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //  goodCell.backgroundColor = [UIColor magentaColor];
    
    goodCell.goodModel = self.showDataArray[indexPath.row];
    
    return goodCell;
}

//触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark ---Delegate

#pragma -
//tableview开始算新的时候调用 //下拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount = 1;
    self.refreshing = YES;
    // [self loadData];//加载数据
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
}

//上拉  Implement this method if headerOnly is false
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _pageCount +=1;
    self.refreshing = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    
    return [HWTools getSystemNowDate];
}

//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView tableViewDidScroll:scrollView];
}
//上拉
//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}

//加载数据
-(void)loadData{


}
#pragma mark -------   网络请求4个接口的数据
- (void)getFourRequest{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//6演出剧目
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",classify,@(1),@(6)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        
        
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"] integerValue];
        
        
        
        if ([status isEqualToString:@"success"] && code == 0) {
            
            
            NSDictionary *dic = resultDic[@"success"];
            NSArray *acDataArray = dic[@"acData"];
            for (NSDictionary *dict in acDataArray ) {
                GoodActivityModel *goodModel = [[GoodActivityModel alloc]initWithDictionary:dict];
                [self.showArray addObject:goodModel];
            }
        
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
//typeid = 23景点场馆
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",classify,@(1),@(23)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"] integerValue];
        
        
        
        if ([status isEqualToString:@"success"] && code == 0) {
            
            NSDictionary *dic = resultDic[@"success"];
            NSArray *acDataArray = dic[@"acData"];
            for (NSDictionary *dict in acDataArray ) {
                GoodActivityModel *goodModel = [[GoodActivityModel alloc]initWithDictionary:dict];
                [self.touristArray addObject:goodModel];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
// 22学习益智
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",classify,@(1),@(22)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        
        
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"] integerValue];
        
        
        
        if ([status isEqualToString:@"success"] && code == 0) {
            
            NSDictionary *dic = resultDic[@"success"];
            NSArray *acDataArray = dic[@"acData"];
            for (NSDictionary *dict in acDataArray ) {
                GoodActivityModel *goodModel = [[GoodActivityModel alloc]initWithDictionary:dict];
                [self.studyArray addObject:goodModel];
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
    
//21亲子
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",classify,@(1),@(21)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        
        
        
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"] integerValue];
        
        if ([status isEqualToString:@"success"] && code == 0) {
            
            NSDictionary *dic = resultDic[@"success"];
            
            NSArray *acDataArray = dic[@"acData"];
            for (NSDictionary *dict in acDataArray ) {
                GoodActivityModel *goodModel = [[GoodActivityModel alloc]initWithDictionary:dict];
                [self.familyArray addObject:goodModel];
            }
            
            //根据上一页的按钮 确定显示第几页也的数据
            
            [self showPrevisousSelect];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
}
- (void)showPrevisousSelect{
    if (self.showDataArray.count > 0) {
        [self.showDataArray removeAllObjects];
    }
    
    switch (self.classityListType) {
            
        case ClassifyListTypeShowRepertoire:
        {
            self.showDataArray = self.showArray;
        }
            break;
        case ClassifyListTypeTouristPlace:
        {
            self.showDataArray = self.touristArray;
        }
        case ClassifyListTypeStudyPUZ:
        {
            self.showDataArray = self.studyArray;
        }
            break;
        case ClassifyListTypeFamilyTrave:
        {
            self.showDataArray = self.familyArray;
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}
//懒加载
-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 44, kWideth, kHeight - 64 - 40) pullingDelegate:self];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
         self.tableView.rowHeight = 90;
    }
    return _tableView;
}
-(NSMutableArray *)showDataArray{
    if (_showDataArray == nil) {
        self.showDataArray = [NSMutableArray  new];
    }
    return _showDataArray;
}

-(NSMutableArray *)showArray{
    if (_showArray == nil) {
        self.showArray = [NSMutableArray new];
    }
    return _showArray;
}
-(NSMutableArray *)familyArray{
    if (_familyArray == nil) {
        self.familyArray = [NSMutableArray new];
    }
    return _familyArray;
}

-(VOSegmentedControl *)segctrl1{
    if (_segctrl1 == nil) {
        
        self.segctrl1=[[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"演出剧目"},
                                                                     @{VOSegmentText: @"景点场馆"},
                                                                     @{VOSegmentText: @"学习益智"},
                                                                   @{VOSegmentText: @"亲子旅行"}]];
       
// 点击之前颜色
        self.segctrl1.textColor=[UIColor grayColor];
        self.segctrl1.selectedTextColor=[UIColor colorWithRed:0 green:185/255.0f blue:189/255.0f alpha:1.0];
        self.segctrl1.selectedIndicatorColor=[UIColor colorWithRed:0 green:185/255.0f blue:189/255.0f alpha:1.0];
        self.segctrl1.contentStyle = VOContentStyleTextAlone;
        self.segctrl1.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segctrl1.backgroundColor = [UIColor whiteColor];
        self.segctrl1.indicatorColor=[UIColor colorWithRed:0 green:185/255.0f blue:189/255.0f alpha:1.0];
        self.segctrl1.allowNoSelection = NO;
        self.segctrl1.frame = CGRectMake(0 , 0, kWideth,44);
        
        
        
        self.segctrl1.indicatorThickness = 4;
        self.segctrl1.tag = self.classityListType;
        
        __block NSInteger selectIndex;
        
        [self.segctrl1 setIndexChangeBlock:^(NSInteger index) {
            selectIndex = index;
            
            NSLog(@"1: block --> %@", @(index));
        }];
        [self.segctrl1 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    
    return _segctrl1;
}

- (void)segmentCtrlValuechange:(VOSegCtrlAnimationType *)btn{
    
    
    
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
