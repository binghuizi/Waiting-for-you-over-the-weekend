//
//  DiscoverViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverTableViewCell.h"
#import "PullingRefreshTableView.h"
#import <AFHTTPSessionManager.h>
#import "ProgressHUD.h"
#import "DiscoverModel.h"
@interface DiscoverViewController () <UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    NSInteger _pageCount;//定义请求页码
}
@property(nonatomic,retain) UITableView *maxTableView;
@property(nonatomic,strong) PullingRefreshTableView *tableView;
@property(nonatomic,assign) BOOL refreshing;
@property(nonatomic,retain) NSMutableArray *likeArray;

@property(nonatomic,strong)UIView *tableHeaderView;

//@property(nonatomic,retain) UITableView *tableView;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //多余的tableView内容
    // self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadData];
    
    [self.view addSubview:self.maxTableView];
    //自定义头部cell
    [self configTableView];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
 //自定义头部cell
- (void)configTableView{
    self.tableHeaderView = [[UIView alloc]init];
    self.tableHeaderView.frame = CGRectMake(0, 0, kWideth, 343);
   // [self.maxTableView addSubview:self.tableHeaderView];
    [self.tableHeaderView addSubview:self.tableView];
    
    self.maxTableView.tableHeaderView = self.tableView;
}
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.likeArray.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *inden = @"indentifer";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inden];
//    if (cell == nil ) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:inden];
//    }
//    //M_PI   180度
//   ///cell.transform = CGAffineTransformMakeRotation(M_PI/2 *3);//旋转
//    cell.transform=CGAffineTransformMakeRotation(-(M_PI+M_PI_2));
//    cell.textLabel.text = @"6666";
//    cell.backgroundColor = [UIColor lightGrayColor];
    
    DiscoverTableViewCell *discoverCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  //  discoverCell.transform = CGAffineTransformMakeRotation(-(M_PI+M_PI_2));//旋转
    
    discoverCell.discoverModel = self.likeArray[indexPath.row];
    
    return discoverCell;
}
//点击触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark --- pullingdelagate
//tableview开始算新的时候调用 //下拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount = 1;
    self.refreshing = YES;
    // [self loadData];//加载数据
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
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
//    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
//    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    AFHTTPSessionManager *sessionMangager = [[AFHTTPSessionManager alloc]init];
    sessionMangager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [ProgressHUD show:@"加载中......"];
    
    [sessionMangager GET:kDiscover parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        [ProgressHUD showSuccess:@"加载成功"];
        
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"] integerValue];
        if ([status isEqualToString:@"success"] && code == 0) {
          
            NSDictionary *succDic = resultDic[@"success"];
            NSArray *likeArray = succDic[@"like"];
            for (NSDictionary *dic in likeArray) {
                DiscoverModel *discoverModel = [[DiscoverModel alloc]initWithDictionary:dic];
                [self.likeArray addObject:discoverModel];
            }
            NSLog(@"%ld",(unsigned long)self.likeArray.count);
        }
        
        [self.tableView tableViewDidFinishedLoading];//完成加载
        self.tableView.reachedTheEnd = NO;
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];
    


}
//标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"大家都喜欢";
}
#pragma mark --- 懒加载
-(PullingRefreshTableView *)tableView{
    //CGRectMake(100, -80, kWideth - 200, kWideth)
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
       // self.tableView.transform=CGAffineTransformMakeRotation(-M_PI_2);
        
        [self.tableView setHeaderOnly:YES];//下面不加载了
        self.tableView.rowHeight = 128;
    }
    return _tableView;
}
-(UITableView *)maxTableView{
    if (_maxTableView == nil) {
        self.maxTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        self.maxTableView.rowHeight = 100;
    }
    return _maxTableView;
}

-(NSMutableArray *)likeArray{
    if (_likeArray == nil) {
        self.likeArray = [NSMutableArray new];
    }
    return _likeArray;
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
