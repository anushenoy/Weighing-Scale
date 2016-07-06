//
//  Track.h
//  demometer
//
//  Created by Anush on 16/09/15.
//  Copyright (c) 2015 Neebal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define PI        3.14159265358979323846264338327950288


@interface Track : NSObject
{
float maxAngle;
}

@property(nonatomic,assign) float maxAngle;

#pragma mark - Properties associated with the track

@property (nonatomic, readonly, strong) CAShapeLayer *trackLayer;
@property (nonatomic, readonly, strong) CAShapeLayer *overLayer;
- (void)drawTrackShape;
- (void)drawOverShape:(float)angl;


@end
