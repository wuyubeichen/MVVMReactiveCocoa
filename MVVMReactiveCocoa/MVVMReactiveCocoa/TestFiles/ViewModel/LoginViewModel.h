//
//  LoginViewModel.h
//  MVVMReactiveCocoa
//
//  Created by zhoushuai on 2018/3/22.
//  Copyright © 2018年 zhoushuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"
//处理登录相关的业务逻辑
@interface LoginViewModel : NSObject

//当前视图控制器
@property (nonatomic, weak) UIViewController *currentVC;

//用户账号数据模型
@property (nonatomic, strong) AccountModel *accountModel;


//======各种信号
//用户名输入框颜色信号
@property (nonatomic, strong, readonly) RACSignal *userNameBgClolorSignal;
//密码输入框颜色信号
@property (nonatomic, strong, readonly) RACSignal *pwsswordBgClolorSignal;
//登录按钮颜色信号
@property (nonatomic, strong, readonly) RACSignal *loginBtnBgClolorSignal;
//是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal *validLoginBtnSignal;
//是否隐藏错误提示视图
@property (nonatomic, strong, readonly) RACSubject *hideFailureLabelSignal;

//RACCommand操作：
//登录
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end


