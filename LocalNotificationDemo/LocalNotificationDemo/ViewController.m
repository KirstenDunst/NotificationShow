//
//  ViewController.m
//  LocalNotificationDemo
//
//  Created by Mac on 16/6/23.
//  Copyright © 2016年 csx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 200, 80);
    [button setTitle:@"点击提交" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
 //按钮的类
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc]init];
    //按钮的标识符，用来找到这个按钮
    action.identifier = @"起床";
    action.title = @"起来嗨";
    //点击之后出现文本框或者是默认
    action.behavior = UIUserNotificationActionBehaviorTextInput;
    action.parameters = @{@"a":@"1"};
    //点击按钮之后是进去还是挂在后台
    action.activationMode = UIUserNotificationActivationModeBackground;
    //按钮响应必须手机已经解锁
    action.authenticationRequired = YES;
    //设置按钮的颜色，yes是红色的，no是蓝色的
    action.destructive =YES;
   
    
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc]init];
    //按钮的标识符，用来找到这个按钮
    action1.identifier = @"继续";
    action1.title = @"继续睡";
    action1.behavior = UIUserNotificationActionBehaviorDefault;
    //action1.parameters = @{@"b":@"2"};
    //点击按钮之后是进去还是挂在后台
    action1.activationMode = UIUserNotificationActivationModeForeground;
    //按钮响应必须手机已经解锁
    action1.authenticationRequired = YES;
    //设置按钮的颜色，yes是红色的，no是蓝色的
    action1.destructive =NO;
    
    
    
    NSArray *arr = @[action,action1];
    
    
    //可以用来设置给通知栏的按钮对象
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
    //标识符，要与使用的时候一样
    category.identifier = @"clock";
    //设置按钮的方法
    [category setActions:arr forContext:UIUserNotificationActionContextDefault];
   //注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:[NSSet setWithObject:category]];
    
    [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
    
    
    
    
   
}
- (void)buttonClick:(UIButton *)sender {
    
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    //设置category类型，需要与创建的时候的一样。
    noti.category = @"clock";
    //通知时间；
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //时区
    noti.timeZone = [NSTimeZone defaultTimeZone];
    //timeZone是本地通知的激发时间是否根据时区改变而改变，如果设为nil，则通知会在一段时间之后激发，而不是某一个确切的时间。
    
    //通知的提示内容
    noti.alertBody = @"该吃饭了!!!!!";
    
    //滑动解锁的提示字符
    noti.alertAction = @"该下课了";
    
    noti.alertTitle = @"发的不回复";
    //声音文件
    noti.soundName = @"ping.caf";
    //小红点
    noti.applicationIconBadgeNumber = 10;
    //用户信息
    noti.userInfo = @{@"1":@"a",@"2":@"b"};
    //添加推送到UIApplication
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
