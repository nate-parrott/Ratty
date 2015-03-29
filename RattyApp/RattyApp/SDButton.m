//
//  SDButton.m
//  Swiftdial
//
//  Created by Nate Parrott on 2/18/15.
//  Copyright (c) 2015 Nate Parrott. All rights reserved.
//

#import "SDButton.h"
#import "SDRippleGestureRecognizer.h"

@interface SDButton () <UIGestureRecognizerDelegate>

@property (nonatomic) UIView *ripple;
@property (nonatomic) BOOL setupYet;

@end

@implementation SDButton

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!self.setupYet) {
        self.setupYet = YES;
        
        self.clipsToBounds = YES;
        
        self.layer.borderColor = self.tintColor.CGColor;
        self.layer.borderWidth = 2;
        self.layer.cornerRadius = 10;
        
        SDRippleGestureRecognizer *rec = [[SDRippleGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        rec.cancelsTouchesInView = NO;
        rec.delegate = self;
        [self addGestureRecognizer:rec];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)tapped:(SDRippleGestureRecognizer *)rec {
    if (rec.state == UIGestureRecognizerStateBegan) {
        if (!self.ripple) {
            CGPoint pos = [rec locationInView:self];
            CGFloat distanceToFurthestEdge = MAX(self.bounds.size.height - pos.y, MAX(pos.y, MAX(pos.x, self.bounds.size.width - pos.x)));
            UIView *ripple = [[UIView alloc] initWithFrame:CGRectMake(0, 0, distanceToFurthestEdge*2, distanceToFurthestEdge*2)];
            ripple.layer.cornerRadius = ripple.frame.size.width/2;
            ripple.center = [rec locationInView:self];
            ripple.transform = CGAffineTransformMakeScale(0.001, 0.001);
            ripple.backgroundColor = self.tintColor;
            [self addSubview:ripple];
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction animations:^{
                ripple.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
            self.ripple = ripple;
        }
    }
    if (rec.state == UIGestureRecognizerStateChanged) {
        self.ripple.center = [rec locationInView:self];
    }
    if (rec.state == UIGestureRecognizerStateEnded || rec.state == UIGestureRecognizerStateCancelled || rec.state == UIGestureRecognizerStateFailed) {
        if (self.ripple) {
            UIView *ripple = self.ripple;
            self.ripple = nil;
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                ripple.alpha = 0;
            } completion:^(BOOL finished) {
                [ripple removeFromSuperview];
            }];
        }
    }
}

@end
