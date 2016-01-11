//
//  GoodViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "GoodViewController.h"
#import "PullingRefreshTableView.h"
#import <AFHTTPSessionManager.h>
#import "GoodTableViewCell.h"
#import "ActivityDetailViewController.h"
@interface GoodViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    NSInteger _pageCount;//定义请求页码
}
@property(nonatomic,strong) PullingRefreshTableView *tableView;
@property(nonatomic,assign) BOOL refreshing;
@property(nonatomic,retain) NSMutableArray *activityArray;
@property(nonatomic,retain)NSArray *acDataArray;
@end

@implementation GoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"精选活动";
    
    [self showBackButton];
    
     [self loadData];
    

    [self.view addSubview:self.tableView];
//显示多行
  //  self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableView launchRefreshing];
    
   
}


//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  // [self loadData];//加载数据
   
    return self.activityArray.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodTableViewCell *goodCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  //  goodCell.backgroundColor = [UIColor magentaColor];
    
    goodCell.goodModel = self.activityArray[indexPath.row];
   
    return goodCell;
    
    
}
#pragma mark --- pullingdelagate
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
  //  NSLog(@"123");
    
//网络请求
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%lu",kGoodActivity,(long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         ZJHLog(@"%@",responseObject);
        
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"] integerValue];
       
       
       
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *dic = resultDic[@"success"];
            
            if (self.refreshing) {
                if (self.activityArray.count > 0) {
                    [self.activityArray removeAllObjects];
                }
            }
            
            self.acDataArray = dic[@"acData"];
           
            for (NSDictionary *dic in self.acDataArray) {
                GoodActivityModel *goodModel = [[GoodActivityModel alloc]initWithDictionary:dic];
                [self.activityArray addObject:goodModel];
            
            
            }
           
            
            [self.tableView tableViewDidFinishedLoading];//完成加载
            self.tableView.reachedTheEnd = NO;

            //刷新数据
            [self.tableView reloadData];
            
        }else{
            
        }
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];

    
}

#pragma mark ----delagate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *activityStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ActivityDetailViewController *activityVc = [activityStorybord instantiateViewControllerWithIdentifier:@"activity"];
    
    GoodActivityModel *goodModel = self.activityArray[indexPath.row];
    activityVc.activityId = goodModel.activityId ;
    
    [self.navigationController pushViewController:activityVc animated:YES];
    
    
    
}
//懒加载
-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0,0, kWideth, kHeight - 64) pullingDelegate:self];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.tableView.rowHeight = 90;
    }
    return _tableView;
}

-(NSMutableArray *)activityArray{
    if (_activityArray == nil) {
         self.activityArray = [NSMutableArray new];
    }
    return _activityArray;
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
