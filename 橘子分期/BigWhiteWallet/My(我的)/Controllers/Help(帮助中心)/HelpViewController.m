//
//  HelpViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic)  WKWebView *wkWebView;

@end

@implementation HelpViewController
//隐藏底部bottombar
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
    self.title=@"帮助中心";
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController=[[WKUserContentController alloc]init];
    // 自适应屏幕宽度js

    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];

    // 添加自适应屏幕宽度js调用的方法

    [userContentController addUserScript:wkUserScript];
    wkWebConfig.userContentController=userContentController;
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;

    preferences.minimumFontSize = 20.0;
    wkWebConfig.preferences = preferences;
//
    self.wkWebView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)configuration:wkWebConfig];

    self.wkWebView.UIDelegate=self;
    self.wkWebView.navigationDelegate=self;

        NSString *str=@"http://veenew.com:8081/static/wanbiao/help-2.html";
        NSURL *webUrl=[NSURL URLWithString:str];
//        NSData * data=[NSData dataWithContentsOfURL:webUrl];
//
//        [self.wkWebView loadData:data MIMEType:@"text/html" characterEncodingName:@"GBK" baseURL:webUrl];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:webUrl]];
//    NSString *path=[[NSBundle mainBundle] pathForResource:_model.link ofType:nil];
//    if (path) {
//        [self.wkWebView loadFileURL:[NSURL fileURLWithPath:path] allowingReadAccessToURL:[NSBundle mainBundle].resourceURL];
//    }
    [self.view addSubview:self.wkWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
