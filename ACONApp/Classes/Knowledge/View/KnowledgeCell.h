//
//  KnowledgeCell.h
//  ACONApp
//
//  Created by fyf on 14/12/2.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnowledgeCell : UITableViewCell{
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UIView *backview;

    UIImageView *leftimage;
}

@property (nonatomic , retain) UILabel *label1;

@property (nonatomic , retain) UILabel *label2;

@property (nonatomic , retain) UILabel *label3;

@property (nonatomic , retain) UILabel *label4;

@property (nonatomic , retain) UIView *backview;

@property (nonatomic , retain) UIImageView *leftimage;


@end
