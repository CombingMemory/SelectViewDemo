//
//  KaraokeLabel.h
//  SelectViewDemo
//
//  Created by 雨天记忆 on 15/12/24.
//  Copyright © 2015年 雨天记忆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KaraokeLabel : UIView

@property (nonatomic, strong) NSString *text;//文本的内容
@property (nonatomic, strong) UIColor *unreadColor;//未读文本的颜色
@property (nonatomic, strong) UIColor *readColor;//已读文本的颜色
@property (nonatomic, strong) UIFont *font;//文本的字体
@property (nonatomic) NSTextAlignment textAlignment;//文本显示的位置
@property (nonatomic) float progross;//播放的进度
@property (nonatomic) CGRect readFrame;//读过的内容区域

@end
