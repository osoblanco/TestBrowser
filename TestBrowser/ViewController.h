//
//  ViewController.h
//  TestBrowser
//
//  Created by Erik Arakelyan on 6/14/14.
//  Copyright (c) 2014 Erik Arakelyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;


@interface ViewController : UIViewController <UIWebViewDelegate,UITextFieldDelegate>

@property NSMutableArray *transferArray;
@property NSArray *gottenAraay;

@property (weak, nonatomic) IBOutlet UITextField *searcBarOutlet;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
