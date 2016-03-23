//
//  SearchErweimaViewController.h
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBarSDK.h"
#import <AVFoundation/AVFoundation.h>



@interface SearchErweimaViewController : UIViewController<ZBarReaderDelegate,AVCaptureMetadataOutputObjectsDelegate,UITableViewDataSource,UITableViewDelegate,WebServiceDelegate>
{
    WebServices *helper;
    UITableView *mainTableView;
    NSArray *_dataDic;
    NSArray *_dataDic2;
    double saomiaostatus;
    
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    
 
}




@property (nonatomic, assign) double saomiaostatus;

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;

//
@property (nonatomic,retain)NSMutableArray *mainSearchArray;


@end
