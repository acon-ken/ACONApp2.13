//
//  LineChartCiewCell.h
//  ACONApp
//
//  Created by HYM on 14/12/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartCiewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *grayLine;
@property (weak, nonatomic) IBOutlet UIImageView *statueImageView;
@property (weak, nonatomic) IBOutlet UILabel *statuesLB;
@property (weak, nonatomic) IBOutlet UILabel *valueLB;
@property (weak, nonatomic) IBOutlet UILabel *dateLB;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIView *grayLineBottom;
@end
