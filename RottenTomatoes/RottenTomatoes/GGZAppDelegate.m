//
//  GGZAppDelegate.m
//  RottenTomatoes
//
//  Created by Guozheng Ge on 6/6/14.
//  Copyright (c) 2014 gzge. All rights reserved.
//

#import "GGZAppDelegate.h"
#import "GGZMoviesViewController.h"
#import "GGZDvdsViewController.h"

@implementation GGZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // tab bar controller
    UITabBarController *tbc = [[UITabBarController alloc] init];
    
    // top box office movies view controller
    GGZMoviesViewController *topBoxOfficeVc = [[GGZMoviesViewController alloc] init];
    UINavigationController *topBoxOfficeNvc = [[UINavigationController alloc] initWithRootViewController:topBoxOfficeVc];
    topBoxOfficeNvc.tabBarItem.title = @"Movies";
    topBoxOfficeNvc.tabBarItem.image = [UIImage imageNamed:@"movie"];
    
    // top dvd rental view controller
    GGZDvdsViewController *topDvdRentalsVc = [[GGZDvdsViewController alloc] init];
    UINavigationController *topDvdRentalsNvc = [[UINavigationController alloc] initWithRootViewController:topDvdRentalsVc];
    topDvdRentalsNvc.tabBarItem.title = @"DVDs";
    topDvdRentalsNvc.tabBarItem.image = [UIImage imageNamed:@"dvd"];
    
    tbc.viewControllers = @[topBoxOfficeNvc, topDvdRentalsNvc];
    
    
    self.window.rootViewController = tbc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
