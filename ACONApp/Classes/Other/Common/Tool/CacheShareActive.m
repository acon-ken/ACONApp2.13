//
//  CacheShareActive.m
//  ChinaCache
//
//  Created by bluemobi-wh02 on 14-10-15.
//  Copyright (c) 2014年 bluemobi-wh02. All rights reserved.
//

#import "CacheShareActive.h"

@implementation CacheShareActive
//分享
+(void)shareAction:(UIButton*)sender parma:(NSMutableArray*)arr
{
    AppDelegate *_appDelegate = [AppDelegate shareAppDelegate];
    
    NSString * imagePath = arr[0];//图片地址
    NSString * strMsg =arr[1];//内容
    NSString * strTitle=arr[2];//标题
    NSString * url=arr[3];//url
    
    if(strMsg ==nil || strMsg.length<=0)
    {
        strMsg = strTitle;
    }
    //内容过长截取80个字
    if(strMsg.length>80)
    {
        strMsg = [strMsg substringToIndex:80];
    }
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:strMsg
                                       defaultContent:@""
                                                image:[ShareSDK imageWithUrl:imagePath]
                                                title:strTitle
                                                  url:url
                                          description:strMsg
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    //定制微信好友信息
    [publishContent addWeixinSessionUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                         content:strMsg
                                           title:strTitle
                                             url:url
                                      thumbImage:[ShareSDK imageWithUrl:imagePath]
                                           image:[ShareSDK imageWithUrl:imagePath]
                                    musicFileUrl:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil];
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                          content:strMsg
                                            title:strTitle
                                              url:url
                                       thumbImage:[ShareSDK imageWithUrl:imagePath]
                                            image:[ShareSDK imageWithUrl:imagePath]
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    
    //结束定制信息
    ////////////////////////
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:_appDelegate.viewDelegate];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    //自定义新浪微博分享菜单项
    id<ISSShareActionSheetItem> sinaItem =
    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSinaWeibo]
     
                                       icon:[ShareSDK getClientIconWithType:ShareTypeSinaWeibo]
     
                               clickHandler:^{
                                   
                                   //弹出分享菜单
                                   
                                   [ShareSDK shareContent:publishContent
                                    
                                                     type:ShareTypeSinaWeibo
                                    
                                              authOptions:authOptions
                                    
                                            statusBarTips:NO
                                    
                                                   result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                              
                                               http://demo.mob.com/wiki/wp-content/themes/twentyfourteen/images/u139_normal.jpg
                                                       if (state == SSPublishContentStateSuccess)
                                                           
                                                       {
                                                           
                                                           NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                                  
                                                                                                  
                                                           
                                                           UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"分享成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                                                                                  [alertView show];
                                                                                                  
                                                           
                                                       }
                                                                                              
                                                                                              
                                                       
                                                       else if (state == SSPublishContentStateFail)
                                                           
                                                       {
                                                           
                                                           NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                                                                  
                                                                                                  
                                                           
                                                           UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:[error errorDescription] delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                                           
                                                           [alertView show];
                                                                                                  
                                                           
                                                       }
                                   
                                                   }];
                                   
                               }];
    
    //自定义腾讯QQ分享菜单项
    id<ISSShareActionSheetItem> tencentQQItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeQQ]
                                                                                   icon:[ShareSDK getClientIconWithType:ShareTypeQQ]
                                                                           clickHandler:^{
                                                                               [ShareSDK shareContent:publishContent
                                                                                                 type:ShareTypeQQ
                                                                                          authOptions:authOptions
                                                                                        statusBarTips:NO
                                                                                               result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                                   
                                                                                                   if (state == SSPublishContentStateSuccess)
                                                                                                   {
                                                                                                       NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                                       
                                                                                                       
                                                                                                       
                                                                                                       UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"分享成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                                                                                       [alertView show];
                                                                                                       
                                                                                                   }
                                                                                                   else if (state == SSPublishContentStateFail)
                                                                                                   {
                                                                                                       NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                                                                       
//                                                                                                       UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:[error errorDescription] delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
//                                                                                                       [alertView show];
                                                                                                       if([[error errorDescription] isEqualToString:@"QQ is not installed"])
                                                                                                       {
                                                                                                           UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您尚未安装QQ" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                                                                                           [alertView show];
                                                                                                       }
                                                                                                   }
                                                                                               }];
                                                                           }];
    
    //自定义QQ空间分享菜单项
    id<ISSShareActionSheetItem> qzoneItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeQQSpace]
                                                                               icon:[ShareSDK getClientIconWithType:ShareTypeQQSpace]
                                                                       clickHandler:^{
                                                                           [ShareSDK shareContent:publishContent
                                                                                             type:ShareTypeQQSpace
                                                                                      authOptions:authOptions
                                                                                    statusBarTips:NO
                                                                                           result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                               
                                                                                               
                                                                                               if (state == SSPublishContentStateSuccess)
                                                                                               {
                                                                                                   NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                                   UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"分享成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                                                                                   [alertView show];
                                                                                               }
                                                                                               else if (state == SSPublishContentStateFail)
                                                                                               {
                                                                                                   NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                                                                   UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"分享失败" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                                                                                   [alertView show];
                                                                                               }
                                                                                           }];
                                                                       }];
    
    //自定义腾讯微博分享菜单项
    id<ISSShareActionSheetItem> tencentItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeTencentWeibo]
                                                                                 icon:[ShareSDK getClientIconWithType:ShareTypeTencentWeibo]
                                                                         clickHandler:^{
                                                                             [ShareSDK shareContent:publishContent
                                                                                               type:ShareTypeTencentWeibo
                                                                                        authOptions:authOptions
                                                                                      statusBarTips:NO
                                                                                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                                 
                                                                                                 if (state == SSPublishContentStateSuccess)
                                                                                                 {
                                                                                                     NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                                     
                                                                                                     
                                                                                                     
                                                                                                     UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"分享成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                                                                                     [alertView show];
                                                                                                     
                                                                                                 }
                                                                                                 else if (state == SSPublishContentStateFail)
                                                                                                 {
                                                                                                     NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                                                                     
                                                                                                     UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"分享失败" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                                                                                     [alertView show];
                                                                                                 }
                                                                                             }];
                                                                         }];
    
    //创建自定义分享列表
    //      SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline), qzoneItem,
//    tencentItem,
//    tencentQQItem,
    NSArray *shareList = [ShareSDK customShareListWithType:
                          sinaItem,
                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),     nil];
    
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:authOptions
                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                          oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                           qqButtonHidden:NO
                                                    wxSessionButtonHidden:NO
                                                   wxTimelineButtonHidden:NO
                                                     showKeyboardOnAppear:NO
                                                        shareViewDelegate:_appDelegate.viewDelegate
                                                      friendsViewDelegate:_appDelegate.viewDelegate
                                                    picViewerViewDelegate:nil]
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                    if([[error errorDescription] isEqualToString:@"WeChat is not installed"])
                                    {
                                        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您尚未安装微信" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                                        [alertView show];
                                    }
                                }
                            }];
}

@end
