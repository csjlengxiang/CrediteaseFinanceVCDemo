//
//  PresentTransitioningDelegate.m
//  SavingPlus
//
//  Created by sijiechen3 on 16/7/22.
//  Copyright © 2016年 CreditEase. All rights reserved.
//

#import "PresentTransitioningDelegate.h"
#import "DefaultPresentAnimation.h"
#import "DefaultDismissAnimation.h"
#import "SwipeUpInteractiveTransition.h"
//#import "babysleep-Swift.h"

@implementation PresentTransitioningDelegate

- (instancetype)init {
    if (self = [super init]) {
        self.interactiveTransiton = [SwipeUpInteractiveTransition new];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [DefaultPresentAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {;
    return [DefaultDismissAnimation new];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return self.interactiveTransiton.interacting ? self.interactiveTransiton : nil;
//}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransiton.interacting ? self.interactiveTransiton : nil;
}

//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0);

@end

@implementation PresentTransitioningDelegate2

- (instancetype)init {
    if (self = [super init]) {
//        self.interactiveTransiton = [SwipeUpInteractiveTransition new];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [AlertPresentAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {;
    return [AlertDismissAnimation new];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return self.interactiveTransiton.interacting ? self.interactiveTransiton : nil;
//}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return nil;
//}

//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0);

@end
