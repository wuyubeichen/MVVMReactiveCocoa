//
//  TestViewController.m
//  Test
//
//  Created by zhoushuai on 16/3/7.
//  Copyright © 2016年 zhoushuai. All rights reserved.
//

#import "TestViewController.h"
#import "MainViewController.h"
#import "LoginViewModel.h"
@interface TestViewController ()

@property (nonatomic,strong)LoginViewModel *loginViewModel;

@property (weak, nonatomic) IBOutlet UITextField *userNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *loginFailureLabel;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

@end

@implementation TestViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"RACDemo05";
    
    [self setupBind];
 }


#pragma mark - private Methods
//视图模型绑定
- (void)setupBind{
    //绑定：LoginViewModel属性与输入框值
    RAC(self.loginViewModel.accountModel, userName) = self.userNameTxtField.rac_textSignal;
    RAC(self.loginViewModel.accountModel, password) = self.passwordTxtField.rac_textSignal;
    self.loginViewModel.currentVC = self;
    
    
    //视图颜色变化与按钮可开启
    RAC(self.userNameTxtField,backgroundColor) = self.loginViewModel.userNameBgClolorSignal;
    RAC(self.passwordTxtField, backgroundColor) = self.loginViewModel.pwsswordBgClolorSignal;
    RAC(self.loginBtn,backgroundColor) = self.loginViewModel.loginBtnBgClolorSignal;
    RAC(self.loginBtn, enabled) = self.loginViewModel.validLoginBtnSignal;
    RAC(self.loginFailureLabel,hidden) = self.loginViewModel.hideFailureLabelSignal;
   

    //处理响应事件：
    __weak typeof (self) weakSelf = self;
    //1.点击页面，隐藏键盘
    [self.tapGesture.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [weakSelf.view endEditing:YES];
    }];
    
    //2.点击登录按钮，执行网络请求
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //执行登录的网路请求操作
        [weakSelf.loginViewModel.loginCommand execute:nil];
    }];
    
}



#pragma mark - Getter && Setter
- (LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

@end
