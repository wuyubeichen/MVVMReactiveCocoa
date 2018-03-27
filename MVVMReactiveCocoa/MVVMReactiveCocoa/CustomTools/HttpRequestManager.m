//
//  HttpRequestManager.m
//  MVVMReactiveCocoa
//
//  Created by zhoushuai on 2018/3/26.
//  Copyright © 2018年 zhoushuai. All rights reserved.
//

#import "HttpRequestManager.h"
#import "ZSCommonTools.h"
const float delaySeconds = 1.5f;

@implementation HttpRequestManager

/**
 *  登陆的方法
 *
 *  @param username      用户名
 *  @param password      密码
 *  @param responeBlock 登陆成功后的回调
 */
+ (void)loginInWithUsername:(NSString *)username
                   password:(NSString *)password
                   response:(HttpResponse)responeBlock{
    //使用延时操作，模拟登录网络请求,并在这里发送消息
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds)*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSDictionary *loginData;
        if([username isEqualToString:@"username"] && [password isEqualToString:@"password"]){
            loginData= @{@"status":@"0",@"errorMsg":@"",@"name":@"FengZi",@"age":@"18"};
            responeBlock(YES,loginData);
        }else{
             loginData = @{@"status":@"1",@"errorMsg":@"用户名或者密码错误"};
            responeBlock(NO, loginData);
        }
    });
}



/**
 请求视频列表
 
 @param paramsData 请求参数
 @param responeBlock 请求完成之后的回调
 */
+ (void)requestForVideoList:(NSDictionary *)paramsData
                   response:(HttpResponse)responeBlock{
    //使用延时操作，模拟登录网络请求,并在这里发送消息
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds)*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        NSDictionary *returnData;
        BOOL success = YES;
        //模拟只有三页数据的情况和没有更多数据的情况
        NSString *requestPage = paramsData[@"page"];
        if ([requestPage integerValue] > 3) {
            returnData = @{@"status":@"0",@"errorMsg":@"没有更多数据了",@"videos":@[]};
        }else{
            returnData = [ZSCommonTools getDictionaryFromJsonFile:[NSString stringWithFormat:@"VideoList%@",requestPage]];
        }
        
        //模拟请求失败的情况
//        int x = arc4random() % 2; //得到一个随机数0或1
//        if(x == 1){
//            returnData = @{@"status":@"1",@"errorMsg":@"模拟网路出错的情况：服务器开小差了，请刷新重试"};
//            success = NO;
//        }
        responeBlock(success,returnData);
    });
}




@end
