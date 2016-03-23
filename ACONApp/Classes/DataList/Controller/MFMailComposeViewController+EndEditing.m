//
//  MFMailComposeViewController+EndEditing.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/18.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "MFMailComposeViewController+EndEditing.h"

@implementation MFMailComposeViewController (EndEditing)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
