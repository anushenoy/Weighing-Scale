//
//  Track.m
//  demometer
//
//  Created by Anush on 16/09/15.
//  Copyright (c) 2015 Neebal. All rights reserved.
//

#import "Track.h"
@interface Track ()
@property(strong,atomic)UIColor* overcolor;
@end

@implementation Track

@synthesize maxAngle;

- (id)init
{
    self = [super init];
    if (self) {
        
        //setup tracklayer
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.fillColor = [UIColor clearColor].CGColor;
        _trackLayer.strokeColor=[UIColor darkGrayColor].CGColor;
        _trackLayer.lineWidth=55;
        
        //setup overlayer
        _overLayer = [CAShapeLayer layer];
        _overLayer.fillColor = [UIColor clearColor].CGColor;
        _overLayer.lineWidth=55;
    }
    return self;
}


//Drawing the lower track
- (void)drawTrackShape
{
    UIBezierPath*  myPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height-50)
                                                           radius:80
                                                       startAngle:((PI / 180) *(-((self.maxAngle/2)+90)))
                                                         endAngle:((PI / 180) *(-90+(self.maxAngle/2)))
                                                        clockwise:YES];
    self.trackLayer.path = [myPath CGPath];
}


//Drawing the over track
- (void)drawOverShape:(float)angle
{
    UIBezierPath*  myPath1=[UIBezierPath bezierPathWithArcCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height-50)
                                                          radius:80
                                                      startAngle:((PI / 180) *(-((self.maxAngle/2)+90)))
                                                        endAngle:((PI / 180) *(angle))
                                                       clockwise:YES];
    
    //setting the over layer colour
    float x=(angle+((self.maxAngle/2)+90))/self.maxAngle;
    _overcolor=[UIColor colorWithRed:2*x green:2*(1-x) blue:0 alpha:0.75];
    _overLayer.strokeColor=_overcolor.CGColor;
    
    self.overLayer.path = [myPath1 CGPath];
}


@end
