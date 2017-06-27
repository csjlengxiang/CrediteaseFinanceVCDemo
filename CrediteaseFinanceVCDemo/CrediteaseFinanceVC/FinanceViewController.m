//  Created by sijiechen3

#import <JavaScriptCore/JavaScriptCore.h>
#import "Masonry.h"
#import "FinanceViewController.h"
#import "UIWebView+TS_JavaScriptContext.h"
#import "FinancePresentViewController.h"
#import "DefaultAnimationProtocol.h"

@interface FinanceViewController () <UIWebViewDelegate, TSWebViewDelegate, DefaultAnimationProtocol>

@property (strong, nonatomic) UIRefreshControl * refreshControl;

@end

@implementation FinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.top.equalTo(self.view);
    }];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.webView.scrollView addSubview:self.refreshControl];

    self.isNeedReload = NO;
    [self reload];
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

//- (void)wishFinanceNotNeedReload {
//    self.isNeedReload = NO;
//}

- (void)onRefresh:(id)sender{
    if (self.refreshControl.isRefreshing) {
        self.activityIndicatorView.hidden = YES;
        [self reload];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    if (self.isNeedReload) {
        self.isNeedReload = NO;
        [self reload];
    }
}

- (void)reload {
    [self loadWebPageWithUrl:FinanceRootURL];
}

//- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) context {
////    context[@"app"] = [[SPBao alloc] initWithDelegate:self];
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.description isEqualToString:FinanceRootURL]) {
        return YES;
    } else if ([request.URL.description containsString:@"tel"]) {
        return YES;
    } else if ([request.URL.description isEqualToString:@"about:blank"]) {
        return NO;
    } else {
        FinancePresentViewController * vc = [[FinancePresentViewController alloc] init];
        vc.request = request;
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:nvc animated:YES completion:nil];
        });
        self.isNeedReload = YES;
        return NO;
    }
    return  YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [super webViewDidStartLoad:webView];
    if (self.refreshControl.isRefreshing) {
        self.activityIndicatorView.hidden = YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [super webViewDidFinishLoad:webView];
    [self.refreshControl endRefreshing];
}

@end
