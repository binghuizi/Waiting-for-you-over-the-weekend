//
//  ActivityDetailView.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ActivityDetailView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"
@interface ActivityDetailView (){
    CGFloat _previousImageBottom;//保存上一次图片底部的的高度
    //上张图片的高度
   // CGFloat _previousImageHeight;
    
    CGFloat _lastLabelBottom;
}
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *activityTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *favouriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;




@end
@implementation ActivityDetailView
-(void)awakeFromNib{
     self.mainScrollView.contentSize =CGSizeMake(kWideth, 5000);
    
}



-(void)setDataDic:(NSDictionary *)dataDic{

//图片
    NSArray *array = dataDic[@"urls"];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:nil];
 //时间转化
    NSString *startTime = dataDic[@"new_start_date"];
     NSString *endTime = dataDic[@"new_end_date"];
    
    self.activityTimeLabel.text = [NSString stringWithFormat:@"正在进行：%@-%@",[HWTools getDateFromString:startTime],[HWTools getDateFromString:endTime]];
    
 //活动标题
    self.activityTitleLabel.text = dataDic[@"title"];
 //收藏
    self.favouriteLabel.text = [NSString stringWithFormat:@"%@人喜欢",dataDic[@"fav"]];
    NSString *pariceString = [NSString stringWithFormat:@"价格参考：%@",dataDic[@"pricedesc"]];
//价格
    self.activityPriceLabel.text =pariceString;
//地址
    self.addressLabel.text = dataDic[@"address"];
    
    self.phoneLabel.text = dataDic[@"tel"];
//活动详情
    [self drawContentWithArray:dataDic[@"content"]];

//温馨提示
    CGFloat height = [HWTools getTextHeightWithText:dataDic[@"reminder"] Bigsize:CGSizeMake(kWideth, 1000) textFont:15.0];
    
    

    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _lastLabelBottom -110 , kWideth, height)];

   tishiLabel.text = @"温馨提示：";
    tishiLabel.textColor = [UIColor redColor];
    tishiLabel.font = [UIFont systemFontOfSize:15.0];
    [self.mainScrollView addSubview:tishiLabel];
    
    UILabel *reminderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _lastLabelBottom -50 , kWideth, height)];
    
    reminderLabel.text = dataDic[@"reminder"];
    reminderLabel.font = [UIFont systemFontOfSize:15.0];
    reminderLabel.numberOfLines = 0;
    
    [self.mainScrollView addSubview:reminderLabel];

self.mainScrollView.contentSize = CGSizeMake(kWideth, _lastLabelBottom + height + 20);

}
//活动详情
- (void)drawContentWithArray:(NSArray *)contentArray{
    for (NSDictionary *dic in contentArray) {
       
        CGFloat height = [HWTools getTextHeightWithText:dic[@"description"] Bigsize:CGSizeMake(kWideth, 1000) textFont:15.0];
                    CGFloat y;
        if (_previousImageBottom > 500) {//一开始第一个label显示的时候 500  如果拓片地步的高度没有值就说明第一次加载labely的值不应该减去500
            y = 500 + _previousImageBottom - 500;
        }else{
            y = 500 + _previousImageBottom;
        }
        //标题
        NSString *title = dic[@"title"];
        if (title != nil) {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, y, kWideth - 20, 30)];
            titleLabel.text = title;
            [self.mainScrollView addSubview:titleLabel];
            y += 30;
        }
        UILabel *label = [[UILabel alloc ]initWithFrame:CGRectMake(10, y, kWideth - 20,  height)];
        label.text = dic[@"description"];
        label.font = [UIFont systemFontOfSize:15.0];
        label.numberOfLines = 0;
        [self.mainScrollView addSubview:label];
        
            _lastLabelBottom = label.bottom + 20;
            
            
        NSArray *urlArray = dic[@"urls"];
        
//当某个段落没有图片 用上次图片的高度+10
        if (urlArray == nil) {
            _previousImageBottom = label.bottom + 10;
        }else{
            CGFloat lastImgbottom = 0.0;
            for (NSDictionary *urlDic in urlArray) {
                  CGFloat imgY;
                
                if (urlArray.count > 1) {
                    //图片不止一张
                    if (lastImgbottom == 0.0) {
                        if (title != nil) {
                            imgY = _previousImageBottom + label.height + 30 + 5;
                        }else{
                            imgY = _previousImageBottom + label.height + 5;
                        }
                    }else{
                        imgY = lastImgbottom + 10;
                    }
                 
                    
                }else{
                    //单张图片的情况
                    imgY = label.bottom;
                }
                
                
                CGFloat width = [urlDic[@"width"] integerValue];
                CGFloat imageHeight = [urlDic[@"height"] integerValue];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, imgY, kWideth - 20, (kWideth - 20)/width *imageHeight)];
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:urlDic[@"url"]] placeholderImage:nil];
                
                [self.mainScrollView addSubview:imageView];
                //每次都保留最新的高度
                _previousImageBottom = imageView.bottom + 5;
                if (urlArray.count > 1) {
                    lastImgbottom = imageView.bottom;
                }
            }
        }
        
    }
    
//    NSDictionary *dic = contentArray[0];
//    CGFloat height = [HWTools getTextHeightWithText:dic[@"description"] Bigsize:CGSizeMake(kWideth, 1000) textFont:13.0];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 500, kWideth - 20, height)];
//    label.text = dic[@"description"];
//    label.numberOfLines = 0;
//    label.font = [UIFont systemFontOfSize:15.0];
//    [self.mainScrollView addSubview:label];
//    
//    NSArray *urlsArray = dic[@"urls"];
//    CGFloat width = [urlsArray[0][@"width"] integerValue];
//    CGFloat imageHeight = [urlsArray[0][@"height"] integerValue];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, label.bottom, kWideth - 20, (kWideth - 20)/width * imageHeight)];
//    imageView.backgroundColor = [UIColor redColor];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:urlsArray[0][@"url"]] placeholderImage:nil];
//    [self.mainScrollView addSubview:imageView];
    
}


@end
