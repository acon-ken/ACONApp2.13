//
//  DetailInformationController.h
//  ACONApp
//
//  Created by fyf on 14/12/4.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailInformationController : UIViewController
{
    UIImageView *_image;
    
    NSString *_addressstr;
    NSString *_phonestr;
    NSString *_contentstr;
    NSString *_imagestr;
    UITextView *_textView;
}

@property(nonatomic,retain) UITextView *textView;
@property(nonatomic,retain) NSString *addressstr;
@property(nonatomic,retain) NSString *phonestr;
@property(nonatomic,retain) NSString *imagestr;
@property(nonatomic,retain) NSString *contentstr;

@end
