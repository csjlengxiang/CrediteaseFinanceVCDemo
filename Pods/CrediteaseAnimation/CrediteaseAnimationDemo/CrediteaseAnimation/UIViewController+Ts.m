//
//  UIViewController+Ts.m
//  testAnimation
//
//  Created by csj on 2016/11/27.
//  Copyright © 2016年 csj. All rights reserved.
//

#import "UIViewController+Ts.h"
#import <objc/runtime.h>

@implementation UIViewController (Ts)

- (void)setTs_delegate:(PresentTransitioningDelegate *)ts_delegate {
    objc_setAssociatedObject(self, @selector(ts_delegate), ts_delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PresentTransitioningDelegate *)ts_delegate {
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(presentViewController:animated:completion:);
        SEL swizzledSelector = @selector(Ts_presentViewController:animated:completion:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)Ts_presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)())completion {
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = (UINavigationController *)vc;
        UIViewController * son = [nav topViewController];
        if ([son conformsToProtocol:@protocol(DefaultAnimationProtocol)]) {
            PresentTransitioningDelegate * delegate = [[PresentTransitioningDelegate alloc] init];
            son.ts_delegate = delegate;
            nav.transitioningDelegate = son.ts_delegate;
            [delegate.interactiveTransiton wireToViewController:son];
        }
        if ([son conformsToProtocol:@protocol(AlertAnimationProtocol)]) {
            PresentTransitioningDelegate2 * delegate = [[PresentTransitioningDelegate2 alloc] init];
            son.ts_delegate = delegate;
            nav.transitioningDelegate = son.ts_delegate;
        }

    } else if ([vc isKindOfClass:[UIViewController class]]) {
        UIViewController * son = vc;
        if ([son conformsToProtocol:@protocol(DefaultAnimationProtocol)]) {
            PresentTransitioningDelegate * delegate = [[PresentTransitioningDelegate alloc] init];
            son.ts_delegate = delegate;
            son.transitioningDelegate = son.ts_delegate;
            [delegate.interactiveTransiton wireToViewController:son];
        }
        if ([son conformsToProtocol:@protocol(AlertAnimationProtocol)]) {
            PresentTransitioningDelegate2 * delegate = [[PresentTransitioningDelegate2 alloc] init];
            son.ts_delegate = delegate;
            son.transitioningDelegate = son.ts_delegate;
        }
    }
    
    [self Ts_presentViewController:vc animated:animated completion:completion];
}

@end
