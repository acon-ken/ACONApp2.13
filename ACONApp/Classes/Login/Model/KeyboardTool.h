//
//  MJKeyboardTool.h
//  05-键盘处理
//
//  Created by apple on 13-12-6.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KeyboardTool;

typedef enum {
    KeyboardToolItemTypePrevious, // 上一个
    KeyboardToolItemTypeNext, // 下一个
    KeyboardToolItemTypeDone // 完成
} KeyboardToolItemType;

@protocol KeyboardToolDelegate <NSObject>
@optional
//- (void)keyboardToolPreviousClick:(MJKeyboardTool *)keyboardTool;
//- (void)keyboardToolNextClick:(MJKeyboardTool *)keyboardTool;
//- (void)keyboardToolDoneClick:(MJKeyboardTool *)keyboardTool;
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType;
@end

@interface KeyboardTool : UIView
- (IBAction)previous; // 上一个
- (IBAction)next; // 下一个
- (IBAction)done; // 完成
@property (weak, nonatomic, readonly) IBOutlet UIBarButtonItem *previousItem;
@property (weak, nonatomic, readonly) IBOutlet UIBarButtonItem *nextItem;

@property (nonatomic, weak) id<KeyboardToolDelegate> delegate;

+ (id)keyboardTool;
@end
