//
//  AppDelegate.m
//  LocalNotificationDemo
//
//  Created by Mac on 16/6/23.
//  Copyright © 2016年 csx. All rights reserved.
//

#import "AppDelegate.h"

#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    application.applicationIconBadgeNumber = 0;
    
    //建立代理关系，在使用app进入前台的时候仍然可以使用通知的消息提示
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    
    return YES;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"%@",notification.userInfo);
    
    //显示通知后，点击通知会取消掉小红点（有几条消息的提示）
    application.applicationIconBadgeNumber = 0;
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
    NSLog(@"%s",__FUNCTION__);
    
    //注册通知 的时候就调用
    //[application registerForRemoteNotifications];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s",__FUNCTION__);
    application.applicationIconBadgeNumber = 0;
    
}


// App 在前台弹通知需要调用这个接口
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    
}


- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler {
    
    NSLog(@"%s---%@",__FUNCTION__,responseInfo);
    
    //在返回的事件中，对于点击“起来嗨”按钮触发的文本框输入的东西会在send之后在responseInfo的字典中的键值UIUserNotificationActionResponseTypedTextKey中带出来。（也就是这个属性代理方法要和action的behavior = UIUserNotificationActionBehaviorTextInput连用才有效);
    //{我的小思路：可以把setting设置写到APPDelegate里面，设置在点击继续睡的时候重新选择继续多长时间后再次通知}，
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}





- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    application.applicationIconBadgeNumber = 0;
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
