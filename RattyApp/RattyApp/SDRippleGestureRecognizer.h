//
//  SDRippleGestureRecognizer.h
//  Swiftdial
//
//  Created by Nate Parrott on 2/17/15.
//  Copyright (c) 2015 Nate Parrott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRippleGestureRecognizer : UIGestureRecognizer

- (CGPoint)locationInView:(UIView *)view;

@end
