//
//  HWDefine.h
//  WaitingWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
////
//http://e.kumi.cn/app/articleinfo.php?_s_=6055add057b829033bb586a3e00c5e9a&_t_=1452071715&channelid=appstore&cityid=1&id=15638&lat=34.61356779156581&lng=112.4141403843618
/Users/scjy/Desktop/UI---阶段/A段项目/sssss/Waiting-for-you-over-the-weekend/WaitingWeekend/Library/微信/libWeChatSDK.a
#ifndef HWDefine_h
#define HWDefine_h
#endif /* HWDefine_h */
//引入类目
#import "UIViewController+Common.h"
#import "UIView+Extension.h"
#import <UIKit/UIKit.h>
#import "HWTools.h"

#define RGB(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]
#define SeparatorColor RGB(228, 228, 228) //222 160 改成170
#define mainColor  [UIColor colorWithRed:27/255.0f green:196/255.0f blue:200/255.0f alpha:1.0]
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


//演出节目
#define  kShowProgramme   @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=1e925924e35606ad84e25cc4f8181052&_t_=1452419774&channelid=appstore&cityid=1&lat=34.61352375700717&limit=30&lng=112.4140695882542&typeid=6"
//景点场馆
#define  kSpotsVenue      @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=07098ba9b3c880d9f0861206cf8d6208&_t_=1452420865&channelid=appstore&cityid=1&lat=34.61353403229416&limit=30&lng=112.4140383019175&page=1&typeid=23"
//学习益智
#define  kStudyIntellect   @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=b6912dc77e7e12a24c48fc7bbef0c0b2&_t_=1452423875&channelid=appstore&cityid=1&lat=34.61355699177267&limit=30&lng=112.414074144134&typeid=22"
//亲子旅游
#define  kTour  @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=64084c92a84b719e3d5c844c8bade788&_t_=1452424822&channelid=appstore&cityid=1&lat=34.6135238020622&limit=30&lng=112.4139990666016&typeid=21"



//四个接口
#define classify @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=78284130ab87a8396ec03073eac9c50a&_t_=1452495156&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402"


typedef NS_ENUM(NSInteger,ClassifyListType){
    ClassifyListTypeShowRepertoire = 1,   //演出剧目
    ClassifyListTypeTouristPlace ,        //旅游景点
    ClassifyListTypeStudyPUZ,             //益智
    ClassifyListTypeFamilyTrave           //亲子旅游
};

#define kDiscover   @"http://e.kumi.cn/app/found.php?_s_=a82c7d49216aedb18c04a20fd9b0d5b2&_t_=1451310230&channelid=appstore&cityid=1&lat=34.62172291944134&lng=112.4149512442411"

//微博
#define kAppKey @"3456975626"
#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"

#define kAppSecret @"a252ecf80a0941b2040241ab3a00fb84"

//微信
#define kAppId @"wxb446fed304a2e8a8"