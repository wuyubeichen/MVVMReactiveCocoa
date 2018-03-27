//
//  VideoListModel.h
//  ZSPlayerDemo
//
//  Created by zhoushuai on 2017/12/26.
//  Copyright © 2017年 zhoushuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoListModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *play;
@property (nonatomic, copy) NSString *danmaku;

//从B站抓取的视频链接是不完整的链接，
//所以为了测试，我们需要用下面这个属性转化得到的真正链接
@property (nonatomic, copy) NSString *realVideoUrl;
@end



@interface VideoListDataModel : NSObject
@property (nonatomic, copy) NSArray *videos;

@end
