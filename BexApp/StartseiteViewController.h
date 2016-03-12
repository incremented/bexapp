//
//  MainViewController.h
//  BexApp
//
//  Created by Timotheus Jochum on 15/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartseiteViewController : UIViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)notrufButtonPressed:(id)sender;
@end

