//
//  PresentTransitioningDelegate.h
//  SavingPlus
//
//  Created by sijiechen3 on 16/7/22.
//  Copyright © 2016年 CreditEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeUpInteractiveTransition.h"

@interface PresentTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) SwipeUpInteractiveTransition * interactiveTransiton;

@end

@interface PresentTransitioningDelegate2 : NSObject <UIViewControllerTransitioningDelegate>

//@property (strong, nonatomic) SwipeUpInteractiveTransition * interactiveTransiton;

@end

