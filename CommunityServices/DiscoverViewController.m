//
//  DiscoveryViewController.m
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import "DiscoverViewController.h"
#import "HZWebViewController.h"
@interface DiscoverViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.financialnews.com.cn"]];
    [self.webView loadRequest:request];
    self.webView.scalesPageToFit = YES;
//    HZWebViewController *webViewController = [HZWebViewController new];
//    
//    //    webViewController.mode = HZWebBrowserModeNavigation;
//    webViewController.mode = HZWebBrowserModeModal;
//    webViewController.URL = [NSURL URLWithString:@"http://www.financialnews.com.cn"];
//    [webViewController load];

//    [self presentViewController:webViewController animated:YES completion:^{}];

}
- (void) dealloc
{
   self.webView.delegate = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
@end
