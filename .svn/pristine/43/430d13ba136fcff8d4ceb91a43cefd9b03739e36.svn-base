//
//  BloodGlucoseCell.h
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/9.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BloodGlucoseManageModel.h"
@interface BloodGlucoseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *dateLB;//最近一周
@property (weak, nonatomic) IBOutlet UILabel *rateLB;//达标率
@property (weak, nonatomic) IBOutlet UILabel *testLB;//测试
@property (weak, nonatomic) IBOutlet UILabel *overproofLB;//超标
@property (weak, nonatomic) IBOutlet UILabel *afterValueLB1;//餐后平均
@property (weak, nonatomic) IBOutlet UILabel *MaxValueLB;//最高
@property (weak, nonatomic) IBOutlet UILabel *MinValueLB;//最低
@property (weak, nonatomic) IBOutlet UILabel *afterValueLB2;//空腹平均
@property (weak, nonatomic) IBOutlet UILabel *meanValueLB;//平均
@property (weak, nonatomic) IBOutlet UILabel *afterValueLB3;//餐前平均
@property (weak, nonatomic) IBOutlet UILabel *randomValueLB;//随机平均

@property (strong, nonatomic) BloodGlucoseManageModel *bloodModel;
- (void)initView;

+ (NSString *)ID;
+ (id)createBloodGlucoseCell;
@end
