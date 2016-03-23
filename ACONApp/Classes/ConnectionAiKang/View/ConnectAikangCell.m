//
//  ConnectAikangCell.m
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "ConnectAikangCell.h"

@implementation ConnectAikangCell
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize leftimage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.contents = (id)[UIColor grayColor].CGColor;
        self.frame = CGRectMake(0, 0, KScreenWidth, 64);
        
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 1, 250, 30)];
        label1.font = [UIFont fontWithName:@"Helvetica" size:15];
        label1.textColor = [UIColor blackColor];
        
        label2 =  [[UILabel alloc]initWithFrame:CGRectMake(80,30, 300, 17)];
        label2.font = [UIFont fontWithName:@"Helvetica" size:11];
        label2.textColor = [UIColor darkGrayColor];
        
        label3 =  [[UILabel alloc]initWithFrame:CGRectMake(80,48, 300, 17)];
        label3.font = [UIFont fontWithName:@"Helvetica" size:11];
        label3.textColor = [UIColor darkGrayColor];

        
        
        leftimage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50,50)];
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
