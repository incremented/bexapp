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
    
    [self setupImageView];
    
    [self setupPageController];
    
    [self setupTextView];
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
