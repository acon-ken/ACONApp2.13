//
//  UsermanageCell.m
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "UsermanageCell.h"

@implementation UsermanageCell
@synthesize label1;
@synthesize label2;
@synthesize leftimage;
@synthesize rightimage;
//@synthesize rightBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.contents = (id)[UIColor grayColor].CGColor;
        self.frame = CGRectMake(0, 0, KScreenWidth, 64);
      
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 819, 30)];
        label1.font = [UIFont fontWithName:@"Helvetica" size:13];
        label1.textColor = [UIColor darkGrayColor];
        
        label2 =  [[UILabel alloc]initWithFrame:CGRectMake(90,30, 819, 17)];
        label2.font = [UIFont fontWithName:@"Helvetica" size:13];
        label2.textColor = [UIColor darkGrayColor];
    
        leftimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 60,55)];
        leftimage.highlighted = YES;// flag
        
        rightimage = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-33, 25, 17,17)];
        rightimage.highlighted = YES;// flag

        
        //接受按钮
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame =CGRectMake(KScreenWidth-75, 0, 70, 60);
        _rightBtn.selected = YES;

        
        
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        [self.contentView addSubview:leftimage];
        [self.contentView addSubview:rightimage];
        [self.contentView addSubview:_rightBtn];
        
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
