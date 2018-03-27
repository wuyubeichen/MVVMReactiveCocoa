//
//  ZSCommonTools.m
//  MVVMReactiveCocoa
//
//  Created by zhoushuai on 2018/3/26.
//  Copyright © 2018年 zhoushuai. All rights reserved.
//

#import "ZSCommonTools.h"

@implementation ZSCommonTools
/**
 *  解析本地json数据
 *  @param fileName jion文件名
 *  @return  字典
 */
+ (NSDictionary *)getDictionaryFromJsonFile:(NSString *)fileName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSDictionary *  jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (jsonDic == nil) {
        NSLog(@"解析文件失败");
        return nil;
    }
    return jsonDic;
}




+(void)showInView:(UIView *)view withText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.removeFromSuperViewOnHide = YES;
    
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.alpha = 0.8f;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    
    [hud hideAnimated:YES afterDelay:1.3];
}

//设置时间的提示
+(void)showInController:(UIViewController *)controller withText:(NSString *)text withTime:(NSInteger)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:time];
}


@end
