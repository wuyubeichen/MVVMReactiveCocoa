//
//  VoideoListTableViewCell.m
//  ZSPlayerDemo
//
//  Created by zhoushuai on 2017/12/26.
//  Copyright © 2017年 zhoushuai. All rights reserved.
//

#import "VideoListTableViewCell.h"
@interface VideoListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *upPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *barrageCountLabel;
@end

@implementation VideoListTableViewCell
#pragma mark - Life Cycle
+ (VideoListTableViewCell *)getVideoListTableViewCell{
    VideoListTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoListTableViewCell" owner:nil options:nil] lastObject];
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter && Setter
- (void)setVideoListModel:(VideoListModel *)videoListModel{

    _videoListModel = videoListModel;
    
    [_coverImgView sd_setImageWithURL:[NSURL URLWithString:self.videoListModel.cover]];
    
    _titleLabel.text = self.videoListModel.title;
    
    _upPersonLabel.text =  [NSString stringWithFormat:@"UP主：%@",self.videoListModel.author];;
    
    _playCountLabel.text = [NSString stringWithFormat:@"播放：%@",self.videoListModel.play];
    
    _barrageCountLabel.text = [NSString stringWithFormat:@"弹幕：%@",self.videoListModel.danmaku];
}

@end
