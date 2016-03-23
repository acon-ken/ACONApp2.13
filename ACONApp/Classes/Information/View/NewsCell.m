//
//  NewsCell.m
//  ACONApp
//
//  Created by fyf on 14/12/2.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize leftimage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.contents = (id)[UIColor grayColor].CGColor;
        self.frame = CGRectMake(0, 0, 200, 64);
        
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 3, KScreenWidth-100, 30)];
        label1.font = [UIFont fontWithName:@"Helvetica" size:15];
        label1.textColor = [UIColor blackColor];
        
//        NSString * labelStr = @"你好，这是UILabel的自动换行测试内容，主要实现多行数据的自动换行，自适应不同行数的数据";
//        CGSize labelSize = {0, 0};
//        labelSize = [labelStr sizeWithFont:[UIFont systemFontOfSize:14]
//                         constrainedToSize:CGSizeMake(200.0, 5000)
//                             lineBreakMode:0];
        
        label2 =  [[UILabel alloc]initWithFrame:CGRectMake(80,27, 230, 28)];
        label2.numberOfLines = 0;
        label2.lineBreakMode = 0;
        label2.font = [UIFont fontWithName:@"Helvetica" size:11];
        label2.textColor = [UIColor darkGrayColor];
       
        label3 =  [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-75,52, 100, 17)];
        label3.font = [UIFont fontWithName:@"Helvetica" size:11];
        label3.textColor = [UIColor darkGrayColor];

        
        
        leftimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 60,60)];
        leftimage.highlighted = YES;// flag
        
        
        
        
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        [self.contentView addSubview:label3];
        [self.contentView addSubview:leftimage];
        
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
