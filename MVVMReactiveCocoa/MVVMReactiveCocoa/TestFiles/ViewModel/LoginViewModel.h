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


/*
RACCommand简介：
RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。
 
 
 RACCommand使用步骤:
 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
 3.执行命令 - (RACSignal *)execute:(id)input，命令的执行返回值是一个信号
 
 
RACCommand使用注意:
1.创建RACCommand的方法中，signalBlock必须要返回一个信号，不能传nil.
2.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
3.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
 

RACCommand设计思想：
1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
 
 
如何拿到RACCommand中返回信号发出的数据。
1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
 
 
RACCommand重要的属性
RACCommand 通常用来表示某个Action的执行，比如点击Button。它有几个比较重要的属性：executionSignals / errors / executing。
1.executionSignals是signal of signals，如果直接subscribe的话会得到一个signal，而不是我们想要的value，所以一般会配合switchToLatest。
2.errors。跟正常的signal不一样，RACCommand的错误不是通过sendError来实现的，而是通过errors属性传递出来的。
3.executing表示该command当前是否正在执行。

 
 
 
 */
 




