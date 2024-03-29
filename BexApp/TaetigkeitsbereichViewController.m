//
//  TaetigkeitsbereichViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 21/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "TaetigkeitsbereichViewController.h"
#import "SWRevealViewController.h"

@interface TaetigkeitsbereichViewController ()

@end

@implementation TaetigkeitsbereichViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRevealViewController];
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
