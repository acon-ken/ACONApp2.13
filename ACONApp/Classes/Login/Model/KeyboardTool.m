//
//  MJKeyboardTool.m
//  05-键盘处理
//
//  Created by apple on 13-12-6.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "KeyboardTool.h"

@implementation KeyboardTool

+ (id)keyboardTool
{
    return [[NSBundle mainBundle] loadNibNamed:@"MJKeyboardTool" owner:nil options:nil][0];
}

#pragma mark 上一个
- (void)previous
{
    // 通知代理（上一个按钮被点击了）
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:KeyboardToolItemTypePrevious];
    }
}

#pragma mark 下一个
- (void)next
{
    // 通知代理（下一个按钮被点击了）
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:KeyboardToolItemTypeNext];
    }
}

#pragma mark 完成
- (void)done
{
    // 通知代理（完成按钮被点击了）
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:KeyboardToolItemTypeDone];
    }
}

@end
