//
//  ViewController.h
//  WeighingScale
//
//  Created by atidan on 06/07/16.
//  Copyright © 2016 atidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *forceLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

//For the meter
@property(nonatomic,assign) float maxAngle;
@property(nonatomic,assign) float maxVal;
@property(nonatomic,retain) UIImageView *needleImageView;
@property(nonatomic,assign) float speedometerValue;
@property(nonatomic,assign) float angle;

@property(nonatomic,assign) float caliberateError;

@end

