//
//  UIViewController+Ts.h
//  testAnimation
//
//  Created by csj on 2016/11/27.
//  Copyright © 2016年 csj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultAnimationProtocol.h"
#import "PresentTransitioningDelegate.h"

@interface UIViewController (Ts)

@property (strong, nonatomic) NSObject <UIViewControllerTransitioningDelegate> * ts_delegate;

@end
