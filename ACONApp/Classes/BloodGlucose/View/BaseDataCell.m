//
//  BaseDataCell.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "BaseDataCell.h"

@implementation BaseDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    CGFloat space = KScreenWidth/4;
    
    CGFloat contentViewH = self.contentView.frame.size.height;
    
    CGFloat space2 = (KScreenWidth-(space+20))/3;
    
    UIFont *font = [UIFont systemFontOfSize:10];
    if (self) {
        UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, space +20, contentViewH)];
        [self.contentView addSubview:firstView];
        
        _firstImg = [[UIImageView alloc] initWithFrame:CGRectMake(firstView.frame.size.width/2 - 10, 5, 20, 20)];
        _firstImg.image= [UIImage imageNamed:@"ball"];
        [firstView addSubview:_firstImg];
        
        _firstLB = [[UILabel alloc] initWithFrame:CGRectMake(_firstImg.frame.origin.x, CGRectGetMaxY(_firstImg.frame), 30, 20)];
        _firstLB.text = @"随机";
        _firstLB.font = font;
        [firstView addSubview:_firstLB];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstView.frame), 0, 1, contentViewH)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.5;
        [self.contentView addSubview:lineView];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 44, KScreenWidth - 20, 1)];
        lineView2.backgroundColor = [UIColor lightGrayColor];
        lineView2.alpha = 0.5;
        [self.contentView addSubview:lineView2];
        
        UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(space + 20, 0, KScreenWidth - CGRectGetMaxX(firstView.frame), contentViewH)];
        [self.contentView addSubview:secondView];
        
        UIImageView *secondImg = [[UIImageView alloc] initWithFrame:CGRectMake(space2/2 - 10, 5, 20, 20)];
        secondImg.image = [UIImage imageNamed:@"heng"];
        [secondView addSubview:secondImg];
        
        _secondLB = [[UILabel alloc] initWithFrame:CGRectMake(secondImg.frame.origin.x-10, CGRectGetMaxY(secondImg.frame), 50, 20)];
       _secondLB.text = @"1(50%)";
       _secondLB.font = font;
        _secondLB.textAlignment = NSTextAlignmentCenter;

        [secondView addSubview:_secondLB];
        
        
        UIImageView *thirdImg = [[UIImageView alloc] initWithFrame:CGRectMake(space2*2 - space2/2 -10, 5, 20, 20)];
        thirdImg.image = [UIImage imageNamed:@"xiangxia_zw"];
        [secondView addSubview:thirdImg];
        
         _thirdLB = [[UILabel alloc] initWithFrame:CGRectMake(thirdImg.frame.origin.x - 10, CGRectGetMaxY(thirdImg.frame), 50, 20)];
        _thirdLB.text = @"1(9%)";
        _thirdLB.font = font;
        _thirdLB.textAlignment = NSTextAlignmentCenter;

        [secondView addSubview:_thirdLB];
        
        
        UIImageView * fourImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-(space+20)) - space2/2-10, 5, 20, 20)];
        fourImg.image = [UIImage imageNamed:@"xiangshang_zw"];
        [secondView addSubview:fourImg];
        
        _fourLB = [[UILabel alloc] initWithFrame:CGRectMake(fourImg.frame.origin.x - 10, CGRectGetMaxY(fourImg.frame), 50, 20)];
        _fourLB.text = @"1(100%)";
        _fourLB.font = font;
        _fourLB.textAlignment = NSTextAlignmentCenter;

        [secondView addSubview:_fourLB];
        
        
    }
    return self;
}
@end
