//
//  WebServices.h
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

//异步调用完成的协议
@protocol WebServiceDelegate <NSObject>
@optional
-(void)requestFinishedMessage:(NSString*)xml;
-(void)requestFailedMessage:(NSError*)error;
@end

/// HYM
typedef void (^WithResultObjectBlock)(NSString*json,NSError *error);

@interface WebServices : NSObject

// HYM
@property (nonatomic,copy) WithResultObjectBlock resultBlock;
@property(nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,assign) id<WebServiceDelegate> delegate;
-(id)initWithDelegate:(id<WebServiceDelegate>)thedelegate;

/**
 *  @author HYM, 15-01-14 13:01:38
 *
 *  增加block方法回调请求
 *
 *  @param resultBlock
 *
 *  @return
 */
-(id)initWithBlock:(WithResultObjectBlock)resultBlock;


//公有方法
-(NSMutableURLRequest*)commonRequestUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg;
+(NSMutableURLRequest*)commonSharedRequestUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg;
//同步调用
-(NSString*)syncServiceUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg;
-(NSString*)syncServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg;
//异步调用
-(void)asyncServiceUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg;
-(void)asyncServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg;

/**
 *  @author HYM, 15-01-14 13:01:36
 *
 *  异步调用
 *
 *  @param wsUrl      <#wsUrl description#>
 *  @param space      <#space description#>
 *  @param methodname <#methodname description#>
 *  @param soapMsg    <#soapMsg description#>
 */
-(void)asyncServiceUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg withBlock:(WithResultObjectBlock)block;

-(void)asyncServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg withBlock:(WithResultObjectBlock)block;
@end
