//
//  PlayViewController.h
//  GoPlay
//
//  Created by dKingbin on 2018/11/20.
//  Copyright © 2018年 dKingbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PlayInfo : NSObject
@property(nonatomic,strong) NSString* url;
@property(nonatomic,strong) NSString* fileName;
@end

@interface PlayViewController : BaseViewController
@property(nonatomic,strong) NSString* url;
@property(nonatomic,strong) NSString* fileName;
-(void)setPlayList:(NSArray<PlayInfo *> *)playList playIndex:(NSInteger)index;
@end
