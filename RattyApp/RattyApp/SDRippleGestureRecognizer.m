//
//  SDRippleGestureRecognizer.m
//  Swiftdial
//
//  Created by Nate Parrott on 2/17/15.
//  Copyright (c) 2015 Nate Parrott. All rights reserved.
//

#import "SDRippleGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface SDRippleGestureRecognizer ()

@end

@implementation SDRippleGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateBegan;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateChanged;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateEnded;
    [self reset];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateCancelled;
    [self reset];
}
- (CGPoint)locationInView:(UIView *)view {
    return [self locationOfTouch:0 inView:view];
}

@end
