//
//  SysteminformationCell.h
//  ACONApp
//
//  Created by fyf on 14/12/5.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SysteminformationCell : UITableViewCell{
    UILabel *label1;
    UILabel *label2;
    
    UIImageView *leftimage;
    UIButton *_AcceptBtn;
    UIButton *_RefuseBtn;
    UIButton *_hasrefusedBtn;
    UIButton *_CancelauthorizationBtn;
    
}

@property (nonatomic , retain) UILabel *label1;

@property (nonatomic , retain) UILabel *label2;

@property (nonatomic , retain) UIImageView *leftimage;

@property (nonatomic , retain) UIButton *AcceptBtn;

@property (nonatomic , retain) UIButton *RefuseBtn;

@property (nonatomic , retain) UIButton *hasrefusedBtn;

@property (nonatomic , retain) UIButton *CancelauthorizationBtn;




@end
