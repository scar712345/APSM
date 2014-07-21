//
//  AppDelegate.m
//  APSM
//
//  Created by APP559 on 2014/7/15.
//  Copyright (c) 2014年 yume. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

//#import <Harpy.h>
//#import <Reachability.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

NSComparator sortingBlock = ^(id call1, id call2) {
    NSString *callIdentifier = [call1 callID];
    NSString *call2Identifier = [call2 callID];
    NSComparisonResult result = [callIdentifier compare:call2Identifier
                                                options:NSNumericSearch | NSForcedOrderingSearch
                                                  range:NSMakeRange(0, [callIdentifier length])
                                                 locale:[NSLocale currentLocale]];
    return result;
};

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIImage *navbar = [UIImage imageNamed:@"phone_h_001(320x64).png"];
    [[UINavigationBar appearance] setBackgroundImage:navbar forBarMetrics:UIBarMetricsDefault];
    
    [self phoneCalled];
//    [self setupLocalNotifications];
//    [self checkAPPVersion];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [[yumeBTLERemoteController sharedInstance]disconnet];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Process Phone call

-(void) phoneCalled{
    CTTelephonyNetworkInfo *tni;
    CTCallCenter *callCenter;
    NSString *crtCarrierName;
    NSArray *crtCalls;
    
    tni = [CTTelephonyNetworkInfo new];
    callCenter = [CTCallCenter new];
    crtCarrierName = tni.subscriberCellularProvider.carrierName;
    crtCalls = [callCenter.currentCalls allObjects];
    crtCalls = [crtCalls sortedArrayUsingComparator:sortingBlock];
    
    callCenter.callEventHandler=^(CTCall* call){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (call.callState == CTCallStateIncoming) {
//                [[yumeBTLERemoteController sharedInstance] pause];
                DLog(@"CTCallStateIncoming");
            }else if(call.callState == CTCallStateDialing){
                DLog(@"CTCallStateDialing");
            }else if(call.callState == CTCallStateConnected){
                DLog(@"CTCallStateConnected");
            }else if(call.callState == CTCallStateDisconnected){
//                [[yumeBTLERemoteController sharedInstance] play];
                DLog(@"CTCallStateDisconnected");
            }
            //            DLog(@"%s, self: <%@>, \ncallCenter: <%@>", __PRETTY_FUNCTION__, self, callCenter);
        });
    };
}

#pragma mark - APP Version Check (Using Reachability)

// Harpy check App version from app store
-(void) checkAPPVersion{
//    DLog(@"开启 www.apple.com 的网络检测");
//    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
//    DLog(@"-- current status: %@", reach.currentReachabilityString);
//    
//    reach.reachableBlock = ^(Reachability * reachability)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            DLog(@"网络可用");
//            
//            static dispatch_once_t onceTokenVersionCheck;
//            dispatch_once(&onceTokenVersionCheck, ^{
//                [[Harpy sharedInstance] setAppID:@"882486643"];
//                [[Harpy sharedInstance] setAlertType:HarpyAlertTypeOption];
//                [[Harpy sharedInstance] checkVersion];
//            });
//        });
//    };
//    
//    reach.unreachableBlock = ^(Reachability * reachability)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            DLog(@"网络不可用");
//            //            self.blockLabel.text = @"网络不可用";
//        });
//    };
//    
//    [reach startNotifier];
}


@end
