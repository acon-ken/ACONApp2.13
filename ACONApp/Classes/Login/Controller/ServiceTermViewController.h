//
//  ServiceTermViewController.h
//  ACONApp
//
//  Created by fyf on 14/11/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTermViewController : UIViewController<WebServiceDelegate>
{
    WebServices *helper;
    UITextView *_textView;
    UIImageView *_image;
   
}

@property(nonatomic,retain) UITextView *textView;


@end
