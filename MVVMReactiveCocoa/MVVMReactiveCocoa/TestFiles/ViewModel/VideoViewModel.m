//
//  VideoViewModel.m
//  MVVMReactiveCocoa
//
//  Created by zhoushuai on 2018/3/24.
//  Copyright © 2018年 zhoushuai. All rights reserved.
//

#import "VideoViewModel.h"
#import "VideoListTableViewCell.h"
@interface VideoViewModel()
//数据源
@property(nonatomic,strong)NSMutableArray *videoModels;
@property(nonatomic,assign)NSInteger currentPage;

@end

@implementation VideoViewModel
#pragma mark - Life Cycle
- (id) init{
    if (self = [super init]) {
        _currentPage = 0;
        [self setupBind];
    }
    return self;
}

#pragma mark - private Methods
- (void)setupBind{
    //RACCommand事件
    @weakify(self)
    //封装网络请求的操作
    _requestVideoListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self)
            //请求分页的视频列表数据
            NSDictionary *inputData = (NSDictionary *)input;
            BOOL headerRefresh = [inputData[@"headerRefresh"] boolValue];
            NSInteger requestPage = headerRefresh ? 0 : self.currentPage + 1;
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *paramPage = [NSString stringWithFormat:@"%ld",requestPage];
            [params setObject:paramPage forKey:@"page"];

            //执行网络请求
            [HttpRequestManager requestForVideoList:params response:^(BOOL success, id data) {
                if(success){
                    VideoListDataModel *videoListDataModel = [VideoListDataModel yy_modelWithJSON:data];
                    if(videoListDataModel.videos.count >0){
                        if(requestPage == 0){
                            self.currentPage = 0;
                            [self.videoModels removeAllObjects];
                        }else{
                            self.currentPage = requestPage;
                        }
                        [self.videoModels addObjectsFromArray:videoListDataModel.videos];
                    }else{
                        //NSLog(@"");
                    }
                }else{
                }
                //显示提示信息
                NSString *errorMsg = data[@"errorMsg"];
                if(errorMsg.length > 0){
                    [ZSCommonTools showInView:self.currentVC.view withText:errorMsg];
                }
                //发送请求的数据
                [subscriber sendNext:data];
                //必须sendCompleted，否则命令永远处于执行状态
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    
    //监听登录操作产生的数据
    //switchToLatest获取最新发送的信号，只能用于信号中信号
    [_requestVideoListCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [[NSNotificationCenter defaultCenter] postNotificationName: NotificationName_RefreshMainVC object:x];
    }];
    
    //监听登录操作的状态：正在进行或者已经结束
    //默认会监测一次，所以这里使用skip表示跳过第一次信号。
    [[_requestVideoListCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x isEqual:@(YES)]) {
            //正在执行，显示MBProgressHUD
        }else{
            //正在执行或者没有执行，隐藏MBProgressHUD
        }
    }];
}



#pragma mark - Delegate：UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"VideoListTableViewCellID";
     VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [VideoListTableViewCell getVideoListTableViewCell];
    }
    cell.videoListModel = self.videoModels[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}



#pragma mark - Getter && Setter
- (NSMutableArray *)videoModels{
    if (!_videoModels) {
        _videoModels = [NSMutableArray array];
    }
    return _videoModels;
}

@end
