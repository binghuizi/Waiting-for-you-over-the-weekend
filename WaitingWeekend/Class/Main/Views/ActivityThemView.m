//
//  ActivityThemView.m
//  WaitingWeekend
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ActivityThemView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ActivityThemView (){
    CGFloat _previousImageBottom;//保存上一次图片底部的的高度
    //上张图片的高度
    // CGFloat _previousImageHeight;
    
    CGFloat _lastLabelBottom;
}
@property(nonatomic,strong) UIScrollView *mainScrollView;
@property(nonatomic,strong) UIImageView *headImageView;
@end
@implementation ActivityThemView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView{
    [self addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headImageView];
}

//赋值
-(void)setDataDic:(NSDictionary *)dataDic{
//    self.headImageView.backgroundColor = [UIColor magentaColor];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"image"]] placeholderImage:nil];
    
    
     [self drawContentWithArray:dataDic[@"content"]];
    self.mainScrollView.contentSize = CGSizeMake(kWideth, _lastLabelBottom );
}

//活动详情
- (void)drawContentWithArray:(NSArray *)contentArray{
    for (NSDictionary *dic in contentArray) {
        
        CGFloat height = [HWTools getTextHeightWithText:dic[@"description"] Bigsize:CGSizeMake(kWideth, 1000) textFont:15.0];
        CGFloat y;
        if (_previousImageBottom > 186) {//一开始第一个label显示的时候 500  如果拓片地步的高度没有值就说明第一次加载labely的值不应该减去500
            y = 186 + _previousImageBottom - 186;
        }else{
            y = 186 + _previousImageBottom;
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

}
//懒加载
-(UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        self.mainScrollView = [[UIScrollView alloc]initWithFrame:self.frame];
        
    }
    return _mainScrollView;
}
-(UIImageView *)headImageView{
    if (_headImageView == nil) {
        self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWideth, 186)];
        
        [self.mainScrollView addSubview:self.headImageView];
    }
    return _headImageView;
}

@end
