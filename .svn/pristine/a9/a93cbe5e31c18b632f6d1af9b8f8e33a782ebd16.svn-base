//
//  RemindSeetingCell.h
//  ACONApp
//
//  Created by 朱红轻飞溅 on 15/1/19.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RemindSeetingCell;


@protocol RemindSeetingCellDelegate <NSObject>

- (void)RemindInformationWithEditionDict:(NSDictionary *)dict;

- (void)RemindInformationWithBeginEdit:(UITextField *)textfiled;

- (void)contextMenuCellDidSelectMoreOption:(RemindSeetingCell *)cell;
- (void)contextMenuDidHideInCell:(RemindSeetingCell *)cell;
- (void)contextMenuDidShowInCell:(RemindSeetingCell *)cell;
- (void)contextMenuWillHideInCell:(RemindSeetingCell *)cell;
- (void)contextMenuWillShowInCell:(RemindSeetingCell *)cell;
- (BOOL)shouldShowMenuOptionsViewInCell:(RemindSeetingCell *)cell;
@optional
- (void)contextMenuCellDidSelectDeleteOption:(RemindSeetingCell *)cell;

@end

@interface RemindSeetingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *actualContentView;

@property (weak, nonatomic) IBOutlet UITextField *titleTF;

@property (weak, nonatomic) IBOutlet UITextField *timeTF;

@property (weak, nonatomic) IBOutlet UITextField *remarkTF;

@property (copy, nonatomic) NSString *remindID;

@property (readonly, assign, nonatomic, getter = isContextMenuHidden) BOOL contextMenuHidden;
@property (strong, nonatomic) NSString *deleteButtonTitle;
@property (assign, nonatomic) BOOL editable;
@property (assign, nonatomic) CGFloat menuOptionButtonTitlePadding;
@property (assign, nonatomic) CGFloat menuOptionsAnimationDuration;
@property (assign, nonatomic) CGFloat bounceValue;
@property (strong, nonatomic) NSString *moreOptionsButtonTitle;

@property (weak, nonatomic) id<RemindSeetingCellDelegate> delegate;


- (CGFloat)contextMenuWidth;
- (void)setMenuOptionsViewHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler;


- (void)updateFrame;

- (void)RemindInformationWithDict:(NSDictionary *)dict editionBool:(BOOL)editionBool;

- (void)CellBecomeFirstResponderEditionBool:(BOOL)editionBool;

+(NSString *)ID;

+ (id)createRemindSeetingCell;


@end
