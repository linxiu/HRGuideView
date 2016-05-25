//
//  AppDelegate.m
//  HRGuideView
//
//  Created by linxiu on 16/5/24.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabViewController.h"
#import "DMIntroductionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    NSString *isGuidancd = [[NSUserDefaults standardUserDefaults]objectForKey:@"is_first"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
  
    if ([isGuidancd isEqualToString:@"is_first"]) {
        
        [self setupTabViewController]; //主页
    }else{
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [self setIntroductionViewController]; //引导页
    }
   
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)setIntroductionViewController{
    //读取沙盒数据
    NSUserDefaults * settings1 = [NSUserDefaults standardUserDefaults];
    NSString *key1 = [NSString stringWithFormat:@"is_first"];
    NSString *value = [settings1 objectForKey:key1];
    if (!value) {//如果没有数据
        //***
        //引导页
     DMIntroductionViewController *introductionVC = [[DMIntroductionViewController alloc]init];
//        [UIApplication sharedApplication].delegate.window.rootViewController = introductionVC;
        self.window.rootViewController = introductionVC;
    }else{
        RootTabViewController *rootVC = [[RootTabViewController alloc] init];
        rootVC.tabBar.translucent = YES;
        self.window.rootViewController = rootVC;
      
    }
}
-(void)setupTabViewController{

    RootTabViewController *rootVC = [[RootTabViewController alloc] init];
    rootVC.tabBar.translucent = YES;
    self.window.rootViewController = rootVC;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

@end
