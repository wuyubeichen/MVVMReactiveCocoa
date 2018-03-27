//
//  VoideoListTableViewCell.h
//  ZSPlayerDemo
//
//  Created by zhoushuai on 2017/12/26.
//  Copyright © 2017年 zhoushuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListModel.h"

@interface VideoListTableViewCell : UITableViewCell

@property (nonatomic, strong) VideoListModel *videoListModel;


+ (VideoListTableViewCell *)getVideoListTableViewCell;

@end
