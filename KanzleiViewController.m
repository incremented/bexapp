//
//  KanzleiViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 21/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "KanzleiViewController.h"
#import "SWRevealViewController.h"

@interface KanzleiViewController ()

@end

@implementation KanzleiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRevealViewController];
    
    [self setupImageView];
    
    [self setupPageController];
    
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
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

- (void)setupImageView {
 
 _images = @[@"kanzleiRaum", @"kanzleiRaum2", @"kanzleiRaum",
 @"kanzleiRaum2", @"kanzleiRaum"];
 
 _imageView.userInteractionEnabled = YES;
 _imageViewPageIndex = 0;
 UIImage *image = [UIImage imageNamed:[_images objectAtIndex:_imageViewPageIndex]];
 [_imageView setImage:image];
 
 UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
 initWithTarget:self action:@selector(handleSwipeGestureLeft:)];
 UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
 initWithTarget:self action:@selector(handleSwipeGestureRight:)];
 
 [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
 [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
 
 swipeLeft.delegate = self;
 swipeRight.delegate = self;
 
 [_imageView addGestureRecognizer:swipeLeft];
 [_imageView addGestureRecognizer:swipeRight];
 }

 
 - (void) setupPageController {
 
 _pageControl.userInteractionEnabled = NO;
 }

 - (void) handleSwipeGestureRight:(UIPanGestureRecognizer *) recognizer{
 
 _imageViewPageIndex--;
 if (_imageViewPageIndex < 0) {
 _imageViewPageIndex = _images.count - 1;
 }
 
 UIImage *image = [UIImage imageNamed:[_images objectAtIndex:_imageViewPageIndex]];
 [_imageView setImage:image];
 
 _pageControl.currentPage = _imageViewPageIndex;
 [_pageControl updateCurrentPageDisplay];
 }
 


 - (void) handleSwipeGestureLeft:(UIPanGestureRecognizer *) recognizer{
 
 _imageViewPageIndex++;
 if (_imageViewPageIndex >= _images.count) {
 _imageViewPageIndex = 0;
 }
 
 UIImage *image = [UIImage imageNamed:[_images objectAtIndex:_imageViewPageIndex]];
 [_imageView setImage:image];
 
 _pageControl.currentPage = _imageViewPageIndex;
 [_pageControl updateCurrentPageDisplay];
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
