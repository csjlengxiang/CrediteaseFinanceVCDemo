//
//  DefaultDismissAnimation.m
//  SavingPlus
//
//  Created by sijiechen3 on 16/7/22.
//  Copyright © 2016年 CreditEase. All rights reserved.
//

#import "DefaultDismissAnimation.h"

@implementation DefaultDismissAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *to   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * cv = [transitionContext containerView];
    [cv insertSubview:to.view belowSubview:from.view];
    NSTimeInterval d = [self transitionDuration:transitionContext];
    CGRect bounds = to.view.bounds;
    
    //to.view.transform = CGAffineTransformTranslate(to.view.transform, - bounds.size.width / 4, 0);
    to.view.transform = CGAffineTransformScale(to.view.transform, 0.95, 0.95);
    
    UIView * shadowView = [[UIView alloc] initWithFrame:to.view.bounds];
    shadowView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1];
    shadowView.alpha = 0.5;
    [to.view addSubview:shadowView];
    
    [UIView animateWithDuration:d delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        shadowView.alpha = 0;
        from.view.transform = CGAffineTransformTranslate(from.view.transform, bounds.size.width, 0);
        to.view.transform = CGAffineTransformIdentity;
        //to.view.transform = CGAffineTransformTranslate(to.view.transform, bounds.size.width / 4, 0);
    } completion:^(BOOL finished) {
        [shadowView removeFromSuperview];
        to.view.transform = CGAffineTransformIdentity;
        from.view.transform = CGAffineTransformIdentity;
        [to.view removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@implementation AlertDismissAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NSTimeInterval dur = [self transitionDuration:transitionContext];
    
    fromVC.view.alpha = 1;
    [UIView animateWithDuration:dur animations:^{
        fromVC.view.alpha = 0;

    } completion:^(BOOL finished) {
        fromVC.view.alpha = 1;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

