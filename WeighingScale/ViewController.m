//
//  ViewController.m
//  WeighingScale
//
//  Created by atidan on 06/07/16.
//  Copyright © 2016 atidan. All rights reserved.
//

#import "ViewController.h"
#import "Track.h"
@interface ViewController ()

@end

@implementation ViewController
{
    Track *_track;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // check for 3D Touch availablity
    [self check3DTouch];
    
    //SPEEDOMETER STEUP
    //Alloc init speedometer track
    _track = [[Track alloc] init];
    
    //Set max angle
    self.maxAngle = 120;
    _track.maxAngle=self.maxAngle;
    
    // Set MaxValue
    self.maxVal = 385.0;
    
    //path
    [_track drawTrackShape];
    [self.view.layer addSublayer:_track.trackLayer];
    [_track drawOverShape:-(90+self.maxAngle)];
    [self.view.layer addSublayer:_track.overLayer];
    
    //  Needle
    _needleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/2)-10,[[UIScreen mainScreen] bounds].size.height-100, 20, 100)];
    
    // Shift the Needle center point to the end points of the needle image.
    _needleImageView.layer.anchorPoint = CGPointMake(_needleImageView.layer.anchorPoint.x, _needleImageView.layer.anchorPoint.y*2);
    
    //Setup the needleview
    _needleImageView.backgroundColor = [UIColor clearColor];
    _needleImageView.image = [UIImage imageNamed:@"arrow.png"];
    [self.view addSubview:self.needleImageView];
    
    // rotate Needle pointer initialy to zero
    [self rotateIt:(-(self.maxAngle)/2)];
}


- (IBAction)CaliberateClicked:(id)sender
{
    
    _caliberateError =  _speedometerValue;
    
}


- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (void)check3DTouch
{
    
    // check for 3D Touch availablity
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        NSLog(@"3D Touch is available! Hurray!");
        
        _errorLabel.hidden = YES;
    }
    else
    {
        NSLog(@"3D Touch is not available on this device. Sniff!");
        
        _errorLabel.hidden = NO;
    }
    
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = [touches allObjects].firstObject;
    
    if (touch.force >= touch.maximumPossibleForce)
    {
        _forceLabel.text = @"MAXED OUT";
        
        _speedometerValue =  385.0 - _caliberateError;
        
        [self calculateDeviationAngle];
    }
    else
    {
        _speedometerValue = ((touch.force * 385) / touch.maximumPossibleForce) - _caliberateError ;
        
        _forceLabel.text = [NSString stringWithFormat:@"%.1f gms.",_speedometerValue] ;
        
        [self calculateDeviationAngle];
    }

}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    _forceLabel.text = @"0.0 gms.";
    
    _speedometerValue = 0.0;
    
    [self calculateDeviationAngle];
    
}


-(void) calculateDeviationAngle
{
    
    _angle = ((_speedometerValue *_maxAngle)/_maxVal)-(_maxAngle/2);
    
    // Rotate Needle and layer
    [self rotateIt:_angle];
    
}


//Rotate the needle and layer
-(void) rotateIt:(float)angl
{
    
    [_needleImageView setTransform: CGAffineTransformMakeRotation((PI / 180) *angl)];
    
    [_track drawOverShape:(angl-90)];
    
}




@end
