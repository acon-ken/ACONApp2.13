

#import "ConnectDeviceViewController.h"

#import "BloodGlucoseManageController.h"

#import "BMPopView.h"
#import "NewestDataModel.h"
#import "NewestData.h"

typedef enum : NSUInteger {
    GlucoseMeterDataStateT = 0,//发送T指令状态
    GlucoseMeterDataStateN,// 返回数据状态
    GlucoseMeterDataStateError,// 错误状态
}GlucoseMeterDataState;
@interface ConnectDeviceViewController (){
    
    UILabel *deviceState;
    
    NSMutableArray *valueArry;
    NSMutableArray *timeArry;
    NSMutableArray *markArray;
    
    CFUUIDRef BlueToothdevUUID;
    
    UILabel *infor;
    
    NSMutableArray *BlueDataArr;    //蓝牙获取的数据
    int _timeout;// 操作超时！
    NSString *dataStr;
    
    NewestData *newestData;///血糖最新值
    
}
@property (copy, nonatomic) NSString *meterID;//设备ID
@property (copy, nonatomic) NSString *recDataStr;
@property (assign, nonatomic) GlucoseMeterDataState meterState;
@end

@implementation ConnectDeviceViewController


@synthesize state=_state;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KBackgroundColor;
    self.title = @"血糖测量";
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBarHidden = NO;
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    


    [self createContentView];
    [self createFooterView];
    
    
    
    [self bluetoothInit];
    
    
    helper = [[WebServices alloc] initWithDelegate:self];
    BlueDataArr= [NSMutableArray array];
    valueArry=[NSMutableArray array];
    timeArry=[NSMutableArray array];
    markArray = [NSMutableArray array];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
}


- (void)createContentView
{
    UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 64, KScreenWidth - 50*2, 220)];
   // contentView.image = [UIImage imageNamed:@"wifi2.png"];
    contentView.image = [UIImage imageNamed:@"blueToothBG.png"];
    [self.view addSubview:contentView];
    
    
    infor= [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-90, 200, 180, 40)];
    infor.text= @"开始下载";
    infor.textAlignment= NSTextAlignmentCenter;
    [self.view addSubview:infor];
    
    UIButton *downLoadBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth/2-20, 260, 40, 40)];
    // [leftBtn setTitle:@"血糖控制" forState:UIControlStateNormal];
    [downLoadBtn setBackgroundImage:[UIImage imageNamed:@"yun"] forState:UIControlStateNormal];
    [downLoadBtn setBackgroundImage:[UIImage imageNamed:@"yun_pressed"] forState:UIControlStateSelected];
    [downLoadBtn  addTarget:self action:@selector(downLoadClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downLoadBtn];
    
}

- (void)createFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 150, KScreenWidth, 40)];
    [self.view addSubview:footerView];
    
    CGFloat Kborder = (KScreenWidth - 120*2)/3;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(Kborder, 0, 120, 40)];
    [leftBtn setTitle:@"血糖控制" forState:UIControlStateNormal];
    leftBtn.tag = 2999;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"anniu"] forState:UIControlStateNormal];
    [leftBtn  addTarget:self action:@selector(backClick111:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftBtn.frame) + Kborder, 0, 120, 40)];
    [rightBtn setTitle:@"吃药提醒" forState:UIControlStateNormal];
    rightBtn.tag = 1999;
    [rightBtn  addTarget:self action:@selector(backClick111:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"anniu"] forState:UIControlStateNormal];
    [footerView addSubview:rightBtn];
}

-(void)downLoadClick:(id)sender{

  //  [iGate startSearch];
    
    if(self.state == CiGateStateBonded)
    {
        _timeout = 60;
        [self startTime];
//       [AppHelper showHUD:@"请等待"];
        
//        [NSTimer scheduledTimerWithTimeInterval:120.0
//                                         target:self
//                                       selector:@selector(removeHUD:)
//                                       userInfo:Nil
//                                        repeats:NO];
        self.meterState = GlucoseMeterDataStateT;
        [self sendCommendassembly];

        
    }

}


-(void)removeHUD:(id)sender{
    
    [AppHelper removeHUD];
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"下载数据失败，请检查蓝牙设备" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
    [alertView show];
}


-(void)backClick111:(UIButton *)sender{
    BloodGlucoseManageController *blood = [[BloodGlucoseManageController alloc]init];
    if (sender.tag == 2999) {
      
        blood.selectBtn = NO;
    }
    else
    {
        blood.selectBtn = YES;
    }
    [self.navigationController pushViewController:blood animated:YES];

}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 蓝牙初始化
- (void)bluetoothInit
{
    
    deviceState= [[UILabel alloc]init];
    
    // Get the UUID from setting bundle
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";

    iGate = [[CiGate alloc] initWithDelegate:self autoConnectFlag:TRUE serviceUuidStr:serviceUUIDStr];
//    iGate = [[CiGate alloc] initWithDelegate:self autoConnectFlag:FALSE serviceUuidStr:serviceUUIDStr];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // If the app want to connect to a known device only, set the bonded UUID when
    // init iGate, or use setBondDevUUID.
    // The bond UUID is got from last connected device's UUID by
    // - (CFUUIDRef) getConnectDevUUID;
    // In an actual app, the bond UUID and the device name may be stored and reloaded
    // when the app restarts.
    //CFUUIDRef tmpUUID=CFUUIDCreateFromString(kCFAllocatorDefault, @"00000000-0000-0000-0C86-003D067A170D");
    //[iGate setBondDevUUID:tmpUUID];
    // CFRelease(tmpUUID);
    
    proInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [proInd setCenter:CGPointMake(159, 19)];
    
  //  [self.navigationController.view addSubview:proInd];
    
    self.recDataStr=@"";
    // _rxFormat=0;
    NSLog(@"view load");
}



#pragma mark - CiGateDelegate methods

/*
 Invoked whenever the central manager's state is updated.
 */
- (void)iGateDidUpdateState:(CiGateState)iGateState
{
    [self setState:iGateState];
    switch(iGateState)
    {
        case CiGateStateInit:
            deviceState.text=@"Init";
            //[self enableControls:false];
            break;
        case CiGateStateIdle:
            deviceState.text=@"Idle";
            infor.text= @"空闲中";
            //[self enableControls:false];
            break;
        case CiGateStatePoweredOff:
            deviceState.text=@"Bluetooth power off";
            infor.text= @"蓝牙断开";
            //[self enableControls:false];
            break;
        case CiGateStateUnknown:
            deviceState.text=@"Bluetooth unknown";
            //  [self enableControls:false];
            break;
        case CiGateStateUnsupported:
            deviceState.text=@"BLE not supported";
            //  [self enableControls:false];
            break;
        case CiGateStateSearching:
            deviceState.text=@"Searching";
            infor.text= @"搜索中,请开蓝牙电源";
            [proInd startAnimating];
            //[self enableControls:false];
            break;
        case CiGateStateConnecting:
            if([iGate getConnectDevName]){
                deviceState.text=[@"Connecting " stringByAppendingString:[iGate getConnectDevName]];
                infor.text= @"连接中";
            }
            else
                deviceState.text=@"Connecting iGate";
            //   [self enableControls:false];
            break;
        case CiGateStateConnected:
            if([iGate getConnectDevName])
                deviceState.text=[@"Connected " stringByAppendingString:[iGate getConnectDevName]];
            else
                deviceState.text=@"Connected iGate";
            //   [self enableControls:false];
            break;
        case CiGateStateBonded:
            [proInd stopAnimating];
            //   [self enableControls:true];
            if([iGate getConnectDevName])
            {
                infor.text= @"已绑定，请按下载按钮";
                deviceState.text=[@"Bonded " stringByAppendingString:[iGate getConnectDevName]];
            }
            else
                deviceState.text=@"Bonded iGate";
            break;
    }
    NSLog(@"%@, State %@",iGate,deviceState.text);
    [[AppHelper shareInstance]removeHUD_H];
}

- (void)iGateDidReceivedData:(NSData *)data
{
    /* need to delegate function */
    NSLog(@"input report received %@",data);
    NSData * updatedValue = data;
//    uint8_t* dataPointer = (uint8_t*)[updatedValue bytes];
    

    _timeout = 60;
    
    //不累加，获取每条数据
//   self.recDataStr=[self.recDataStr stringByAppendingFormat:@"%s",dataPointer];
//    self.recDataStr= [NSString stringWithFormat:@"%s",dataPointer];
    
    self.recDataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    NSLog(@"new rx %@",self.recDataStr);
    
    
    /**
     *  @author HYM, 15-01-30 15:01:33
     *
     *  CRC效验失败
     */
    NSString *crcError = @"&z ";
    if([self.recDataStr hasPrefix:crcError])
    {
        NSString *code = [NSString stringWithFormat:@"%@%u",crcError,CRC16_Modbus([crcError UTF8String], crcError.length)];
        if ([self.recDataStr hasPrefix:code])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉！" message:@"crc校验 失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [[AppHelper shareInstance]removeHUD_H];
            
            [self blueToothPowerOFF];// 蓝牙关机
            
            return;
        }
    }
    
   // if ([self.recDataStr isEqualToString:@"&M0 41870"]) {


    
    /**
     *  @author HYM, 15-01-30 15:01:08
     *
     *  &M  设备 命令
     */
    if ([self.recDataStr hasPrefix:@"&M"]) {
        
        /**
         *  @author HYM, 15-01-30 15:01:30
         *
         *  设备连接失败
         */
        NSString *readMeterIdFiled = @"&M0 ";
        if([self.recDataStr hasPrefix:readMeterIdFiled])
        {
            NSString *code = [NSString stringWithFormat:@"%@%u",readMeterIdFiled,CRC16_Modbus([readMeterIdFiled UTF8String], readMeterIdFiled.length)];
            
            if ([self.recDataStr isEqualToString:code])
            {
                /*
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉！" message:@"连接设备失败，请重新选择设备！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                 */
                
                [self sendCommendassembly];
                
                return;
            }
        }
        
        /**
         *  @author HYM, 15-01-30 15:01:32
         *
         *  数据为正确ID长度
         */
        if (self.recDataStr.length >= 12+2 )
        {
            
            NSString *str = [self.recDataStr substringToIndex:11+2+1];
            NSString *chechStr = [NSString stringWithFormat:@"%@%u",str,CRC16_Modbus([str UTF8String], str.length)];
            if(![self.recDataStr hasPrefix:chechStr])
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉！" message:@"meter ID CRC验证失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                
                [self blueToothPowerOFF];// 蓝牙关机
                
                return;
            }
            self.meterID = [self.recDataStr substringToIndex:11 + 2];
            self.meterID = [self.meterID substringFromIndex:2];
            [self requestGetGlucoseByDateMethodName];
            _timeout = 60;

        }
        
        return;
    }
    
    /**
     *  @author HYM, 15-01-30 16:01:51
     *
     *  发送最近一条记录
     */
    NSString *D_Str = @"&D1 ";
    if ([self.recDataStr hasPrefix:D_Str]) {
        NSString *str = [self.recDataStr substringToIndex:D_Str.length];
        NSString *chechStr = [NSString stringWithFormat:@"%@%u",str,CRC16_Modbus([str UTF8String], str.length)];
        if(![self.recDataStr hasPrefix:chechStr])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@ 效验失败",self.recDataStr] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [self blueToothPowerOFF];// 蓝牙关机
            
            [[AppHelper shareInstance]removeHUD_H];
            
            return;
        }
        
        /**
         *  @author HYM, 15-01-30 15:01:59
         *
         *  时间发送成功 发送数据R &N1001130113 149 0
         */
        if (newestData!=nil) {
            
            NSString *record = @"&R";
            record = [record stringByAppendingFormat:@"%d ",[newestData.measureValueOldFormat intValue]];
            [self sendBlueToothData:[NSString stringWithFormat:@"%@%u",record,CRC16_Modbus([record UTF8String], record.length)]];
            [[AppHelper shareInstance]showHUD_H:[NSString stringWithFormat:@"APP_2_BLE %@...",record] ];
        }

    }
    
    NSString *R_Str = @"&R1 ";
    if ([self.recDataStr hasPrefix:R_Str]) {
        NSString *str = [self.recDataStr substringToIndex:R_Str.length];
        NSString *chechStr = [NSString stringWithFormat:@"%@%u",str,CRC16_Modbus([str UTF8String], str.length)];
        if(![self.recDataStr hasPrefix:chechStr])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@ 效验失败",self.recDataStr] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [self blueToothPowerOFF];// 蓝牙关机
            
            [[AppHelper shareInstance]removeHUD_H];
            return;
        }
        
        /**
         *  @author HYM, 15-01-30 15:01:59
         *
         *  血糖值发送成功 发送数据K &N1001130113 149 0
         */
        if (newestData!=nil) {
            NSString *record = @"&K";
            record = [record stringByAppendingFormat:@"%@ ",newestData.mark];
            [self sendBlueToothData:[NSString stringWithFormat:@"%@%u",record,CRC16_Modbus([record UTF8String], record.length)]];
            [[AppHelper shareInstance]showHUD_H:[NSString stringWithFormat:@"APP_2_BLE %@...",record] ];
        }
    }
    
    
    NSString *K_Str = @"&K1 ";
    if ([self.recDataStr hasPrefix:K_Str]) {
        NSString *str = [self.recDataStr substringToIndex:K_Str.length];
        NSString *chechStr = [NSString stringWithFormat:@"%@%u",str,CRC16_Modbus([str UTF8String], str.length)];
        if(![self.recDataStr hasPrefix:chechStr])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@ 效验失败",self.recDataStr] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [self blueToothPowerOFF];// 蓝牙关机
            
            [[AppHelper shareInstance]removeHUD_H];
            return;
        }
        
        /**
         *  @author HYM, 15-01-30 15:01:59
         *
         *  Mark 发送成功 发送 &N 命令  请求数据
         */
        
        self.recDataStr = @"";
        dataStr = @"";
        [BlueDataArr removeAllObjects];
        
        NSString *record = @"&N0 ";
        [self sendBlueToothData:[NSString stringWithFormat:@"%@%u",record,CRC16_Modbus([record UTF8String], record.length)]];
        self.meterState = GlucoseMeterDataStateN;
        [[AppHelper shareInstance]showHUD_H:@"请求数据中..." ];
        
    }


    /**
     *  @author HYM, 15-01-30 15:01:33
     *
     *  &N 数据 命令 取数据
     */
    if ([self.recDataStr hasPrefix:@"&N"]) {
        NSString *Ny = @"&Ny ";
        if ([self.recDataStr hasPrefix:Ny] && [self.recDataStr hasPrefix:[NSString stringWithFormat:@"%@%u",Ny, CRC16_Modbus([Ny UTF8String], Ny.length)]])
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉！" message:@"读取数据失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [self blueToothPowerOFF];// 蓝牙关机

            [[AppHelper shareInstance]removeHUD_H];
            return;
        }
        
        //添加获取的多条数据
        /**
         *  @author HYM, 15-01-30 15:01:10
         *
         *  过滤crc效验码 加入BlueDataArr 中
         */
        if (self.recDataStr.length >= 12+2) {
            [BlueDataArr addObject:self.recDataStr];
            [[AppHelper shareInstance]showHUD_H:@"下载数据中..." ];
        }
        dataStr = [dataStr stringByAppendingString:self.recDataStr];

      
        
        //解析数据
        NSMutableArray *strArray=[NSMutableArray arrayWithArray:[self.recDataStr componentsSeparatedByString:@" "]];
        if ([strArray count]==1 ) //** 收到的是 CRC 效验码 */
        {
            /* crc 校验 */
            NSString *str = @"&N";
            NSString *checkStr = [self.recDataStr substringFromIndex:str.length + 1];//&N<0x06><CRC><0x1F>   加 ＋1找到CRC

            
            NSString *st = [dataStr substringToIndex:[dataStr rangeOfString:checkStr].location-1];//&N<0x06><CRC><0x1F>   加 -1找到删去<0x06>

            
            NSString *strCRC = [NSString stringWithFormat:@"%d",CRC16_Modbus([st UTF8String], st.length)];
            
            if ([checkStr hasPrefix:strCRC])
            {   //效验成功 解析数据
                
                [self blueToothPowerOFF];// 蓝牙关机

                [self analysisData2];
                NSLog(@" \n\n 数据总数  %d\n\n",BlueDataArr.count);
                [self blueToothPowerOFF];// 蓝牙关机

                
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉！" message:@"crc 返回数据校验失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [[AppHelper shareInstance]removeHUD_H];

                [self blueToothPowerOFF];// 蓝牙关机
                return;
            }

            [[AppHelper shareInstance]removeHUD_H];
            
        }else if ([strArray count] ==2) //** 收到的是数据开始的CRC 数据记录 */
        {
            dataStr = [dataStr substringToIndex:[dataStr rangeOfString:self.recDataStr].location];

            NSLog(@" \n\n 数据总数A  %@\n\n",self.recDataStr );

            
            NSString *str = [NSString stringWithFormat:@"%@ ",strArray[0]];
            BOOL checkPass = [self.recDataStr hasPrefix:[NSString stringWithFormat:@"%@%u",str,CRC16_Modbus([str UTF8String], str.length)]];
            
            if (!checkPass)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉！" message:@"crc 返回数据校验失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [[AppHelper shareInstance]removeHUD_H];
                
                [self blueToothPowerOFF];// 蓝牙关机

                return;
            }
        }
        return;
    }
    
//     //添加获取的多条数据
//    [BlueDataArr addObject:self.recDataStr];

}

- (void)iGateDidUpdateConnectDevRSSI:(NSNumber *)rssi error:(NSError *)error
{
    NSLog(@"rssi updated");
    if(error==nil)
    {
        NSLog(@"rssi updated %@",rssi);
        self.recDataStr=[self.recDataStr stringByAppendingFormat:@"%@",rssi];
        //  self.recData.text=self.recDataStr;
    }
}

-(void)iGateDidUpdateConnectDevAddr:(CBluetoothAddr *)addr
{
    NSLog(@"iGateDidUpdateConnectDevAddr: connected device address is %04x%02x%06x",addr->nap,addr->uap,addr->lap);
}


- (void)iGateDidUpdateConnectDevAIO:(integer_t)aioSelector level:(integer_t)aioLevel
{
    NSLog(@"iGateDidUpdateConnectDevAIO %04x %04x",aioSelector,aioLevel);
    self.recDataStr=[self.recDataStr stringByAppendingFormat:@"\r\naio:%04x, level:%04x",aioSelector,aioLevel];
    //  self.recData.text=self.recDataStr;
}


-(void)iGateDidFoundDevice:(CFUUIDRef)devUUID name:(NSString *)devName RSSI:(NSNumber *)RSSI{
    
    BlueToothdevUUID= devUUID;
    NSLog(@"found a igate device: %@",devName);
    [iGate connectDevice:devUUID deviceName:devName];
}


#pragma mark 尝试连接蓝牙
-(void)sendBlueToothData:(NSString *)commandStr{
    
    if(self.state == CiGateStateBonded)
    {
     //   NSString * sendData= @"&N0 41854";
        NSString * sendData= commandStr;
        NSMutableData *valData; //=[NSMutableData dataWithLength:OUT_REPORT_LEN];
        if(sendData.length>IGATE_MAX_SEND_DATE_LEN)
        {
            valData = [NSData dataWithBytes:(void*)[sendData UTF8String] length:IGATE_MAX_SEND_DATE_LEN];
        }
        else
        {
            valData = [NSData dataWithBytes:(void*)[sendData UTF8String] length:sendData.length];
        }
        
        [iGate sendData:valData];
        NSLog(@"Write data, the first 20 byte of %@", sendData);
        //[iGate getConnectDevRSSI];
        //[iGate readConnectDevAioLevel:0];
    }
    else {
        NSLog(@"Send fail, not bonded yet");
    }
    
}

//发送meter指令后，再发Record指令
-(void)sendCommendassembly{
    
    //None 0, OCP 1, OCXP 2, OCP II 3, 4 RESERVED, OCRS 5, OCV 6, OCV PAL7,OCA 8,OCC 9, OCPL A,OCS B,OCX C,OCSH D, OCGK E, F RESERVED
   [[AppHelper shareInstance] showHUD_H:@"正在连接血糖仪..." ];//显示动画
    static NSUInteger i = 0;
    NSString *str;
    NSUInteger m = i/16;
    if (m >=3) {
        [[AppHelper shareInstance] removeHUD_H];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉！" message:@"检测血糖仪超时！" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        [self blueToothPowerOFF];
        
        i = 0;
//        self.meterState = GlucoseMeterDataStateT;
        return;
    }
    NSUInteger j = i%16;

    if (j < 10) {
        str = [NSString stringWithFormat:@"%0.1d",j];
    }else
    {
        str = [self intToHex:j];
    }
    NSString *meter = [NSString stringWithFormat:@"&T%@ ",str];//@"&T3 ";
    [self sendBlueToothData:[NSString stringWithFormat:@"%@%u",meter,CRC16_Modbus([meter UTF8String], meter.length)]];
    NSLog(@" 发送指令%@",[NSString stringWithFormat:@"%@%u",meter,CRC16_Modbus([meter UTF8String], meter.length)]);
    i++;
//    [self sendBlueToothData:@"&T3 37983"];
    
}

#pragma mark 蓝牙关机
/**
 *  @author HYM, 15-01-30 17:01:01
 *
 *  蓝牙关机
 */
- (void)blueToothPowerOFF
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *record = @"&P1 ";
        if (self) {
            [self sendBlueToothData:[NSString stringWithFormat:@"%@%u",record,CRC16_Modbus([record UTF8String], record.length)]];
        }
        
        
    });
  
}


- (NSString *)intToHex:(int)i
{
    switch (i) {
        case 10:
        {
            return @"A";
        }
            break;
        case 11:
        {
            return @"B";
        }
            break;
        case 12:
        {
            return @"C";
        }
            break;
        case 13:
        {
            return @"D";
        }
            break;
        case 14:
        {
            return @"E";
        }
            break;
        case 15:
        {
            return @"F";
        }
            break;
        default:
        {
            return @"";
        }
            break;
    }
}



-(void)disconnectBlueTooth{
    
    [iGate disconnectDevice:BlueToothdevUUID];
}

#pragma mark -
#pragma mark 上传数据

- (void)insertData{
    
    NSLog(@"[valueArry count]:%d",[valueArry count]);
    if ([valueArry count]<=0) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"蓝牙数据下载成功，0条新增数据" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    [[AppHelper shareInstance]showHUD_H:@"上传数据中..." ];//显示动画
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    NSMutableString *sbJSON = [[NSMutableString alloc] initWithString:@"["];
    for (int i=0; i<[valueArry count]; i++) {
        [sbJSON appendFormat:@"{\"MeasureTimeFormat\":\"%@\",\"MeasureValueOldFormat\":\"%@\",\"PeriodType\":\"%@\",\"Mark\":\"%@\",\"MeterId\":\"%@\"},",[timeArry objectAtIndex:i] ,[valueArry objectAtIndex:i],[self convertMark:markArray[i]],[markArray objectAtIndex:i],self.meterID];
    }
    [sbJSON deleteCharactersInRange:NSMakeRange([sbJSON length] - 1,1)];
    [sbJSON appendString:@"]"];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:sbJSON,@"data", nil]];
    
//    NSString *str = @"[{\"MeasureTimeFormat\":\"2013-10-01 06:55:00\",\"MeasureValueOldFormat\":\"94\",\"PeriodType\":\"4\",\"Mark\":\"0\",\"MeterId\":\"103J10027D1\"}]";
////    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"d46452a6-92e7-496d-b2ef-a41f01373571",@"u_Id", nil]];
//    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:str,@"data", nil]];

    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:InsertGlucoseCopyMethodName];
    
    WebServices *services = [[WebServices alloc]init];
   
    [services asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:InsertGlucoseCopyMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        
        [[AppHelper shareInstance]removeHUD_H];

        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            NSString *status = [NSString stringWithFormat:@"%@",resultsDictionary[@"status"]];
            if ([status isEqualToString:@"0"])
            {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:resultsDictionary[@"msg"] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                [alertView show];
                
            }
            else
            {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:resultsDictionary[@"msg"] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                [alertView show];
                
            }
            
        }
        else
        {
            NSLog(@"网络异常！");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
        }
    }];
   /*
    return;
    
    
    //执行同步并取得结果
    NSString *json = [helper syncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:InsertGlucoseCopyMethodName soapMessage:soapMsg];
    
    if(![json isEqualToString:@""])
    {
        //返回的json字符串转换成NSDictionary
        NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
        
        NSString *status = [NSString stringWithFormat:@"%@",resultsDictionary[@"status"]];
        if ([status isEqualToString:@"0"])
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:resultsDictionary[@"msg"] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
            
        }
        else
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:resultsDictionary[@"msg"] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
            
        }
    }
    else
    {
        NSLog(@"网络异常！");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请求失败，请重试" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alertView show];
    }
    
    
    [[AppHelper shareInstance]removeHUD_H];
    */
}


-(NSString *)transTime:(NSString*)blueToothTime{
    
    NSString *tt= [NSString stringWithFormat:@"20%@-%@-%@ %@:%@:00",[blueToothTime substringWithRange:NSMakeRange(6,2)],[blueToothTime substringWithRange:NSMakeRange(2,2)],[blueToothTime substringWithRange:NSMakeRange(4,2)],[blueToothTime substringWithRange:NSMakeRange(8,2)],[blueToothTime substringWithRange:NSMakeRange(10,2)]];
    return tt;
}

-(void)analysisData2{
    /*
    if ([BlueDataArr count]==1) {
        return;
    }
    */
    
    [valueArry removeAllObjects];
    [timeArry removeAllObjects];
    [markArray removeAllObjects];
    for (int i=0; i< [BlueDataArr count]; i++) {
        NSString* iData=[BlueDataArr objectAtIndex:i];
        NSArray * recArray=[iData componentsSeparatedByString:@" "];
        NSString *iValue=[recArray objectAtIndex:1];
        [valueArry addObject:iValue];
        
        NSString *iTime=[recArray objectAtIndex:0];
        [timeArry addObject: [self transTime:iTime]];
        
        NSString *mark=[recArray objectAtIndex:2];
        mark = [mark substringToIndex:mark.length-1];
        [markArray addObject:mark];
    }
    if (BlueDataArr.count>=1) {
        NSString *str = timeArry[0];
        
        NSString *str2 = [str stringByReplacingCharactersInRange: NSMakeRange(str.length-1, 1)withString:@"1"];
        timeArry[0] = str2;
    }

//    self.meterState = GlucoseMeterDataStateT;
    [[AppHelper shareInstance]removeHUD_H];
    [self insertData];
}
/**
 *  @author HYM, 15-02-02 18:02:57
 *
 *  获取用户血糖最新纪录，
 */
- (void)requestGetGlucoseByDateMethodName
{
    
    NSLog(@"[valueArry count]:%d",[valueArry count]);
    
    [[AppHelper shareInstance]showHUD_H:@"上传数据中..." ];//显示动画
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"userId", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.meterID,@"meterId", nil]];
    
    
//    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"103J10027D1",@"meterId", nil]];

    
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetGlucoseByDateMethodName];
    //执行同步并取得结果
    NSString *json = [helper syncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetGlucoseByDateMethodName soapMessage:soapMsg];
    
    if(![json isEqualToString:@""])
    {
        //返回的json字符串转换成NSDictionary
        NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
        
        NSString *status = [NSString stringWithFormat:@"%@",resultsDictionary[@"status"]];
        if ([status isEqualToString:@"0"])
        {
            NewestDataModel *model = [NewestDataModel modelObjectWithDictionary:resultsDictionary];
            
            newestData = model.data;
#warning 判断 newestData.mark 是否为空
            NSDateFormatter *formater = [[NSDateFormatter alloc]init];
             [formater setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
            NSDate *date = [formater dateFromString:newestData.measureTimeFormat];
            [formater setDateFormat:@"MMddyyHHmm"];
            
            
            NSString *record = @"&D";
            record = [record stringByAppendingFormat:@"%@ ",[formater stringFromDate:date]];
            [self sendBlueToothData:[NSString stringWithFormat:@"%@%u",record,CRC16_Modbus([record UTF8String], record.length)]];
            [[AppHelper shareInstance]showHUD_H:[NSString stringWithFormat:@"APP_2_BLE %@...",record] ];
        }
        else
        {
            newestData = nil;

            self.recDataStr = @"";
            dataStr = @"";
            [BlueDataArr removeAllObjects];
            
            NSString *record = @"&N0 ";
            [self sendBlueToothData:[NSString stringWithFormat:@"%@%u",record,CRC16_Modbus([record UTF8String], record.length)]];
            self.meterState = GlucoseMeterDataStateN;
            [[AppHelper shareInstance]showHUD_H:@"请求数据中..." ];
            return;
            
        }

    }
    else
    {
        NSLog(@"网络异常！");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请求最新记录失败，请重试" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alertView show];
    }
    
    
    [[AppHelper shareInstance]removeHUD_H];
}


#pragma mark -
#pragma mark 工具类
- (NSString *)convertMark:(NSString *)str
{
    
    switch (str.intValue) {
        case 0:
        {
            return @"2";
        }
            break;
        case 1:
        {
            return @"1";
        }
            break;
        case 2:
        {
            return @"4";
        }
            break;
        case 3:
        {
            return @"4";
        }
            break;
        default:
        {
            return @"4";
        }
            break;
    }
    return @"4";
}


-(void)startTime
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(_timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{//设置界面的按钮显示 根据自己需求设置
                if ([AppHelper shareInstance].hud.superview) {
                    [[AppHelper shareInstance]removeHUD_H];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"操作超时！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    
                }
                
            });
        }else{
            int seconds = _timeout;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置

            });
            _timeout--;
        }
    });
    dispatch_resume(_timer);
}


unsigned int CRC16_Modbus (const char *arr_buff, int len)
{
    
    uint crc=0xFFFF;
    int i, j;
    for ( j=0; j< len;j++)
    {
        crc=crc ^*arr_buff++;
        for ( i=0; i<8; i++)
        {
            if( ( crc&0x0001) >0)
            {
                crc=crc>>1;
                crc=crc^ 0xa001;
            }
            else
                crc=crc>>1;
        }
    }
    return ( crc);
}

//函 数 名：HexToAsc()
//功能描述：把16进制转换为ASCII
unsigned char HexToAsc(unsigned char aChar){
    if((aChar>=0x30)&&(aChar<=0x39))
        aChar -= 0x30;
    else if((aChar>=0x41)&&(aChar<=0x46))//大写字母
        aChar -= 0x37;
    else if((aChar>=0x61)&&(aChar<=0x66))//小写字母
        aChar -= 0x57;
    else aChar = 0xff;
    return aChar;
}
@end
