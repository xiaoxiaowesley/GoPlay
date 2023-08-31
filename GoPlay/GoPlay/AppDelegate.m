//
//  AppDelegate.m
//  GoPlay
//
//  Created by dKingbin on 2019/5/7.
//  Copyright © 2019 dKingbin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
//#import <SwiftUI/SwiftUI.h>
#import "GoPlay-Swift.h" // Replace with your actual project name

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.

//	if (@available(iOS 11.0, *))
//	{
//		[UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//		[UINavigationBar appearance].translucent = NO;
//	}
//
//    UINavigationBarAppearance *newNavBarAppearance = [self customNavBarAppearance];
//    UINavigationBar *appearance = [UINavigationBar appearance];
//    appearance.scrollEdgeAppearance = newNavBarAppearance;
//    appearance.compactAppearance = newNavBarAppearance;
//    appearance.standardAppearance = newNavBarAppearance;
//    if (@available(iOS 15.0, *)) {
//        appearance.compactScrollEdgeAppearance = newNavBarAppearance;
//    }
    
    UIViewController *vc = [[MainViewInterface new] makeShipDetailsUI:@"Sarita"];
    
	UINavigationController* navc = [[UINavigationController alloc]initWithRootViewController:vc];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = navc;
	[self.window makeKeyAndVisible];

	return YES;
}

-(UINavigationBarAppearance *)customNavBarAppearance {
    
    UIColor *turquoise = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1.0];

    
    UINavigationBarAppearance *customNavBarAppearance = [[UINavigationBarAppearance alloc] init];
    // Apply a red background.
    [customNavBarAppearance configureWithOpaqueBackground];
    customNavBarAppearance.backgroundColor = turquoise;

    // Apply white colored normal and large titles.
    customNavBarAppearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    customNavBarAppearance.largeTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    // Apply white color to all the nav bar buttons.
    UIBarButtonItemAppearance *barButtonItemAppearance = [[UIBarButtonItemAppearance alloc] initWithStyle:UIBarButtonItemStylePlain];
    [barButtonItemAppearance.normal setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [barButtonItemAppearance.disabled setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightTextColor]}];
    [barButtonItemAppearance.highlighted setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor labelColor]}];
    [barButtonItemAppearance.focused setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    customNavBarAppearance.buttonAppearance = barButtonItemAppearance;
    customNavBarAppearance.backButtonAppearance = barButtonItemAppearance;
    customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance;

    return customNavBarAppearance;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
