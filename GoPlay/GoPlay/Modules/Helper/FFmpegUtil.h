//
//  FFmpegUtil.h
//  GoPlay
//
//  Created by 肖湘 on 2023/8/15.
//  Copyright © 2023 dKingbin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFmpegUtil : NSObject
+ (instancetype)sharedInstance;
+(NSString *)captureFrame:(NSString *)videoPath;
@end

NS_ASSUME_NONNULL_END
