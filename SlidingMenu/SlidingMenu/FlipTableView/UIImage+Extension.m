//
//  UIImage+Extension.m
//  ManyMouseMall
//
//  Created by 韩珍珍 on 15/10/19.
//  Copyright © 2015年 DS. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


@end
