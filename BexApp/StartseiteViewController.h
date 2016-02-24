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
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property NSInteger imageViewPageIndex;
@property NSArray *images;
@end

