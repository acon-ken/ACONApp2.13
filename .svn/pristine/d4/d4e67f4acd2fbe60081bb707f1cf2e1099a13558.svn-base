//
//  AppDelegate.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingViewController.h"
#import "LoginViewController.h"
#import "AKNavigationController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>

//分享
#import "WXApi.h"

#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import <WeChatConnection/WeChatConnection.h>

//#import "WeiboSDK.h"
//#import "WeiboApi.h"
#import "WeiboApiObject.h"
#import "WeiboApi.h"
#import "WeiboApiObject.h"


#import "APService.h"//极光推送


#import<AVFoundation/AVFoundation.h>
/**
 *  iphone
 */

@interface AppDelegate ()<AVAudioPlayerDelegate>
{
    AVAudioPlayer *_play;//本地通知播放铃声
}
    

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 2.设置根控制器
    LoadingViewController *root = [[LoadingViewController alloc] init];
    
    AKNavigationController *nav = [[AKNavigationController alloc]initWithRootViewController:root];
    
    self.window.rootViewController = nav;
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    //注册到ShareSDK
    [ShareSDK registerApp:@"8f70df133582"];//463a1176c0e0->客户的账户
    
//    //添加新浪微博应用 注册网址 http://open.weibo.com
//    [ShareSDK connectSinaWeiboWithAppKey:@"596388287"
//                               appSecret:@"4c4813bae5703fd8662f9e404e20664f"
//                             redirectUri:@"http://www.sharesdk.cn"];

    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];

    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wxbfb2d0bdf7f29c35"   //微信APPID
                           appSecret:@"cebc1b8feab31a3ac1681f912b8e7709"  //微信APPSecret
                           wechatCls:[WXApi class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"//1103838864//wVTrT8i0j2BRQ7dD
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    

    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1103838864"   //该参数填入申请的QQ AppId
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
   
    

    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
 
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    
//    /****注册到Sina*****/
//    //新浪微博登录
//    [ShareSDK connectSinaWeiboWithAppKey:@"596388287"
//                               appSecret:@"4c4813bae5703fd8662f9e404e20664f"
//                             redirectUri:@"http://www.baidu.com"];
////
//    //新浪微博分享
//    [ShareSDK  connectSinaWeiboWithAppKey:@"596388287"
//                                appSecret:@"4c4813bae5703fd8662f9e404e20664f"
//                              redirectUri:@"http://www.baidu.com"
//                              weiboSDKCls:[WeiboSDK class]];
//
//    /****注册到Sina*****/
//    
//
//   //LY++++++++++++++++++++++++++12月5号++++++++++++++
//     [ShareSDK connectWeChatWithAppId:@"wxb3093aaf333b9977" wechatCls:[WXApi class]];
//    
//    
//   //LY++++++++++++++++++++++++++++12月5号+++++++++++++
    
    //[ShareSDK connectQQWithAppId:<#(NSString *)#> qqApiCls:<#(__unsafe_unretained Class)#>]
    [Parse setApplicationId:@"5io79DVZo0dhNYUxMHtaNRFWmD64V7vHcgy5XPze"  clientKey:@"n80E5A7AQQMCAIfvkaHOQZfWLof4Y6Dx5u73h1cH"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    NSDictionary *dimensions = @{
                                 @"category": @"politics",
                                 @"dayType": @"weekday",
                                 };
    [PFAnalytics trackEvent:@"read" dimensions:dimensions];
    
    
    /********************************极光推送****************************************/
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    [APService setupWithOption:launchOptions];
    /********************************极光推送****************************************/
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    
    //删除数据列表页面本地的currenttimerstr、secondSwitchStatusstr、timerString数据
    NSString *bloodData1 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"currenttimerstr"];
    bloodData1 = nil;
    NSUserDefaults *bloodDatadefaults1 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults1 setObject:bloodData1 forKey:@"currenttimerstr"];
    [bloodDatadefaults1 synchronize];
    
    NSString *bloodData2 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"secondSwitchStatusstr"];
    bloodData2 = nil;
    NSUserDefaults *bloodDatadefaults2 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults2 setObject:bloodData2 forKey:@"secondSwitchStatusstr"];
    [bloodDatadefaults2 synchronize];
    
    
    NSString *bloodData3 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"timerString"];
    bloodData3 = nil;
    NSUserDefaults *bloodDatadefaults3 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults3 setObject:bloodData3 forKey:@"timerString"];
    [bloodDatadefaults3 synchronize];
    
    //删除饼状图页面本地的currenttimerstr、secondSwitchStatusstr、timerString数据
    NSString *bloodData4 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"Piecurrenttimerstr"];
    bloodData4 = nil;
    NSUserDefaults *bloodDatadefaults4 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults4 setObject:bloodData4 forKey:@"Piecurrenttimerstr"];
    [bloodDatadefaults4 synchronize];
    
    NSString *bloodData5 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"PiesecondSwitchStatusstr"];
    bloodData5 = nil;
    NSUserDefaults *bloodDatadefaults5 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults5 setObject:bloodData5 forKey:@"PiesecondSwitchStatusstr"];
    [bloodDatadefaults5 synchronize];
    
    
    NSString *bloodData6 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"PietimerString"];
    bloodData6 = nil;
    NSUserDefaults *bloodDatadefaults6 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults6 setObject:bloodData6 forKey:@"PietimerString"];
    [bloodDatadefaults6 synchronize];

    
    
    [ArchiveAccessFile DeleteArchiveFileName:Klog];
    
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    [ShareSDK cancelAuthWithType:ShareTypeTencentWeibo];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
+ (AppDelegate *)shareAppDelegate
{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
//    [ArchiveAccessFile DeleteArchiveFileName:Klog];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //    rootViewController.deviceTokenValueLabel.text =
    //    [NSString stringWithFormat:@"%@", deviceToken];
    //    rootViewController.deviceTokenValueLabel.textColor =
    //    [UIColor colorWithRed:0.0 / 255
    //                    green:122.0 / 255
    //                     blue:255.0 / 255
    //                    alpha:1];
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [APService registerDeviceToken:deviceToken];
    
    
    NSLog(@"get RegistrationID   %@",[APService registrationID]);
    
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.

//////////////////////////
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    
//    _viewvc = [[ViewController alloc] init];
//    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_viewvc];
//    self.window.rootViewController = nav;
//    
//    _newVc = [[NewMessageVC alloc] init];
//    [_viewvc.navigationController pushViewController:_newVc animated:YES];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    //    [_newVc addNotificationCount];
    completionHandler(UIBackgroundFetchResultNewData);
    
    
    
//    _viewvc = [[ViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_viewvc];
//    self.window.rootViewController = nav;
//    
//    _newVc = [[NewMessageVC alloc] init];
//    [_viewvc.navigationController pushViewController:_newVc animated:YES];
    
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {

    NSString *str = [[notification userInfo]objectForKey:@"ACONUserID"];
    if (str) {
        if (![str isEqualToString:[[[SaveUserInfo loadCustomObjectWithKey]data]dataIdentifier]]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            return;
        }
        NSString* path= [[NSBundle mainBundle] pathForResource:@"clock" ofType:@"caf"];
        
        NSURL* url = [NSURL fileURLWithPath:path];
        _play = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        _play.delegate=self;
        _play.volume= 0.5;
        [_play prepareToPlay];
        [_play play];

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:notification.alertBody message:notification.alertAction delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = 10000;
        [alertView show];

        return;
    }
    
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
    
}
//
// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

#pragma mark - 收到通知后提示
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (10000 == alertView.tag) {
        [_play stop];
    }
}
@end
