//
//  HttpRequestManager.h
//  MVVMReactiveCocoa
//
//  Created by zhoushuai on 2018/3/26.
//  Copyright © 2018年 zhoushuai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpResponse)(BOOL success,id data);

//模拟网络请求，测试RAC+MVVM的使用

@interface HttpRequestManager : NSObject

/**
 *  登陆的方法
 *
 *  @param username      用户名
 *  @param password      密码
 *  @param responeBlock 登陆成功后的回调
 */
+ (void)loginInWithUsername:(NSString *)username
                  password:(NSString *)password
                  response:(HttpResponse)responeBlock;





/**
 请求视频列表

 @param paramsData 请求参数
 @param responeBlock 请求完成之后的回调
 */
+ (void)requestForVideoList:(NSDictionary *)paramsData
                   response:(HttpResponse)responeBlock;





@end
