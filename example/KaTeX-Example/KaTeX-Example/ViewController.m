//
//  ViewController.m
//  KaTeX-Example
//
//  Created by Ian Arawjo on 10/13/14.
//  Copyright (c) 2014 Ian Arawjo. All rights reserved.
//

#import "ViewController.h"
#import "UIKatexView.h"

#define SCREEN_CENTER CGPointMake([UIScreen mainScreen].bounds.size.width / 2., \
[UIScreen mainScreen].bounds.size.height / 2.)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    
    // Examples:
    NSString * katex = @"I heard that $c = \\sqrt{a^2 - b^2}$ but I don't believe it."; // or simply @"c = \\sqrt{a^2 - b^2}"
    //NSString * katex = @"What is $n$ if $n \\cdot 4$ gives $8$?";
    //NSString * katex = @"Remember that $\\displaystyle \\sum_{i=0}^n{i} = \\frac{(n)(n+1)}{2}$. Plugging in...";
    // [self.view addSubview:[UIWebView katexView:katex delegate:self]];
    [self.view addSubview:[UIKatexView katexView:katex center:SCREEN_CENTER]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
