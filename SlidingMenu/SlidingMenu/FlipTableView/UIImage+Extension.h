//
//  UIImage+Extension.h
//  ManyMouseMall
//
//  Created by 韩珍珍 on 15/10/19.
//  Copyright © 2015年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

@end
