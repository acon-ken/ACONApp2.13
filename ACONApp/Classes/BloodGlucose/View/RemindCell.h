//
//  RemindCell.h
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/15.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RemindCell;



@protocol ReminfInformationCellDelegate <NSObject>


- (void)RemindInformationWithEditionDict:(NSDictionary *)dict;

- (void)RemindInformationWithBeginEdit:(UITextField *)textfiled;
@end



@interface RemindCell : UITableViewCell<UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property (weak, nonatomic) IBOutlet UITextField *remarkTF;

@property (weak, nonatomic) id<ReminfInformationCellDelegate> delegate;



- (void)updateFrame;

- (void)RemindInformationWithDict:(NSDictionary *)dict editionBool:(BOOL)editionBool;

- (void)CellBecomeFirstResponderEditionBool:(BOOL)editionBool;


+(NSString *)ID;

+ (id)createRemindCell;

@end
