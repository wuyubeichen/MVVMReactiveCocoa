//
//  ZSCommonTools.h
//  MVVMReactiveCocoa
//
//  Created by zhoushuai on 2018/3/26.
//  Copyright © 2018年 zhoushuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSCommonTools : NSObject

//1.读取本地Json视频列表数据
+ (NSDictionary *)getDictionaryFromJsonFile:(NSString *)fileName;



//Toast一条提示消息
+(void)showInView:(UIView *)view withText:(NSString *)text;


//Toast一条提示消息,带有时间
+(void)showInController:(UIViewController *)controller withText:(NSString *)text withTime:(NSInteger)time;

@end
