//
//  MainViewController.h
//  BexApp
//
//  Created by Timotheus Jochum on 15/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupViewController.h"

@interface StartseiteViewController : UIViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *impressumButton;

@property (strong, nonatomic) IBOutlet UIImageView *notrufButton;
- (IBAction)impressumButtonPressed:(id)sender;
@end

