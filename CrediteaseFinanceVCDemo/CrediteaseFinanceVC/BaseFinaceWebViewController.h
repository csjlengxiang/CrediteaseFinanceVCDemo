//
//  SPBaseWebViewController.h
//  JS_OC
//
//  Created by sijiechen3 on 16/8/24.
//  Copyright © 2016年 Halley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWebView+TS_JavaScriptContext.h"

extern NSString *  CookieChannel;
extern NSString *  FinanceDomain;
extern NSString *  FinanceRootURL;

@interface FinanceVCManager : NSObject

+ (void)setRootURL:(NSString *)rootURL domain:(NSString *)domain cookieChannel:(NSString *)channel;

+ (void)setCookieChannel:(NSString *)channel;

@end

@interface BaseFinaceWebViewController : UIViewController

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSURLRequest * request;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicatorView;

- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx;

- (BOOL)loadWebPageWithUrl:(NSString *)url;
- (BOOL)loadWebPageWithRequest:(NSMutableURLRequest *)urlRequest;

@end
