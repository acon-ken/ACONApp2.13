//
//  UsermanageCell.h
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsermanageCell : UITableViewCell{
    UILabel *label1;
    UILabel *label2;
    UIImageView *leftimage;
    UIImageView *rightimage;
    
}

@property (nonatomic , retain) UILabel *label1;

@property (nonatomic , retain) UILabel *label2;

@property (nonatomic , retain) UIImageView *leftimage;

@property (nonatomic , retain) UIImageView *rightimage;

@property(nonatomic,strong)UIButton *rightBtn;



@end
