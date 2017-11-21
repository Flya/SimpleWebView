//
//  FirstViewController.m
//  SimpleWebView
//
//  Created by Сергей on 11/21/17.
//  Copyright © 2017 home. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()<UIWebViewDelegate>
@property (nonatomic,weak) IBOutlet UIWebView* webview;

@end

@implementation FirstViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self reloadAction:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeURL:) name:kChangeDefaultURLNotification object:nil];
}

- (void)changeURL:(NSNotification*)notification
{
   [self.webview loadRequest:[NSURLRequest requestWithURL:notification.object]];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)reloadAction:(id)sender
{
  [self.webview loadRequest:[NSURLRequest requestWithURL:[UIApplication sharedApplication].appDelegate.defaultURL]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
  [self presentViewController:alert animated:true completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}

@end
