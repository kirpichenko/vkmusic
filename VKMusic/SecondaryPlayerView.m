//
//  SecondaryPlayerView.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 5/11/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SecondaryPlayerView.h"

#import <QuartzCore/QuartzCore.h>

static const float kTonarmMinAngle = -30.f;
static const float kTonarmMaxAngle = -60.f;
static const float kAnimationDuration = 0.25;

static NSString *const kPlayingAudioTimeKey = @"playingAudioTime";

static float degreesToRadians(float degrees)
{
    return degrees * M_PI / 180.;
}

static float radiansToDegrees(float radians)
{
    return radians * 180 / M_PI;
}

@interface SecondaryPlayerView ()
@property (nonatomic,strong) UISlider *volumeSlider;

@property (nonatomic,assign) BOOL tonarmIsInUse;
@property (nonatomic,assign) BOOL tonarmIsAnimating;
@end

@implementation SecondaryPlayerView

@synthesize volumeSlider;

#pragma mark - life cycle

- (void)awakeFromNib
{
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displyLinkFired:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    volumeSlider = [[UISlider alloc] init];
    
    [[diskImageView layer] setCornerRadius:160];
    [self configureTonarmView];
}

- (void)dealloc
{
    [self setVolumeSlider:nil];
}

#pragma mark - display link

- (void)displyLinkFired:(CADisplayLink *)aDisplayLink
{
    if ([_player state] == kAudioPlayerStatePlaying) {
        float angle = - [aDisplayLink duration] * 2;
        [rotatingLogoView setTransform:CGAffineTransformRotate([rotatingLogoView transform], angle)];
    }    
}

#pragma mark - tonarm 

- (void)setTonarmAngle:(float)degrees 
{
    float radians = degreesToRadians(degrees);
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, radians);

    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         [self setTonarmIsAnimating:YES];
                         [tonarmView setTransform:transform];
                     }
                     completion:^(BOOL finished) {
                         [self setTonarmIsAnimating:NO];
                     }];
}

- (void)configureTonarmView
{
    CGRect tonarmViewFrame = [tonarmView frame];

    [[tonarmView layer] setAnchorPoint:CGPointMake(1, 0.5)];
    [tonarmView setFrame:tonarmViewFrame];
}

#pragma mark - accessories

- (void)setPlayer:(AudioPlayer *)player
{
    if (_player != player) {
        [_player removeObserver:self forKeyPath:kPlayingAudioTimeKey];
        
        _player = player;

        [_player addObserver:self forKeyPath:kPlayingAudioTimeKey options:NSKeyValueObservingOptionNew
                     context:nil];
    }
}

#pragma mark - observe player

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context
{
    if (_player == object && [keyPath isEqual:kPlayingAudioTimeKey] &&
        ![self tonarmIsInUse] && ![self tonarmIsAnimating])
    {
        float elapsedPart = [_player playingAudioTime] / [[_player playingAudio] duration];
        float tonarmAngle = (kTonarmMaxAngle - kTonarmMinAngle) * elapsedPart + kTonarmMinAngle;

        [self setTonarmAngle:tonarmAngle];
    }
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint([tonarmView frame], [touch locationInView:self])) {
        [self setTonarmIsInUse:YES];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    float angle = [self tonarmAngleForTouch:[touches anyObject]];
    if (angle != CGFLOAT_MAX) {
        [self setTonarmAngle:angle];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    float angle = [self tonarmAngleForTouch:[touches anyObject]];
    if (angle != CGFLOAT_MAX) {
        [self setTonarmAngle:angle];
        
        float progress = (angle - kTonarmMinAngle) / (kTonarmMaxAngle - kTonarmMinAngle);
        [[self tonarmDelegate] userChangedTonarmProgress:progress];
    }
    [self setTonarmIsInUse:NO];
}

#pragma mark - helpers

- (float)tonarmAngleForTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:self];
    if (CGRectContainsPoint([tonarmView frame], location))
    {
        float height = location.y - CGRectGetMinY([tonarmView frame]);
        float width = location.x - CGRectGetMaxX([tonarmView frame]);
        
        float angle = radiansToDegrees(atanf(height / width));
        if (angle > kTonarmMaxAngle && angle < kTonarmMinAngle) {
            return angle;
        }
    }
    return CGFLOAT_MAX;
}

- (void)unlockTonarm
{
    [self setTonarmIsInUse:NO];
}

@end
