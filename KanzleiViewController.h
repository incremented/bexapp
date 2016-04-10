//
//  KanzleiViewController.h
//  BexApp
//
//  Created by Timotheus Jochum on 21/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KanzleiViewController : UIViewController <UIGestureRecognizerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *images;

@property NSInteger imageViewPageIndex;

@end
