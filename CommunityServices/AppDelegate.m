//
//  ViewController.m
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import "AppDelegate.h"
#import "CSNavigationController.h"
#import "TabbarViewController.h"
#import "LogOnViewController.h"
#import "APIKey.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
    [AMapLocationServices sharedServices].apiKey = (NSString *)APIKey;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    sleep(1);
    [self configureAPIKey];

//    [self launchApp];
//    UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:[[TabbarViewController alloc] init]];
    NSString *token=[UserDefaultsUtils getStringValueWithKey:kId];
    if(![token length]==0)
    {
        self.window.rootViewController = [TabbarViewController sharedInstance];
    }
    else
    {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LogOnViewController alloc] init]];
    }
//[[UINavigationController alloc] initWithRootViewController:[[TabbarViewController alloc] init]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    self.window.rootViewController = [[TabbarViewController alloc] init];
    return YES;
}

- (void)launchApp{
//    //判断是不是第一次启动应用
//    if([UserDefaultsUtils getIntegerValueWithKey:kGuideVersion] < GuideVersion){
//        [UserDefaultsUtils saveIntegerValue:GuideVersion forKey:kGuideVersion];
//        NSLog(@"第一次启动");
//        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
//        UserGuideViewController *userGuideViewController = [[UserGuideViewController alloc] init];
//        self.window.rootViewController = userGuideViewController;
//    }else{
//        NSLog(@"不是第一次启动");
//        //如果不是第一次启动的话,使用RESideMenu作为根视图
//        
//        NSString *token=[UserDefaultsUtils getStringValueWithKey:kToken];
//        if([token length]!=0)
//        {
//            self.window.rootViewController = [RESideMenu sharedInstance];
//        }
//        else
//        {
//            self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LogOnViewController alloc] init]];
//        }
//    }
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
}

-(UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
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
