//
//  KanzleiViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 21/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "KanzleiViewController.h"
#import "SWRevealViewController.h"

#define kCellsPerRow 5

@interface KanzleiViewController ()

@end

@implementation KanzleiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRevealViewController];

//    [self setupImageView];
    
//    [self setupPageController];
    
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillLayoutSubviews{
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    CGFloat availableWidthForCells = CGRectGetWidth(self.view.frame) * 5;
    CGFloat cellWidth = availableWidthForCells / 5;
    CGFloat cellHeight = cellWidth * 0.46875;
    
    self.collectionViewHeight.constant = cellHeight;
//    [self.view layoutIfNeeded];
//    flowLayout.itemSize = CGSizeMake(cellWidth, flowLayout.itemSize.height);
//    flowLayout.itemSize = CGSizeMake(cellWidth, cellHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    CGFloat availableWidthForCells = CGRectGetWidth(self.view.frame) * 5;
    CGFloat cellWidth = availableWidthForCells / 5;
    CGFloat cellHeight = cellWidth * 0.46875;

    self.collectionViewHeight.constant = cellHeight + 16;
    return CGSizeMake(cellWidth, cellHeight - 1);
}

- (void)viewDidLayoutSubviews{
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
 
 _images = @[@"kanzleiRaum2", @"kanzleiRaum", @"kanzleiRaum5",
 @"kanzleiRaum3", @"kanzleiRaum4"];
 
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    
    switch (indexPath.row) {
        case 0:
            reuseIdentifier = @"cell1";
            break;
        case 1:
            reuseIdentifier = @"cell2";
            break;
        case 2:
            reuseIdentifier = @"cell3";
            break;
        case 3:
            reuseIdentifier = @"cell4";
            break;
        case 4:
            reuseIdentifier = @"cell5";
            break;
        default:
            break;
    }
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentIndex = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    [self.pageControl setCurrentPage:currentIndex];
}


@end
