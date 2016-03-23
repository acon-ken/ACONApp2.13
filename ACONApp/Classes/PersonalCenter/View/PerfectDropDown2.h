//
//  PerfectDropDown2.h
//  ACONApp
//
//  Created by fyf on 14/12/15.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PerfectDropDown2;
@protocol PerfectDropDownDelegate2
- (void) niDropDownDelegateMethod2: (PerfectDropDown2 *) sender2;
@end

@interface PerfectDropDown2 : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) id <PerfectDropDownDelegate2> delegate;

@property(assign,nonatomic) NSInteger selectedindex;
-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr;


@end
