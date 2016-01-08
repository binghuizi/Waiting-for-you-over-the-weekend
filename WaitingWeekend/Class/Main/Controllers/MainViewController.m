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

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *listArray;//全部列表数据
//推荐活动数组
@property(nonatomic,strong) NSMutableArray *activityArray;
//推荐专题数组
@property(nonatomic,strong) NSMutableArray *specialArray;
//广告
@property(nonatomic,strong) NSMutableArray *adArray;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) NSTimer *timer;//定时器用于图片滚动
@property(nonatomic,strong)UIView *tableHeaderView;




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
   // [self requestModel];
    [self startTimer];
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark -----自定义TableView头部
//自定义头部
- (void)configTableView{
        self.tableHeaderView = [[UIView alloc]init];
        self.tableHeaderView.frame = CGRectMake(0, 0, kWideth, 343);
    
    [self.tableHeaderView addSubview:self.scrollView];
//圆点个数
    self.pageControl.numberOfPages = self.adArray.count;
    [self.tableHeaderView addSubview:self.pageControl];
#pragma mark --------给ScrollView添加图片
    
    for (int i = 0; i < self.adArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWideth * i, 0, kWideth, 186)];
        
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.adArray[i][@"url"]] placeholderImage:nil];
        [self.scrollView addSubview:imageView];
        
        
        UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        touchButton.frame = imageView.frame;
        touchButton.tag = 200 + i;
        [touchButton addTarget:self action:@selector(adTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:touchButton];
        
        
    }
    
     self.tableView.tableHeaderView = self.tableHeaderView;//tableView区头
    
#pragma mark -----添加六个按钮
//按钮
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * kWideth / 4, 186, kWideth / 4, kWideth / 4);
        NSString *imageStr = [NSString stringWithFormat:@"home_icon_%d",i + 1];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        button.tag = i + 1;
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableHeaderView addSubview:button];
    }
//精选 热门专题活动
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * kWideth / 2 , 260 , kWideth / 2, kWideth / 4);
        NSString *imageStr = [NSString stringWithFormat:@"home_%d",i + 1];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        button.tag = 101 + i;
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableHeaderView addSubview:button];
    }
    
}
//懒加载scrollView
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWideth, 186)];
        self.scrollView.delegate = self;
        //控制滑动属性 可以添加5张图片
        self.scrollView.contentSize = CGSizeMake(self.adArray.count*kWideth, 186);
        //整屏滑动；
        self.scrollView.pagingEnabled = YES;
        //垂直方向是否显示滚动条NO 不显示
        self.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
//懒加载pageControl
-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
//创建圆点
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(80, 186 - 30, kWideth, 30)];

//当前选中颜色
        self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        
//点击圆点触发事件
        [self.pageControl addTarget:self action:@selector(touchActionPage:) forControlEvents:UIControlEventValueChanged];
        
        // 分页初始页数为0
        self.pageControl.currentPage = 0;
    }
    return _pageControl;
}

//首页轮番
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//scrollView的宽度
    CGFloat pageWidth = self.scrollView.frame.size.width;
    
//偏移量
    CGPoint offSet = self.scrollView.contentOffset;
//偏移量除以宽度就是圆点个数
    NSInteger pageNumber = offSet.x / pageWidth;
    self.pageControl.currentPage = pageNumber;
}
#pragma mark ----圆点动视图也偏移
- (void)touchActionPage:(UIPageControl *)pageControl{
//当前圆点个数
    NSInteger pageNumber = pageControl.currentPage;
//scrollView的宽度
    CGFloat pageWidth = self.scrollView.frame.size.width;//scrollView的宽度
//scrollView的偏移量
    self.scrollView.contentOffset = CGPointMake(pageNumber *pageWidth, 0);


}
#pragma mark ----开始定时 轮番图
- (void)startTimer{
    //防止定时器反复
    if (self.timer != nil) {
        return;
    }
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
//每两秒执行该方法
- (void)updateTimer{
    //当self.adArray.count数据组元素个数为0当对0取于时候没有意义
    if (self.adArray.count > 0) {
       
    
    //当前页数加1
    NSInteger page = self.pageControl.currentPage + 1;
   // CGFloat offSex = page *kWideth;
    CGFloat offSex = page %self.adArray.count;
    //NSLog(@"%f",offSex);
    self.pageControl.currentPage = offSex;
   // [self.scrollView setContentOffset:CGPointMake(offSex, 0) animated:YES];
    [self touchActionPage:self.pageControl];
}
}


//挡手动滑动scrollView的时候定时器依然在计算事件可能我们刚刚滑动到那  定时器有高好书法导致当前也停留的事件补不够两秒
//解决方案 scroll开始移动时 结束定时器在scroll在移动完毕时候  在启动定时器
//将要开始拖拽  定时器取消
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;//定制器停止  并niu
}
//拖拽完毕
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self startTimer];
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
    
    MainModel *mainModel = self.listArray[indexPath.section][indexPath.row];
   
    if (indexPath.section == 0) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //活动id
        ActivityDetailViewController *activeVc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"activity"];
      activeVc.activityId = mainModel.activityId;
        NSLog(@"%@",mainModel.activityId);
        [self.navigationController pushViewController:activeVc animated:YES];
        
        
        
    }else{
        //专题id
        ThemViewController *themVc = [[ThemViewController alloc]init];
        themVc.themId = mainModel.activityId;
        
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
                NSDictionary *dict = @{@"url":dic[@"url"],@"type":dic[@"type"],@"id":dic[@"id"]};
                [self.adArray addObject:dict];
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
#pragma mark ---点击移动图片
-(void)adTouchAction:(UIButton *)btn{
    //数组字典取出type类型
    NSString *type = self.adArray[btn.tag - 200][@"type"];
    if ([type integerValue] == 1) {
        UIStoryboard *stoyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        ActivityDetailViewController *actiVc = [stoyBoard instantiateViewControllerWithIdentifier:@"activity" ];
        
        
        actiVc.activityId = self.adArray[btn.tag - 200][@"id"];
        actiVc.hidesBottomBarWhenPushed = YES;//隐藏
        [self.navigationController pushViewController:actiVc animated:YES];
    }else{
        ThemViewController *themVc = [[ThemViewController alloc]init];
        themVc.themId = self.adArray[btn.tag - 200][@"id"];
        themVc.hidesBottomBarWhenPushed = YES;//隐藏tabar
        [self.navigationController pushViewController:themVc animated:YES];
    }
    
    
   
    
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
        gooVc.hidesBottomBarWhenPushed = YES;//隐藏tabar
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
