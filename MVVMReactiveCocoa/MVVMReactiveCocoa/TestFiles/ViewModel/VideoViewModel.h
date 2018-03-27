//
//  VideoViewModel.h
//  MVVMReactiveCocoa
//
//  Created by zhoushuai on 2018/3/24.
//  Copyright © 2018年 zhoushuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>

//当前视图控制器
@property (nonatomic, weak) UIViewController *currentVC;

//RACCommand操作：
//获取视频列表
@property (nonatomic, strong, readonly) RACCommand *requestVideoListCommand;

@end
