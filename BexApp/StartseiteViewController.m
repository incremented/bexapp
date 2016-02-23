//
//  MainViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 15/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "StartseiteViewController.h"
#import "SWRevealViewController.h"

@interface StartseiteViewController ()

@end

@implementation StartseiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRevealViewController];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, 1200)];
    [self.scrollView  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self setupTextView];
}

- (void)setupTextView {
    
}

// Adds the PanGesture and TapGesture Recognizer to self.view
- (void)setupRevealViewController {
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
