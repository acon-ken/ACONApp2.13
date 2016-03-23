//
//  SysteminformationCell.m
//  ACONApp
//
//  Created by fyf on 14/12/5.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "SysteminformationCell.h"

#define KCTaskSearchNavigationColor [UIColor colorWithRed:62/255.0 green:206/255.0 blue:232/255.0 alpha:1.0]

@implementation SysteminformationCell
@synthesize label1;
@synthesize label2;
@synthesize leftimage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.contents = (id)[UIColor grayColor].CGColor;
        self.frame = CGRectMake(0, 0, 200, 64);
        
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(25,8, 270, 40)];
        label1.font = [UIFont fontWithName:@"Helvetica" size:15];
        label1.textColor = [UIColor blackColor];
        
        leftimage = [[UIImageView alloc]initWithFrame:CGRectMake(8, 20, 15,15)];
        leftimage.highlighted = YES;// flag
        leftimage.image = [UIImage imageNamed:@"tou"];

        
        label2 =  [[UILabel alloc]initWithFrame:CGRectMake(10, leftimage.frame.origin.y+30, 100, 30)];
        label2.font = [UIFont fontWithName:@"Helvetica" size:15];
        label2.textColor = [UIColor darkGrayColor];
        
        //接受按钮
        _AcceptBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 60 -10, leftimage.frame.origin.y-3, 60, 25)];
        [_AcceptBtn setBackgroundImage:[UIImage imageNamed:@"jieshou"] forState:UIControlStateNormal];
        [_AcceptBtn setTitle:@"接受" forState:UIControlStateNormal];
        _AcceptBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_AcceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _AcceptBtn.selected = YES;
        _AcceptBtn.hidden =YES;
        
        
        
        //拒绝按钮
        _RefuseBtn = [[UIButton alloc] initWithFrame:CGRectMake(_AcceptBtn.frame.origin.x, _AcceptBtn.frame.origin.y+35, 60, 25)];
        [_RefuseBtn setBackgroundImage:[UIImage imageNamed:@"jujue"] forState:UIControlStateNormal];
        [_RefuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        _RefuseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_RefuseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _RefuseBtn.selected = YES;
        _RefuseBtn.hidden=YES;
        
        
        
        //  取消拒绝按钮
        _CancelauthorizationBtn = [[UIButton alloc] initWithFrame:CGRectMake(_AcceptBtn.frame.origin.x-40, _AcceptBtn.frame.origin.y+35, 90, 25)];
        [_CancelauthorizationBtn setBackgroundImage:[UIImage imageNamed:@"quxiaoshouquan"] forState:UIControlStateNormal];
        [_CancelauthorizationBtn setTitle:@" 取消授权" forState:UIControlStateNormal];
        _CancelauthorizationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_CancelauthorizationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _CancelauthorizationBtn.selected = YES;
        _CancelauthorizationBtn.hidden=YES;
        
        
        //取消拒绝按钮
        _hasrefusedBtn = [[UIButton alloc] initWithFrame:CGRectMake(_AcceptBtn.frame.origin.x-40, _AcceptBtn.frame.origin.y+35, 90, 25)];
        [_hasrefusedBtn setBackgroundImage:[UIImage imageNamed:@"quxiaoshouquan"] forState:UIControlStateNormal];
        [_hasrefusedBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        _hasrefusedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_hasrefusedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _hasrefusedBtn.selected = YES;
        _hasrefusedBtn.hidden =YES;


    
        
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        [self.contentView addSubview:leftimage];
        [self.contentView addSubview:_AcceptBtn];
        [self.contentView addSubview:_RefuseBtn];
        [self.contentView addSubview:_CancelauthorizationBtn];
        [self.contentView addSubview:_hasrefusedBtn];
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
