//
//  UIKatexView.m
//  ExampleApp-iOS
//
//  Created by Ian Arawjo on 10/12/14.
//  Copyright (c) 2014 Ian Arawjo. All rights reserved.
//

#import "UIKatexView.h"
#define DEFAULT_DELIMITER @"$"

@implementation UIKatexView {
    UIWebView * _katexWebView;
    CGPoint _storedCenter;
    
    NSString * _delimiter;
}

// * Use this instead of initWithFrame! *
+(instancetype)katexView:(NSString*)tex center:(CGPoint)center {
    return [self katexView:tex center:center delimiter:DEFAULT_DELIMITER];
}
+(instancetype)katexView:(NSString*)tex center:(CGPoint)center delimiter:(NSString*)delim {
    UIKatexView * k = [[UIKatexView alloc] initWithFrame:CGRectZero];
    [k setCenter:center];
    [k setDelimiter:delim];
    [k loadKatex:tex];
    return k;
}
-(void)setDelimiter:(NSString*)delim {
    _delimiter = delim;
}
-(void)setCenter:(CGPoint)center {
    [super setCenter:center];
    _storedCenter = center;
}

-(void)webViewDidFinishLoad:(UIWebView *)aWebView {
    if (aWebView == _katexWebView) {
        
        /* Courtesy Phenomena @ SO */
        /* http://stackoverflow.com/questions/3936041/how-to-determine-the-content-size-of-a-uiwebview */
        aWebView.scrollView.scrollEnabled = NO;    // Property available in iOS 5.0 and later
        CGRect frame = aWebView.frame;
        
        frame.size.width = 200;       // Your desired width here.
        frame.size.height = 1;        // Set the height to a small one.
        
        frame.origin.y = 0;
        
        aWebView.frame = frame;       // Set webView's Frame, forcing the Layout of its embedded scrollView with current Frame's constraints (Width set above).
        
        frame.size.width = aWebView.scrollView.contentSize.width;
        frame.size.height = aWebView.scrollView.contentSize.height;  // Get the corresponding height from the webView's embedded scrollView.
        
        aWebView.frame = frame;       // Set the scrollView contentHeight back to the frame itself.
        
        // UIKatexView acts as a dummy UIView, since Apple says we can't directly subclass UIWebView.
        CGRect selfFrame = self.frame;
        selfFrame.size = aWebView.frame.size;
        self.frame = selfFrame;
        
        // Reposition, just in case:
        [self setCenter:_storedCenter];
    }
}
-(void)loadKatex:(NSString*)content {
    if (!content) return;
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"katex/index" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    // Here's where the magic happens...
    // Ideally we want: I heard that $c = \sqrt{a^2 - b^2}$ but I don't believe it.
    // But we can only do that from a file.
    // In-line, we escape:
    //NSString* content = @"I heard that $c = \\sqrt{a^2 - b^2}$ but I don't believe it.";
    if([content rangeOfString:_delimiter].location != NSNotFound) { // Expression inside text.
        NSRange r;
        BOOL intex = NO;
        while ((r = [content rangeOfString:_delimiter]).location != NSNotFound) {
            content = [content stringByReplacingCharactersInRange:r
                                                       withString:(intex ? @"</span>" : @"<span class=\"tex\">")];
            intex = !intex;
        }
        if (intex) NSLog(@"Katex iOS: Error: No closing $.");
    } else { // Raw KaTeX.
        content = [NSString stringWithFormat:@"<span class=\"tex\">%@</span>", content];
    }
    
    // Place into HTML
    appHtml = [appHtml stringByReplacingOccurrencesOfString:@"$LATEX$"
                                                 withString:content];
    
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView setDelegate:self];
    
    // Add katex web view (needed for formatting)
    [self addSubview:webView];
    
    [webView loadHTMLString:appHtml baseURL:baseURL];
    _katexWebView = webView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
