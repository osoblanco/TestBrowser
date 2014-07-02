//
//  ViewController.m
//  TestBrowser
//
//  Created by Erik Arakelyan on 6/14/14.
//  Copyright (c) 2014 Erik Arakelyan. All rights reserved.
//

#import "ViewController.h"
#import "HistroryPage.h"
@interface ViewController ()<HistoryProtocol>


@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;


@property (nonatomic, strong) NSMutableArray *histrory;

@end

@implementation ViewController
@synthesize histrory;

- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}


-(void)openWebURL:(NSURL *)withURL
{
    [histrory addObject:withURL];
    NSURLRequest *myRequest=[[NSURLRequest alloc]initWithURL:withURL];
    [self.webView loadRequest:myRequest];
    

}

- (IBAction)procedeToURL:(id)sender
{
        
        NSString *query=[[NSString alloc]init];
        int counter=0;
        if((![self.searcBarOutlet.text hasPrefix:@"http://"]) && ([self.searcBarOutlet.text hasSuffix:@"com"]))
       {
           query=[self.searcBarOutlet.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
           NSURL *url=[[NSURL alloc ]initWithString:[NSString stringWithFormat:@"http://%@",query]];
           [self openWebURL:url];
           counter++;
       
       }
    
    if(counter==0)
        {
                if ([self validateUrl:self.searcBarOutlet.text]==NO) {
            
                NSString *googleString=@"https://google.com/search?q=";
                NSString *searchString=[NSString stringWithFormat:@"%@%@",googleString,self.searcBarOutlet.text];
                NSURL *tURL=[[NSURL alloc]initWithString:searchString];
                [self openWebURL:tURL];
            }
            else{
                NSURL *myURL=[NSURL URLWithString:self.searcBarOutlet.text];
               [self openWebURL:myURL];
            }
        }
    
    }


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    NSString *query=[[NSString alloc]init];
    int counter=0;
    if((![self.searcBarOutlet.text hasPrefix:@"http://"]) && ([self.searcBarOutlet.text hasSuffix:@"com"]))
    {
        query=[self.searcBarOutlet.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSURL *url=[[NSURL alloc ]initWithString:[NSString stringWithFormat:@"http://%@",query]];
        [self openWebURL:url];
        counter++;
        
    }
    
    if(counter==0)
    {
        if ([self validateUrl:self.searcBarOutlet.text]==NO) {
            
            NSString *googleString=@"https://google.com/search?q=";
            NSString *searchString=[NSString stringWithFormat:@"%@%@",googleString,self.searcBarOutlet.text];
            NSURL *tURL=[[NSURL alloc]initWithString:searchString];
            [self openWebURL:tURL];
        }
        else{
            NSURL *myURL=[NSURL URLWithString:self.searcBarOutlet.text];
            [self openWebURL:myURL];
        }
    }

    


    [self resignFirstResponder];
    [textField endEditing:YES];
    
    return YES;
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSURL *requestURL= request.URL;
    self.searcBarOutlet.text=[requestURL absoluteString];
    [self CheckBackAndForward];
    return YES;
}

- (IBAction)GoBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)GoForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)pinchingAction:(id)sender {
    
    [self.webView setScalesPageToFit:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searcBarOutlet.delegate=self;
    self.webView.delegate=self;
    histrory = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)Refresh:(id)sender {
    [self.webView reload];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self CheckBackAndForward];

}
- (IBAction)goToHistory:(id)sender {
    [self performSegueWithIdentifier:@"toHistory" sender:self];
  
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HistoryTable" ]) {
        HistroryPage *contr = segue.destinationViewController;
        contr.histroryArr = [histrory copy];
        contr.delegate = self;
    }


}

-(void)CheckBackAndForward
{
    if([self.webView canGoBack])
        self.backButton.enabled=YES;
    if ([self.webView canGoForward])
        self.forwardButton.enabled=YES;
    
}

-(void)openUrlWithurl:(NSURL *)url {
    [self openWebURL:url];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
