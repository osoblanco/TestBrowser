//
//  HistroryPage.m
//  TestBrowser
//
//  Created by Erik Arakelyan on 6/17/14.
//  Copyright (c) 2014 Erik Arakelyan. All rights reserved.
//

#import "HistroryPage.h"


@interface HistroryPage()
//@property NSString *searchString;
@end

@implementation HistroryPage
//-(void)addToTransfer
//{
//    self.searchString=myObject.searcBarOutlet.text;
//    NSURL *myurl=[[NSURL alloc]initWithString:self.searchString];
//    NSURLRequest *myRequest=[[NSURLRequest alloc]initWithURL:myurl];
//    [myObject.webView loadRequest:myRequest];
//
//
//}
-(void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self addToTransfer];
    NSURL *URL = self.histroryArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(openUrlWithurl:)]) {
        [self.delegate openUrlWithurl:URL];
    }


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.histroryArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = ((NSURL *)self.histroryArr[indexPath.row]).absoluteString;
    
//    [self addToTransfer];
    return cell;
}

@end
