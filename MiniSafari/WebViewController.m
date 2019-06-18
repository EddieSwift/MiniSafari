//
//  WebViewController.m
//  MiniSafari
//
//  Created by Eduard Galchenko on 6/18/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.translatesAutoresizingMaskIntoConstraints = false;
    self.webView.navigationDelegate = self;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [self.indicator stopAnimating];
    
    [self refreshButtons];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    [self.indicator stopAnimating];
    
    [self refreshButtons];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - Actions

- (IBAction)goButtonAction:(UIButton *)sender {
    
    [self loadWebSite];
}

- (IBAction)backButtonAction:(UIBarButtonItem *)sender {
    
    [self.indicator startAnimating];

    if ([self.webView canGoBack]) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
    
    [self.webView reload];
}

- (IBAction)forwardButtonAction:(UIBarButtonItem *)sender {
    
    [self.indicator startAnimating];
    
    if ([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
    
    [self.webView reload];
}

- (IBAction)refreshButtonAction:(UIBarButtonItem *)sender {
    
    [self.indicator startAnimating];
    [self.webView stopLoading];
    [self.webView reload];
}

#pragma mark - Private Methods

- (void) refreshButtons {
    
    self.backButtonItem.enabled = [self.webView canGoBack];
    self.forwardButtonItem.enabled = [self.webView canGoForward];
}

- (void) loadWebSite {
    
    NSString *urlString = self.textField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.indicator];
    [self.indicator startAnimating];
    self.webView.navigationDelegate = self;
    [self.indicator hidesWhenStopped];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//    if ([textField isEqual:self.usernameSignTextField]) {
//
//        [self.passwordSignTextField becomeFirstResponder];
//
//    } else {
//
//        [textField resignFirstResponder];
//
//        // To click button for registration when you clicking button "Done" on the keyboard
//        [self signIn:self.loginButton];
//    }
    [textField resignFirstResponder];
    
    [self loadWebSite];
    
    return YES;
}

@end
