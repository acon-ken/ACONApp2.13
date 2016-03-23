//
//  PerfectDropDown.h
//  ACONApp
//
//  Created by fyf on 14/12/4.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PerfectDropDown;
@protocol PerfectDropDownDelegate
- (void) niDropDownDelegateMethod: (PerfectDropDown *) sender;
@end

@interface PerfectDropDown : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) id <PerfectDropDownDelegate> delegate;

-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr;

@end
