//
//  MineViewController.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MineViewController.h"
#import "RegisterViewController.h"
#import <SDWebImage/SDImageCache.h>
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic,retain) UIButton *headImageButton;
@property(nonatomic,strong) NSArray *imageArray;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong) UILabel *ueserName;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏颜色
    self.navigationController.navigationBar.barTintColor = mainColor;
    
    [self.view addSubview:self.tableView];
    
    [self setupHeadView];
    
    self.imageArray = @[@"icon_ordered",@"icon_user",@"icon_msg",@"icon_ele",@"icon_order"];
//    
    self.titleArray =[NSMutableArray  arrayWithObjects:@[@"清除缓存",@"用户反馈",@"分享给好友",@"给我评分",@"当前版本1.0"], nil] ;
    
    
    
   // self.titleArray = [NSMutableArray arrayWithObjects:cashStr,@"清除缓存",@"用户反馈",@"分享给好友",@"给我评分",@"当前版本1.0", nil];

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SDImageCache *cash = [SDImageCache sharedImageCache];
    NSInteger cashSize = [cash getSize];
    NSString *cashStr = [NSString stringWithFormat:@"缓存大小(%.02fM))",(float)cashSize/1024/1024];
    //替换
   [self.titleArray replaceObjectAtIndex:0 withObject:cashStr];
    //[self.titleArray insertObject:cashStr atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}
//自定义
-(void)setupHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWideth, 205)];
    headView.backgroundColor = mainColor;
    [self.headImageButton setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [self.headImageButton addTarget:self action:@selector(zhucheAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.ueserName];
    [headView addSubview:self.headImageButton];
    self.tableView.tableHeaderView = headView;
    
}
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.imageArray.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indefine = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefine];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indefine];
    }
   
    
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    return cell;
    
}
//点击注册
-(void)zhucheAction{
    
}
//点击每一行触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES));
            SDImageCache *cleanCache=[SDImageCache sharedImageCache];
            //删除所有的缓存图片
            [cleanCache clearDisk];
            
             [self.titleArray replaceObjectAtIndex:0 withObject:@"清除图片缓存"];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0 ];
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
          
        }
            break;
        case 1:
          
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}
//懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
    }
    return _tableView;
}
-(UIButton *)headImageButton{
    if (_headImageButton == nil) {
        self.headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headImageButton.frame = CGRectMake(10, 50, 150, 150);
        
    }
    return _headImageButton;
}
-(UILabel *)ueserName{
    if (_ueserName == nil) {
        self.ueserName = [[UILabel alloc]initWithFrame:CGRectMake(180, 90, kWideth - 200, 40)];
        self.ueserName.text =@"欢迎来到欢乐周末";
        self.ueserName.textColor = [UIColor whiteColor];
        self.ueserName.numberOfLines = 0;
    }
    return _ueserName;
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
