//
//  PopupViewController.h
//  BexApp
//
//  Created by Timotheus Jochum on 31/03/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface PopupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
