//
//  SPWishFinancePresentViewController.m
//  SavingPlus
//
//  Created by sijiechen3 on 16/8/30.
//  Copyright © 2016年 CreditEase. All rights reserved.
//

#import "FinancePresentViewController.h"
#import "DefaultAnimationProtocol.h"

extern NSString * FinanceRootURL;

@interface FinancePresentViewController () <TSWebViewDelegate, DefaultAnimationProtocol>

@property (strong, nonatomic) UIColor * originColor;

@end

@implementation FinancePresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleDefault;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.description isEqualToString:FinanceRootURL]){
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    return YES;
}

@end
