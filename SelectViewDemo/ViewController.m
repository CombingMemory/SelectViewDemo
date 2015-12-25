//
//  ViewController.m
//  SelectViewDemo
//
//  Created by 雨天记忆 on 15/12/23.
//  Copyright © 2015年 雨天记忆. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
#import "KaraokeLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SelectView *select = [[SelectView alloc] initWithFrame:CGRectMake(20, 100, 300, 40) itemArray:@[@"第一",@"第二",@"第三",@"第四",@"第五",@"第六"] touchItem:^(NSUInteger index) {
        NSLog(@"%ld",index);
    }];
//    select.selectItemColor = [UIColor whiteColor];
//    select.notSelectItemColor = [UIColor blackColor];
    [self.view addSubview:select];
}

@end
