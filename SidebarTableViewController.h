//
//  SidebarTableViewController.h
//  BexApp
//
//  Created by Timotheus Jochum on 18/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *menuItems;
@property NSInteger currentSelectedCellIndex;
@property (strong, nonatomic) UITableViewCell *currentSelectedCell;

@property (strong, nonatomic) UITableViewCell *startSeiteCell;
@property (strong, nonatomic) UITableViewCell *kanzleiCell;
@property (strong, nonatomic) UITableViewCell *taetigkeitsBereichCell;
@property (strong, nonatomic) UITableViewCell *contactCell;
@property (strong, nonatomic) UITableViewCell *karteCell;
@end
