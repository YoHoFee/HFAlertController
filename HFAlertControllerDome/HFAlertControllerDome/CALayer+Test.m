//
//  CALayer+Test.m
//  HFAlertControllerDome
//
//  Created by 姚鸿飞 on 2017/10/16.
//  Copyright © 2017年 姚鸿飞. All rights reserved.
//

#import "CALayer+Test.h"

@implementation CALayer (Test)

+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod([CALayer class], @selector(addAnimation:forKey:)), class_getInstanceMethod([CALayer class], @selector(hackedAddAnimation:forKey:)));
}

- (void)hackedAddAnimation:(CABasicAnimation *)anim forKey:(NSString *)key{
    [self hackedAddAnimation:anim forKey:key];
    if ([anim isKindOfClass:[CABasicAnimation class]]) {
        if ([anim.keyPath isEqualToString:@"transform"]) {
            if (anim.fromValue) {
                CATransform3D fromValue = [anim.fromValue CATransform3DValue];
                NSLog(@"From:%@",NSStringFromCGAffineTransform(CATransform3DGetAffineTransform(fromValue)));
            }
            if (anim.toValue) {
                CATransform3D toValue = [anim.toValue CATransform3DValue];
                NSLog(@"To:%@",NSStringFromCGAffineTransform(CATransform3DGetAffineTransform(toValue)));
            }
            if (anim.byValue) {
                CATransform3D byValue = [anim.byValue CATransform3DValue];
                NSLog(@"By:%@",NSStringFromCGAffineTransform(CATransform3DGetAffineTransform(byValue)));
            }
            NSLog(@"Duration:%.2f",anim.duration);
            NSLog(@"TimingFunction:%@",anim.timingFunction);
        }
    }
}


@end
