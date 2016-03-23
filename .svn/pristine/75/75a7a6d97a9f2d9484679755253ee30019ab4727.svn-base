//
//  KnowledgeCell.m
//  ACONApp
//
//  Created by fyf on 14/12/2.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "KnowledgeCell.h"

#define KCTaskSearchNavigationColor [UIColor colorWithRed:62/255.0 green:206/255.0 blue:232/255.0 alpha:1.0]

@implementation KnowledgeCell
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize backview;
@synthesize leftimage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.contents = (id)[UIColor grayColor].CGColor;
        self.frame = CGRectMake(0, 0, 200, 64);
        self.layer.masksToBounds = YES;
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 120, 30)];
        label1.font = [UIFont fontWithName:@"Helvetica" size:15];
        label1.textColor = KCTaskSearchNavigationColor;

        
        label2 =  [[UILabel alloc]initWithFrame:CGRectMake(15,28, KScreenWidth-15, 40)];
        label2.tag = 1002;
        label2.font = [UIFont boldSystemFontOfSize:14.0f];
        label2.numberOfLines = 0;
        label2.lineBreakMode = 0;
        label2.textColor = [UIColor blackColor];
        
        
//        label4 =  [[UILabel alloc]initWithFrame:CGRectMake(10,label2.frame.origin.y, 40, 40)];
//        label4.font = [UIFont fontWithName:@"Helvetica" size:15];
//        label4.textColor = [UIColor blackColor];
//        label4.text = @"Q：";
        
        backview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMidY(label2.frame)+13, KScreenWidth, 230)];
        backview.tag  = 1003;
        //backview.backgroundColor = [UIColor yellowColor];
        backview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"danlanse"]];
        
        leftimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 25,25)];
        leftimage.highlighted = YES;// flag
        leftimage.image = [UIImage imageNamed:@"da"];
        
        label3 =  [[UILabel alloc]initWithFrame:CGRectMake(40,5, KScreenWidth-60, 30)];
        label3.numberOfLines = 0;
        label3.lineBreakMode = 0;
        label3.font = [UIFont fontWithName:@"Helvetica" size:12];
        label3.textColor = [UIColor darkGrayColor];
        

     
        

        
        [backview addSubview:leftimage];
        [backview addSubview:label3];
        [self.contentView addSubview:backview];
        
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        //[self.contentView addSubview:label4];
     
        
        
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
