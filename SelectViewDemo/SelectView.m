//
//  SelectView.m
//  SelectViewDemo
//
//  Created by 雨天记忆 on 15/12/23.
//  Copyright © 2015年 雨天记忆. All rights reserved.
//

#import "SelectView.h"
#import "KaraokeLabel.h"

@interface SelectView ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;//红色块可以移动的视图
    UIView *_bgView;//移动的视图
    NSUInteger _count;//数组的个数
    CGFloat _x;//多出来用于可滑动的区域
    CGFloat _width;//每个item的宽度
    NSUInteger _page;//当前滑动到第几个了
    NSMutableArray *_array;//存放item的数组。便于方便取视图
}

@property (copy, nonatomic) TouchItem touchItem;

@end

@implementation SelectView

- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)array touchItem:(TouchItem)touchItem
{
    self = [super initWithFrame:frame];
    if (self) {
        //默认的宽度和颜色
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor redColor].CGColor;
        
        //数组个数赋值
        _count = array.count;
        
        
        //创建scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(frame.size.width / _count * (_count * 2 - 1), 0);
        _scrollView.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
        _scrollView.bounces = NO;//边界无回弹
        
        UITapGestureRecognizer *scrollTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScroll:)];
        [_scrollView addGestureRecognizer:scrollTap];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _width = frame.size.width / _count;
        _x = (_scrollView.contentSize.width - _width) / 2;
        //让bgView处于第一item上边
        _scrollView.contentOffset = CGPointMake(_x, 0);
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(_x, 0, _width, frame.size.height)];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchItem:)];
        [_bgView addGestureRecognizer:tap];
        _bgView.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:_bgView];
        
        //初始化数组
        _array = [NSMutableArray array];
        
        //创建itemView
        for (int i = 0; i < _count; i++) {
            KaraokeLabel *itemView = [[KaraokeLabel alloc] initWithFrame:CGRectMake(i * _width, 0, _width, frame.size.height)];
            if (i == 0) {
                itemView.progross = 1;
            }
            itemView.text = array[i];
            itemView.textAlignment = NSTextAlignmentCenter;
            itemView.unreadColor = [UIColor redColor];
            itemView.readColor = [UIColor whiteColor];
            [self addSubview:itemView];
            [_array addObject:itemView];
        }
        self.touchItem = touchItem;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_array) {
        CGFloat x = -(scrollView.contentOffset.x - _x);
        NSInteger count = _array.count - 1;
        NSUInteger page1 = x / _width;
        NSUInteger page2 = page1 + 1 > count?page1 - 1:page1 + 1;
        if (count < 0) {
            count = 0;
        }
        KaraokeLabel *itemView1 = _array[page1];
        KaraokeLabel *itemView2 = _array[page2];
        
        itemView1.readFrame = CGRectMake(x - itemView1.frame.origin.x, 0, _width - (x - itemView1.frame.origin.x), self.frame.size.height);
        itemView2.readFrame = CGRectMake(0, 0, _width - itemView1.readFrame.size.width, self.frame.size.height);
        
        for (KaraokeLabel *itemView in _array) {
            if (!([itemView isEqual:itemView1] || [itemView isEqual:itemView2])) {
                itemView.progross = 0;
            }
        }

    }
}

//点击手势的方法
- (void)touchItem:(UITapGestureRecognizer *)tap{
    if (self.touchItem) {
        self.touchItem(_page);
    }
}

//开始滑动的时候 关闭用户交互。主要防止。在过程中item被点击了
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _bgView.userInteractionEnabled = NO;
    scrollView.userInteractionEnabled = NO;
}

//结束拖拽的时候触发的方法。用来确定当前的应该停留在那一个itemView上边
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        double x = fabs(scrollView.contentOffset.x - _x);//去除可滑动区域，用于方便计算
        NSUInteger page = (x + _width / 2) / _width;
        [_scrollView setContentOffset:CGPointMake(fabs(page * _width - _x), 0) animated:YES];
        
        scrollView.userInteractionEnabled = YES;
        //滑动结束后调用的方法
        if (page != _page) {
            _page = page;
            if (self.touchItem) {
                self.touchItem(_page);
            }
        }
        
    }
}

//开始减速的时候调用的代理方法，主要作用是取消他的惯性滑动
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //滑动结束后，用户可以点击item
    _bgView.userInteractionEnabled = YES;
    scrollView.userInteractionEnabled = YES;
}

//设置边框的宽度
- (void)setBorderWidth:(float)borderWidth{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

//设置边框的颜色
- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

//被选中的颜色
- (void)setSelectItemColor:(UIColor *)selectItemColor{
    _selectItemColor = selectItemColor;
    _bgView.backgroundColor = selectItemColor;
}

//未被选中的颜色
- (void)setNotSelectItemColor:(UIColor *)notSelectItemColor{
    _notSelectItemColor = notSelectItemColor;
    _scrollView.backgroundColor = notSelectItemColor;
    
}

//scrollView的点击方法
- (void)tapScroll:(UITapGestureRecognizer *)tap{
    _scrollView.userInteractionEnabled = NO;
    CGFloat x = [tap locationInView:self].x;
    _page = x / _width;
    [_scrollView setContentOffset:CGPointMake(fabs(_page * _width - _x), 0) animated:YES];
    //滑动结束后调用的方法
    if (self.touchItem) {
        self.touchItem(_page);
    }
}

@end
