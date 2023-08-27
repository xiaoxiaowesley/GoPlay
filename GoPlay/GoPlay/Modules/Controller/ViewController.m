//
//  ViewController.m
//  GoPlay
//
//  Created by dKingbin on 2019/5/7.
//  Copyright © 2019 dKingbin. All rights reserved.
//

#import "ViewController.h"
#import "PlayViewController.h"

#import "ColorUtil.h"
#import "CommonUtil.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"

#import "GoPlay-Swift.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"GoPlay";

	UILabel* tipsLabel = [CommonUtil LabelWithTitle:@"Click Me!"
										  textColor:[UIColor blackColor]
											bgColor:[UIColor clearColor]
											   font:16
									  textAlignment:NSTextAlignmentCenter
											   Bold:NO];
	[self.view addSubview:tipsLabel];
	[tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.view);
	}];

	// add navigation bar background color to yellow
	self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
	// 
    // Set status bar's background color to red
    if (@available(iOS 13.0, *)) {
        UIView *statusBar = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [UIColor redColor];
        [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
    } else {
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        statusBar.backgroundColor = [UIColor redColor];
    }
	

	
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//	PlayViewController* vc = [[PlayViewController alloc]init];
//	vc.url = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";	//input media url
//	[self.navigationController pushViewController:vc animated:YES];

//    UIViewController *detailsViewController = [[ListViewInterface new] makeShipDetailsUI:@"Sarita"];
//    [self presentModalViewController:detailsViewController animated:YES];
}

@end
