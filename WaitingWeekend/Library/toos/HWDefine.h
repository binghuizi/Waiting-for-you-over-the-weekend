//
//  HWDefine.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
////
//http://e.kumi.cn/app/articleinfo.php?_s_=6055add057b829033bb586a3e00c5e9a&_t_=1452071715&channelid=appstore&cityid=1&id=15638&lat=34.61356779156581&lng=112.4141403843618

#ifndef HWDefine_h
#define HWDefine_h
#endif /* HWDefine_h */
//引入类目
#import "UIViewController+Common.h"
#import "UIView+Extension.h"
#import <UIKit/UIKit.h>
#import "HWTools.h"

//首页数据接口
#define kMainDataInterList    @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1"
//活动详情接口
#define kActivityDetail @"http://e.kumi.cn/app/articleinfo.php?_s_=6055add057b829033bb586a3e00c5e9a&_t_=1452071715&channelid=appstore&cityid=1&lat=34.61356779156581&lng=112.4141403843618"
//活动专题
#define  kActivityThem   @"http://e.kumi.cn/app/positioninfo.php?_s_=1b2f0563dade7abdfdb4b7caa5b36110&_t_=1452218405&channelid=appstore&cityid=1&lat=34.61349052974207&limit=30&lng=112.4139739846577&page=1"



//精选活动
#define  kGoodActivity @"http://e.kumi.cn/app/articlelist.php?_s_=a9d09aa8b7692ebee5c8a123deacf775&_t_=1452236979&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942&type=1"



//热门专题
#define  kHotThem   @"http://e.kumi.cn/app/positionlist.php?_s_=e2b71c66789428d5385b06c178a88db2&_t_=1452237051&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942&page=1"
//四个接口
#define classify @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=78284130ab87a8396ec03073eac9c50a&_t_=1452495156&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402"


typedef NS_ENUM(NSInteger,ClassifyListType){
    ClassifyListTypeShowRepertoire = 1,   //演出剧目
    ClassifyListTypeTouristPlace ,        //旅游景点
    ClassifyListTypeStudyPUZ,             //益智
    ClassifyListTypeFamilyTrave           //亲子旅游
};







