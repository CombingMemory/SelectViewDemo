//
//  KaraokeLabel.m
//  SelectViewDemo
//
//  Created by 雨天记忆 on 15/12/24.
//  Copyright © 2015年 雨天记忆. All rights reserved.
//

#import "KaraokeLabel.h"

@interface KaraokeLabel ()
{
    UILabel *_unreadLabel;//未读的label
    UILabel *_readLabel;//已读的label
    UIView *_bgView;//控制播放多少的view
}
@end

@implementation KaraokeLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        _unreadLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _unreadLabel.textColor = [UIColor whiteColor];
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_unreadLabel];
        
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        self.progross = 0;
        _bgView.clipsToBounds = YES;
        [self addSubview:_bgView];
        
        _readLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _readLabel.textColor = [UIColor greenColor];
        _readLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:_readLabel];
        
    }
    return self;
}

//文本赋值
- (void)setText:(NSString *)text{
    _text = text;
    _unreadLabel.text = text;
    _readLabel.text = text;
}

//未读的文本颜色
- (void)setUnreadColor:(UIColor *)unreadColor{
    _unreadColor = unreadColor;
    _unreadLabel.textColor = unreadColor;
}

//已读的文本颜色
- (void)setReadColor:(UIColor *)readColor{
    _readColor = readColor;
    _readLabel.textColor = readColor;
}

//文本的字体
- (void)setFont:(UIFont *)font{
    _font = font;
    _unreadLabel.font = font;
    _readLabel.font = font;
}

//karaoke播放的进度
- (void)setProgross:(float)progross{
    //做一个范围判断
    if (progross >= 1) {
        progross = 1;
    }else if (progross <= 0){
        progross = 0;
    }
    _progross = progross;
    CGFloat width = self.bounds.size.width * progross;
    CGFloat x = _bgView.frame.origin.x;
    CGFloat y = _bgView.frame.origin.y;
    CGFloat height = _bgView.frame.size.height;
    _bgView.frame = CGRectMake(x, y, width, height);
}

//读过的内容区域
- (void)setReadFrame:(CGRect)readFrame{
    _readFrame = readFrame;
    _bgView.frame = readFrame;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat x = -readFrame.origin.x;
    CGFloat y = -readFrame.origin.y;
    _readLabel.frame = CGRectMake(x, y, width, height);
}

@end
