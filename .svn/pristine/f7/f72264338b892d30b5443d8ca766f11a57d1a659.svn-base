#import <UIKit/UIKit.h>
#import "iGate.h"

@interface ConnectDeviceViewController : UIViewController<CiGateDelegate,WebServiceDelegate>{
    
    CiGate *iGate;
    CiGateState _state;
    UIActivityIndicatorView *proInd;
    WebServices *helper;
    

}

@property CiGateState state;


- (void)iGateDidReceivedData:(NSData *)data;


@end
