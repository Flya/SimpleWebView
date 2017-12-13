//
//  WKWebKitViewController.m
//  SimpleWebView
//
//  Created by Сергей on 12/13/17.
//  Copyright © 2017 home. All rights reserved.
//

#import "WKWebKitViewController.h"
#import <WebKit/WebKit.h>
#import "AppDelegate.h"

@interface WKWebKitViewController ()<WKNavigationDelegate>
@property (strong, nonatomic) IBOutlet UIView *webViewContainer;
@property (nonatomic, weak) WKWebView* webView;
@end

@implementation WKWebKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  WKWebViewConfiguration* configurator = [[WKWebViewConfiguration alloc] init];
  WKWebView* webView = [[WKWebView alloc] initWithFrame:self.webViewContainer.bounds configuration:configurator];
  webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.webViewContainer addSubview:webView];
  webView.navigationDelegate = self;
  self.webView = webView;
  
  [self reloadAction:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeURL:) name:kChangeDefaultURLNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reloadAction:(id)sender
{
  
  [self.webView loadRequest:[NSURLRequest requestWithURL:[UIApplication sharedApplication].appDelegate.defaultURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30]];
}

- (void)changeURL:(NSNotification*)notification
{
  [self.webView loadRequest:[NSURLRequest requestWithURL:[UIApplication sharedApplication].appDelegate.defaultURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30]];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
  [self presentViewController:alert animated:true completion:nil];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}

@end
