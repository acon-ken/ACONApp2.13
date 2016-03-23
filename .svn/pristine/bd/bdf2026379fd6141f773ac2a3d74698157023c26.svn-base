//
//  PopoverView.h
//  Embark
//
//  Created by Oliver Rickard on 20/08/2012.
//
//

#import <UIKit/UIKit.h>

@class BMPopView;

@protocol BMPopViewDelegate <NSObject>

@optional

- (void)popViewDidDismiss:(BMPopView *)popView;

@end

@interface BMPopView : UIView {

}

@property (nonatomic, retain) UIView *contentView;

@property (nonatomic, assign) id<BMPopViewDelegate> delegate;

+(BMPopView *)shareInstance;
+ (BMPopView *)showWithContentView:(UIView *)cView delegate:(id<BMPopViewDelegate>)delegate;

- (void)showWithContentView:(UIView *)cView delegate:(id<BMPopViewDelegate>)delegate;
- (void)showWithContentView:(UIView *)cView;

- (void)dismiss;


@end
