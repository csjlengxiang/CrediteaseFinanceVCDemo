//
//  DefaultPresentAnimation.m
//  SavingPlus
//
//  Created by sijiechen3 on 16/7/22.
//  Copyright © 2016年 CreditEase. All rights reserved.
//

#import "DefaultPresentAnimation.h"

@implementation DefaultPresentAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *to   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * cv = [transitionContext containerView];
    [cv insertSubview:to.view aboveSubview:from.view];
    NSTimeInterval d = [self transitionDuration:transitionContext];
    CGRect bounds = to.view.bounds;
    
//    from.view.transform = CGAffineTransformTranslate(from.view.transform, -bounds.size.width / 4, 0);
    UIView * shadowView = [[UIView alloc] initWithFrame:from.view.bounds];
    shadowView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1];
    shadowView.alpha = 0;
    [from.view addSubview:shadowView];
    
    to.view.transform = CGAffineTransformTranslate(to.view.transform, bounds.size.width, 0);

    [UIView animateWithDuration:d animations:^{
        shadowView.alpha = 0.5;
        //from.view.transform = CGAffineTransformTranslate(from.view.transform, -bounds.size.width / 4, 0);
        from.view.transform = CGAffineTransformScale(from.view.transform, 0.95, 0.95);
        to.view.transform = CGAffineTransformTranslate(to.view.transform, -bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [shadowView removeFromSuperview];
        from.view.transform = CGAffineTransformIdentity;
        to.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@implementation AlertPresentAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * cv = [transitionContext containerView];
    NSTimeInterval dur = [self transitionDuration:transitionContext];

    [cv addSubview:toVC.view];
    toVC.view.alpha = 0;

    [UIView animateWithDuration:dur animations:^{
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        toVC.view.alpha = 1;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
