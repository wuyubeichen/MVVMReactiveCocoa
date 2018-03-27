//
//  VideoListModel.m
//  ZSPlayerDemo
//
//  Created by zhoushuai on 2017/12/26.
//  Copyright © 2017年 zhoushuai. All rights reserved.
//

#import "VideoListModel.h"

@implementation VideoListModel

- (NSString *)realVideoUrl{
    //抓取的bilibili的视频链接不能用，所以这里为了测试，就可以强制返回一个测试链接
    //NSArray *strArr = [_uri componentsSeparatedByString:@"/"];
    //return [NSString stringWithFormat:@"https://www.bilibili.com/video/av%@",strArr.lastObject];
    
    return _uri;
    
    //泼茶香mv链接
    //return @"http://data.vod.itc.cn/?rb=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/203/48/hOnPcyxvS8RWrW8no6mz8c.mp4";
}

@end




@implementation VideoListDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"videos" : [VideoListModel class]};
}

@end
