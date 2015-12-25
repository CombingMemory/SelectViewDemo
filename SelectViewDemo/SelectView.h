//
//  SelectView.h
//  SelectViewDemo
//
//  Created by 雨天记忆 on 15/12/23.
//  Copyright © 2015年 雨天记忆. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchItem)(NSUInteger index);

@interface SelectView : UIView

@property (nonatomic) float borderWidth;//边框的宽度
@property (nonatomic, strong) UIColor *borderColor;//边框颜色
@property (nonatomic, strong) UIColor *selectItemColor;//被选中的颜色
@property (nonatomic, strong) UIColor *notSelectItemColor;//未被选中的颜色

//初始化方法 数组里面放NSString类型 Block是点击某一个item和滑动到某一个item的方法
- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)array touchItem:(TouchItem)touchItem;

@end
