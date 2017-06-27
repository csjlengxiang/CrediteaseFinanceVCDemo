//
//  SPBaseWebViewController.m
//  JS_OC
//
//  Created by sijiechen3 on 16/8/24.
//  Copyright © 2016年 Halley. All rights reserved.
//

#import "BaseFinaceWebViewController.h"
#import "Masonry.h"

@implementation FinanceVCManager

- (void)setRootURL:(NSString *)rootURL domain:(NSString *)domain cookieChannel:(NSString *)channel {
    FinanceRootURL = rootURL;
    FinanceDomain = domain;
    CookieChannel = channel;
}

- (void)setCookieChannel:(NSString *)channel {
    CookieChannel = channel;
}

@end

@protocol BaseFinaceWebViewControllerDelegate <JSExport>
- (void)popBonus:(NSString *)imageUrl :(NSString *)callBack :(NSString *)trackingInfo;
- (void)toWeb:(NSString *)imageUrl :(NSString *)url :(NSString *)trackingInfo;
@end

@interface SPBao : NSObject <BaseFinaceWebViewControllerDelegate>
@property (weak, nonatomic) id<BaseFinaceWebViewControllerDelegate> delegate;
- (instancetype)initWithDelegate:(id<BaseFinaceWebViewControllerDelegate>)delegate;
@end

@implementation SPBao

- (instancetype)initWithDelegate:(id<BaseFinaceWebViewControllerDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}

- (void)popBonus:(NSString *)imageUrl :(NSString *)callBack :(NSString *)trackingInfo {
    [self.delegate popBonus:imageUrl :callBack :trackingInfo];
}

- (void)toWeb:(NSString *)imageUrl :(NSString *)url :(NSString *)trackingInfo {
    [self.delegate toWeb:imageUrl :url :trackingInfo];
}

@end

@interface BaseFinaceWebViewController () <UIWebViewDelegate, TSWebViewDelegate, BaseFinaceWebViewControllerDelegate>

@end

@implementation BaseFinaceWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // nav
    self.navigationItem.title = @"加载中...";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backPressed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closePressed:)];
    self.navigationItem.rightBarButtonItem.tintColor = self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    // web view
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.webView.clipsToBounds = YES;
    self.webView.scalesPageToFit = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.backgroundColor = [UIColor clearColor];
    self.webView.scrollView.clipsToBounds = YES;

    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
    // indicator
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.activityIndicatorView];
    [self.view bringSubviewToFront:self.activityIndicatorView];
    
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.webView);
    }];
    
    if (self.request) {
        [self loadWebPageWithRequest:[self.request mutableCopy]];
    }
}

#pragma mark - Nav Button Actions

- (void)backPressed:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self closePressed:nil];
    }
}

- (void)closePressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - load request or url

- (BOOL)loadWebPageWithRequest:(NSMutableURLRequest *)urlRequest {
    if (!urlRequest) NO;
    urlRequest.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [self.webView loadRequest:urlRequest];
    return YES;
}

- (BOOL)loadWebPageWithUrl:(NSString *)url {
    if (!url || [url isEqualToString:@""]) return NO;
    NSURL *cookieUrl = [NSURL URLWithString:url];
    if (!cookieUrl) return NO;
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    return [self loadWebPageWithRequest:urlRequest];
}

#pragma mark - WebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSAssert(false, @"this need replace");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.navigationItem.title = @"加载中...";
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    });
}

#pragma mark - TSWebViewDelegate

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) context {
    context[@"app"] = [[SPBao alloc] initWithDelegate:self];
//    NSAssert(false, @"this need replace");
}

#pragma mark - SPBaseWebViewControllerDelegate

- (void)popBonus:(NSString *)imageUrl :(NSString *)callBack :(NSString *)trackingInfo {
//- (void)popBonus:(NSString *)imageUrl :(NSString *)callBack :(NSDictionary *)trackingInfo {
    NSLog(@"imageUrl: %@ callBack: %@ trackingInfo: %@", imageUrl, callBack, trackingInfo);
    
    NSData * jsonData = [trackingInfo dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if (dic == nil) {
        dic = @{};
    }
    
    [NSNotificationCenter.defaultCenter postNotificationName:@"popBonus" object: @{@"imageUrl": imageUrl,
                                                                                 @"callBack": callBack,
                                                                                 @"trackingInfo": dic
                                                                                   } ];
    
//    [self.webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:callBack waitUntilDone:NO];
}

- (void)toWeb:(NSString *)imageUrl :(NSString *)url :(NSString *)trackingInfo {
//- (void)toWeb:(NSString *)imageUrl :(NSString *)url :(NSDictionary *)trackingInfo {
    NSLog(@"imageUrl: %@ url: %@ trackingInfo: %@", imageUrl, url, trackingInfo);

    NSData * jsonData = [trackingInfo dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if (dic == nil) {
        dic = @{};
    }
    [NSNotificationCenter.defaultCenter postNotificationName:@"popBonus" object: @{@"imageUrl": imageUrl,
                                                                                   @"url": url,
                                                                                   @"trackingInfo": dic
                                                                                   } ];
}

@end
