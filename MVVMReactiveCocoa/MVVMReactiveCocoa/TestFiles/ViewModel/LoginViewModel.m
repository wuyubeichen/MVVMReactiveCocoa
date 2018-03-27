//
//  LoginViewModel.m
//  MVVMReactiveCocoa
//
//  Created by zhoushuai on 2018/3/22.
//  Copyright © 2018年 zhoushuai. All rights reserved.
//

#import "LoginViewModel.h"
#import "MainViewController.h"
@interface LoginViewModel()
//有效信号属性
@property (nonatomic,strong)RACSignal *validUserNameSignal;
@property (nonatomic,strong)RACSignal *validPasswordSignal;
@property (nonatomic,strong)RACSignal *validLoginBtnSignal;

@property (nonatomic, assign) BOOL isFailture;

@end

@implementation LoginViewModel
#pragma mark - Life Cycle
- (instancetype)init{
    if (self = [super init]) {
        [self setupBind];
    }
    return self;
}

#pragma mark - private Methods
- (void)setupBind{
    __weak typeof (self) weakSelf = self;
    
    //1.判断用户名、密码、登录是否可用的信号
    _validUserNameSignal = [RACObserve(self.accountModel, userName) map:^id _Nullable(id  _Nullable value) {
        return @([weakSelf isValidForUserName:value]);
    }];

    _validPasswordSignal = [RACObserve(self.accountModel, password) map:^id _Nullable(id  _Nullable value) {
        return @([weakSelf isValidForPassword:value]);
    }];
    
    _validLoginBtnSignal =  [RACSignal combineLatest:@[_validUserNameSignal,_validPasswordSignal] reduce:^id (NSNumber *userNameValid,NSNumber *paswordValid){
        return @([userNameValid boolValue] && [paswordValid boolValue]);
    }];
    
    
    //2.用户名、密码、登录颜色变化信号
    _userNameBgClolorSignal = [_validUserNameSignal map:^id _Nullable(NSNumber *userNameValid) {
        return [userNameValid boolValue] ? [UIColor whiteColor] : [UIColor yellowColor];
    }];
    
    _pwsswordBgClolorSignal = [_validPasswordSignal map:^id _Nullable(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor whiteColor] : [UIColor yellowColor];
    }];
 
    _loginBtnBgClolorSignal = [_validLoginBtnSignal map:^id _Nullable(NSNumber *loginValid) {
        return [loginValid boolValue] ? [UIColor orangeColor] : [UIColor lightGrayColor];
    }];
    
    _hideFailureLabelSignal = [RACSubject subject];
    

    //3.RACCommand事件
    //封装登录网络请求操作
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [self.hideFailureLabelSignal sendNext:@"1"];
            //登录网络请求
            [HttpRequestManager loginInWithUsername:weakSelf.accountModel.userName password:weakSelf.accountModel.password response:^(BOOL success, id data) {
                if (success) {
                    [self.hideFailureLabelSignal sendNext:@"1"];
                }else{
                    [self.hideFailureLabelSignal sendNext:@"0"];
                }
                //发送登录请求的数据
                [subscriber sendNext:data];
                //必须sendCompleted，否则命令永远处于执行状态
                [subscriber sendCompleted];
            }];
            
            
            return nil;
        }];
    }];

    //监听登录操作产生的数据
    //switchToLatest获取最新发送的信号，只能用于信号中信号
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSDictionary *loginData = (NSDictionary *)x;
        if ([loginData[@"status"] isEqualToString:@"0"]) {
            NSLog(@"登录成功！");
            MainViewController *firstVC = [[MainViewController alloc] init];
            [weakSelf.currentVC.navigationController pushViewController:firstVC animated:YES];
        }else{
        }
    }];
    
    //监听登录操作的状态：正在进行或者已经结束
    //默认会监测一次，所以这里使用skip表示跳过第一次信号。
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x isEqual:@(YES)]) {
            //正在执行，显示MBProgressHUD
            [MBProgressHUD showHUDAddedTo:weakSelf.currentVC.view animated:YES];
        }else{
            //正在执行或者没有执行，隐藏MBProgressHUD
            [MBProgressHUD hideHUDForView:self.currentVC.view animated:YES];
        }
    }];
}



- (BOOL)isValidForUserName:(NSString *)userName{
    return userName.length > 6;
}

- (BOOL)isValidForPassword:(NSString *)password{
    return password.length > 6;
}


#pragma mark - Getter && Setter
- (AccountModel *)accountModel{
    if (!_accountModel) {
        _accountModel = [[AccountModel alloc] init];
    }
    return _accountModel;
}
@end
