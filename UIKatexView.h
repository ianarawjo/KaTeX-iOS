//
//  UIKatexView.h
//  ExampleApp-iOS
//
//  Created by Ian Arawjo on 10/12/14.
//  Copyright (c) 2014 Ian Arawjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIKatexView : UIView <UIWebViewDelegate>

/** Create a KaTeX view at the given center point.
// * Since web views load asynchonously, 'center' ensures that you
// * can set the frame at initialization. */
+(instancetype)katexView:(NSString*)tex center:(CGPoint)center;

/** Constructor for custom settings. Default delimiter = $. */
+(instancetype)katexView:(NSString*)tex center:(CGPoint)center delimiter:(NSString*)delim;

@end
