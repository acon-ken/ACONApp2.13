//
//  Example2PieView.m
//  MagicPie
//
//  Created by Alexander on 30.12.13.
//  Copyright (c) 2013 Alexandr Corporation. All rights reserved.
//

#import "Example2PieView.h"
#import "MagicPieLayer.h"

@interface Example2PieView ()
@end

@implementation Example2PieView

+ (Class)layerClass
{
    return [PieLayer class];
}

- (id)init
{
    self = [super init];
    if(self){
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}

- (void)setup
{
    /**/
    /**/
    if (IS_IPHONE_6) {
        self.layer.maxRadius = 120;
        self.layer.minRadius = 110;
    }
    else
    {
        self.layer.maxRadius = 100;
        self.layer.minRadius = 90;
    }
    
    self.layer.animationDuration = 0.6;
    self.layer.showTitles = ShowTitlesIfEnable;
    if ([self.layer.self respondsToSelector:@selector(setContentsScale:)])
    {
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)handleTap:(UITapGestureRecognizer*)tap
{
    if(tap.state != UIGestureRecognizerStateEnded)
        return;
    
    CGPoint pos = [tap locationInView:tap.view];
    
    PieElement* tappedElem = [self.layer pieElemInPoint:pos];
    if(!tappedElem)
        return;
//    
//    if(tappedElem.centrOffset > 0){
//        tappedElem.centrOffset = 0;
//
//        tappedElem = nil;
//    }else{
//            
//        }
    
    [PieElement animateChanges:^{
        
        if (tappedElem.centrOffset > 0) {
            tappedElem.centrOffset = 0;
        }else{
            
             tappedElem.centrOffset = 5;
        }
        
//        for(PieElement* elem in self.layer.values){
//
//            if (elem.centrOffset == 20) {
//                elem.centrOffset = tappedElem ==  elem? 0 : 0;
//            }else{
//                
//                 elem.centrOffset = tappedElem ==  elem? 20 : 20; ;
//            }
//            
//        }
    }];
}

@end