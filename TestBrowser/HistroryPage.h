//
//  HistroryPage.h
//  TestBrowser
//
//  Created by Erik Arakelyan on 6/17/14.
//  Copyright (c) 2014 Erik Arakelyan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ViewController.h"
@protocol HistoryProtocol <NSObject>
-(void)openUrlWithurl:(NSURL *)url;
@end

@interface HistroryPage : UITableViewController <UITableViewDataSource>
@property (nonatomic, strong) NSArray *histroryArr;

@property (nonatomic, strong) id<HistoryProtocol> delegate;
@end
