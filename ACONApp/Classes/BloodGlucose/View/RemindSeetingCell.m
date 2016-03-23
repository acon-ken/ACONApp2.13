//
//  RemindSeetingCell.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 15/1/19.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import "RemindSeetingCell.h"

@interface RemindSeetingCell () <UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    UIView *footview;
    UIDatePicker *_datePicker ;
}
@property (strong, nonatomic) UIView *contextMenuView;
@property (strong, nonatomic) UIButton *moreOptionsButton;
@property (strong, nonatomic) UIButton *deleteButton;
@property (assign, nonatomic, getter = isContextMenuHidden) BOOL contextMenuHidden;
@property (assign, nonatomic) BOOL shouldDisplayContextMenuView;
@property (assign, nonatomic) CGFloat initialTouchPositionX;
@end

@implementation RemindSeetingCell

+ (NSString *)ID
{
    return @"RemindSeetingCell";
}

+ (id)createRemindSeetingCell
{
    return  [[NSBundle mainBundle] loadNibNamed:@"RemindSeetingCell" owner:nil options:nil][0];
}

- (void)awakeFromNib {

    [super awakeFromNib];
    [self setUp];
    
}

- (void)setUp
{
    self.contextMenuView = [[UIView alloc] initWithFrame:self.actualContentView.bounds];
    self.contextMenuView.backgroundColor = self.contentView.backgroundColor;
    [self.contentView insertSubview:self.contextMenuView belowSubview:self.actualContentView];
    self.contextMenuHidden = self.contextMenuView.hidden = YES;
    self.shouldDisplayContextMenuView = NO;
    self.editable = YES;
    self.moreOptionsButtonTitle = @"编辑";
    self.deleteButtonTitle = @"删除";
    self.menuOptionButtonTitlePadding = 25.;
    self.menuOptionsAnimationDuration = 0.3;
    self.bounceValue = 30.;
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.delegate = self;
    [self addGestureRecognizer:panRecognizer];
    [self setNeedsLayout];
}

#pragma mark - Public

- (CGFloat)contextMenuWidth
{
    return CGRectGetWidth(self.deleteButton.frame) + CGRectGetWidth(self.moreOptionsButton.frame);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contextMenuView.frame = self.actualContentView.bounds;
    [self.contentView sendSubviewToBack:self.contextMenuView];
    [self.contentView bringSubviewToFront:self.actualContentView];
    
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat menuOptionButtonWidth = [self menuOptionButtonWidth];
    self.moreOptionsButton.frame = CGRectMake(width - menuOptionButtonWidth - CGRectGetWidth(self.deleteButton.frame), 0., menuOptionButtonWidth, height);
    self.deleteButton.frame = CGRectMake(width - menuOptionButtonWidth, 0., menuOptionButtonWidth, height);
}

- (CGFloat)menuOptionButtonWidth
{
    NSString *string = ([self.deleteButtonTitle length] > [self.moreOptionsButtonTitle length]) ? self.deleteButtonTitle : self.moreOptionsButtonTitle;
    CGFloat width = roundf([string sizeWithFont:self.moreOptionsButton.titleLabel.font].width + 2. * self.menuOptionButtonTitlePadding);
    width = MIN(width, CGRectGetWidth(self.bounds) / 2. - 10.);
    if ((NSInteger)width % 2) {
        width += 1.;
    }
    return width;
}

- (void)setDeleteButtonTitle:(NSString *)deleteButtonTitle
{
    _deleteButtonTitle = deleteButtonTitle;
    [self.deleteButton setTitle:deleteButtonTitle forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)setEditable:(BOOL)editable
{
    if (_editable != editable) {
        _editable = editable;
        [self setNeedsLayout];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (self.contextMenuHidden) {
        self.contextMenuView.hidden = YES;
        [super setHighlighted:highlighted animated:animated];
    }
}

- (void)setMenuOptionButtonTitlePadding:(CGFloat)menuOptionButtonTitlePadding
{
    if (_menuOptionButtonTitlePadding != menuOptionButtonTitlePadding) {
        _menuOptionButtonTitlePadding = menuOptionButtonTitlePadding;
        [self setNeedsLayout];
    }
}

- (void)setMenuOptionsViewHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler
{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGRect frame = CGRectMake((hidden) ? 0 : -[self contextMenuWidth], 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    [UIView animateWithDuration:(animated) ? self.menuOptionsAnimationDuration : 0.
                          delay:0.
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         self.actualContentView.frame = frame;
     } completion:^(BOOL finished) {
         self.contextMenuHidden = hidden;
         self.shouldDisplayContextMenuView = !hidden;
         if (!hidden) {
             [self.delegate contextMenuDidShowInCell:self];
         } else {
             [self.delegate contextMenuDidHideInCell:self];
         }
         if (completionHandler) {
             completionHandler();
         }
     }];
}

- (void)setMoreOptionsButtonTitle:(NSString *)moreOptionsButtonTitle
{
    _moreOptionsButtonTitle = moreOptionsButtonTitle;
    [self.moreOptionsButton setTitle:self.moreOptionsButtonTitle forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.contextMenuHidden) {
        self.contextMenuView.hidden = YES;
        [super setSelected:selected animated:animated];
    }
}

#pragma mark - Private

- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
{
    
    if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)recognizer;
        
        CGPoint currentTouchPoint = [panRecognizer locationInView:self.contentView];
        CGFloat currentTouchPositionX = currentTouchPoint.x;
        CGPoint velocity = [recognizer velocityInView:self.contentView];
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            self.initialTouchPositionX = currentTouchPositionX;
            if (velocity.x > 0) {
                [self.delegate contextMenuWillHideInCell:self];
            } else {
                [self.delegate contextMenuDidShowInCell:self];
            }
        } else if (recognizer.state == UIGestureRecognizerStateChanged) {
            CGPoint velocity = [recognizer velocityInView:self.contentView];
            if (!self.contextMenuHidden || (velocity.x > 0. || [self.delegate shouldShowMenuOptionsViewInCell:self])) {
                if (self.selected) {
                    [self setSelected:NO animated:NO];
                }
                self.contextMenuView.hidden = NO;
                CGFloat panAmount = currentTouchPositionX - self.initialTouchPositionX;
                self.initialTouchPositionX = currentTouchPositionX;
                CGFloat minOriginX = -[self contextMenuWidth] - self.bounceValue;
                CGFloat maxOriginX = 0.;
                CGFloat originX = CGRectGetMinX(self.actualContentView.frame) + panAmount;
                originX = MIN(maxOriginX, originX);
                originX = MAX(minOriginX, originX);
                
                
                if ((originX < -0.5 * [self contextMenuWidth] && velocity.x < 0.) || velocity.x < -100) {
                    self.shouldDisplayContextMenuView = YES;
                } else if ((originX > -0.3 * [self contextMenuWidth] && velocity.x > 0.) || velocity.x > 100) {
                    self.shouldDisplayContextMenuView = NO;
                }
                self.actualContentView.frame = CGRectMake(originX, 0., CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            }
        } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
            [self setMenuOptionsViewHidden:!self.shouldDisplayContextMenuView animated:YES completionHandler:nil];
        }
    }
}

- (void)deleteButtonTapped
{
    if ([self.delegate respondsToSelector:@selector(contextMenuCellDidSelectDeleteOption:)]) {
        [self.delegate contextMenuCellDidSelectDeleteOption:self];
    }
}

- (void)moreButtonTapped
{
    [self.delegate contextMenuCellDidSelectMoreOption:self];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self setMenuOptionsViewHidden:YES animated:NO completionHandler:nil];
}

#pragma mark * Lazy getters

- (UIButton *)moreOptionsButton
{
    if (!_moreOptionsButton) {
        CGRect frame = CGRectMake(0., 0., 100., CGRectGetHeight(self.actualContentView.frame));
        _moreOptionsButton = [[UIButton alloc] initWithFrame:frame];
        _moreOptionsButton.backgroundColor = [UIColor lightGrayColor];
        [self.contextMenuView addSubview:_moreOptionsButton];
        [_moreOptionsButton addTarget:self action:@selector(moreButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreOptionsButton;
}

- (UIButton *)deleteButton
{
    if (self.editable) {
        if (!_deleteButton) {
            CGRect frame = CGRectMake(0., 0., 100., CGRectGetHeight(self.actualContentView.frame));
            _deleteButton = [[UIButton alloc] initWithFrame:frame];
            _deleteButton.backgroundColor = [UIColor colorWithRed:251./255. green:34./255. blue:38./255. alpha:1.];
            [self.contextMenuView addSubview:_deleteButton];
            [_deleteButton addTarget:self action:@selector(deleteButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        }
        return _deleteButton;
    }
    return nil;
}

#pragma mark * UIPanGestureRecognizer delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return fabs(translation.x) > fabs(translation.y);
    }
    return YES;
}


- (void)updateFrame
{
//    if (iOS7) {
//        _titleTF.layer.borderWidth = 0.8;
//        _titleTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        _timeTF.layer.borderWidth = 0.8;
//        _timeTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        _remarkTF.layer.borderWidth = 0.8;
//        _remarkTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    }
//    else
//    {
//        _titleTF.layer.borderWidth = 0.5;
//        _titleTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        _timeTF.layer.borderWidth = 0.5;
//        _timeTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        _remarkTF.layer.borderWidth = 0.5;
//        _remarkTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    }
    footview = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight-50, KScreenWidth, 220)];
    footview.backgroundColor = [UIColor whiteColor];
    footview.userInteractionEnabled = YES;

      
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footview.frame.size.width, 35)];
    redView.userInteractionEnabled = YES;
    redView.backgroundColor = KCommonColor;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(redView.frame.size.width-80, 0, 80, 39);
    rightBtn.selected=YES;
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(dismissRedviewBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
        //PickerView上面ToolBar的小时LB
    UILabel *HourLB = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-55, 5, 40, 30)];
    HourLB.font = [UIFont boldSystemFontOfSize:17.0f];
    HourLB.textColor = [UIColor whiteColor];
    HourLB.text =@"小时";
    
        //PickerView上面ToolBar的分钟LB
    UILabel *minitLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(HourLB.frame)+30, HourLB.frame.origin.y, HourLB.frame.size.width, HourLB.frame.size.height)];
    minitLB.font = [UIFont boldSystemFontOfSize:17.0f];
    minitLB.textColor = [UIColor whiteColor];
    minitLB.text =@"分钟";
    
    
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeTime];
    [_datePicker setFrame:CGRectMake(0, CGRectGetMaxY(redView.frame), footview.frame.size.width, footview.frame.size.height-redView.frame.size.height)];
    _datePicker.userInteractionEnabled =YES;
    [_datePicker addTarget:self action:@selector(birthdayChange:) forControlEvents:UIControlEventValueChanged];
   
    

    [redView addSubview:HourLB];
    [redView addSubview:minitLB];
    [redView addSubview:rightBtn];
//    [_datePicker addSubview:redView];
//    _timeTF.inputView = _datePicker;
   
    [footview addSubview:redView];
    [footview addSubview:_datePicker];
    _timeTF.inputView = footview;

}

-(void)dismissRedviewBtnAction{
    footview.hidden = YES;
    [_timeTF resignFirstResponder];
    NSLog(@"22222222");
}

- (void)RemindInformationWithDict:(NSDictionary *)dict editionBool:(BOOL)editionBool
{
    if (editionBool) {
        
        //        [_titleTF becomeFirstResponder];
        _titleTF.enabled = YES;
        _timeTF.enabled = YES;
        _remarkTF.enabled = YES;
        
    }else{
        _titleTF.enabled = NO;
        _timeTF.enabled = NO;
        _remarkTF.enabled = NO;
    }
    
    _titleTF.text = dict[@"title"];
    _timeTF.text = dict[@"time"];
    _remarkTF.text = dict[@"remark"];
    
    _remindID = dict[@"ID"];
    _titleTF.delegate = self;
    _timeTF.delegate = self;
    _remarkTF.delegate = self;
    
}

- (void)CellBecomeFirstResponderEditionBool:(BOOL)editionBool
{
//    if (bKeyBoardHide) {
//        [_titleTF becomeFirstResponder];
//    }
//    else
//    {
//        [_titleTF resignFirstResponder];
//    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    footview.hidden = NO;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ID"] = _remindID;
    params[@"title"] = _titleTF.text;
    params[@"time"] = _timeTF.text;
    params[@"remark"] = _remarkTF.text;
    params[DEF_ACONUserID] = [[[SaveUserInfo loadCustomObjectWithKey] data]dataIdentifier];

    if ([_delegate respondsToSelector:@selector(RemindInformationWithEditionDict:)]) {
        [_delegate RemindInformationWithEditionDict:params];
    }
}
- (void)birthdayChange:(UIDatePicker *)picker
{
    
    // 1.取得当前时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    NSString *time = [fmt stringFromDate:picker.date];
    
    // 2.赋值到文本框
    _timeTF.text = time;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(RemindInformationWithBeginEdit:)]) {
        [_delegate RemindInformationWithBeginEdit:textField];
    }
}


@end
