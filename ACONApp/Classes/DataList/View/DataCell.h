//
//  DataCell.h
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/8.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DateLB;//日期
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;//时间
@property (weak, nonatomic) IBOutlet UILabel *ValueLB;//血糖值
@property (weak, nonatomic) IBOutlet UILabel *UnitLB;//单位
@property (weak, nonatomic) IBOutlet UILabel *StateLB;//时间段。空腹
@property (weak, nonatomic) IBOutlet UILabel *markLB;

+ (NSString *)ID;
+ (id)createDataCell;

@end
