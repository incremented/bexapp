//
//  SidebarTableViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 18/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "CustomCell.h"

@interface SidebarTableViewController ()

@end

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation SidebarTableViewController

static UIColor *orange;
static UIColor *white;
static UIColor *blue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    orange = UIColorFromRGB(0xFD9712);
    white  = [UIColor whiteColor];
    blue = UIColorFromRGB(0x73CFF7);
    
    [self initialiseTableView];
}

- (void)initialiseTableView {
    
    _menuItems = @[@"tableStartseite", @"tableKanzlei", @"tableRechtsanwaltBex", @"tableTaetigkeitsbereich",
                   @"tableKontakt", @"tableKarte"];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuItems.count;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Update previousCell Background to white
    // And Text to blue (default)
    switch (_currentSelectedCellIndex) {
        case 0:
            [self setBackgroundColor:white forCell:_startSeiteCell];
            [self setTextColor:blue forCell:_startSeiteCell];
            break;
        case 1:
            [self setBackgroundColor:white forCell:_kanzleiCell];
            [self setTextColor:blue forCell:_kanzleiCell];
            break;
        case 2:
            [self setBackgroundColor:white forCell:_rechtsanwaltBexCell];
            [self setTextColor:blue forCell:_rechtsanwaltBexCell];
            break;
        case 3:
            [self setBackgroundColor:white forCell:_taetigkeitsBereichCell];
            [self setTextColor:blue forCell:_taetigkeitsBereichCell];
            break;
        case 4:
            [self setBackgroundColor:white forCell:_contactCell];
            [self setTextColor:blue forCell:_contactCell];
            break;
        case 5:
            [self setBackgroundColor:white forCell:_karteCell];
            [self setTextColor:blue forCell:_karteCell];
            break;
        default:
            break;
    }
   
    // Update selected Cells Background to Orange
    // And Text to white
    switch (indexPath.row) {
        case 0:
            [self setBackgroundColor:orange forCell:_startSeiteCell];
            [self setTextColor:white forCell:_startSeiteCell];
            break;
        case 1:
            [self setBackgroundColor:orange forCell:_kanzleiCell];
            [self setTextColor:white forCell:_kanzleiCell];
            break;
        case 2:
            [self setBackgroundColor:orange forCell:_rechtsanwaltBexCell];
            [self setTextColor:white forCell:_rechtsanwaltBexCell];
            break;
        case 3:
            [self setBackgroundColor:orange forCell:_taetigkeitsBereichCell];
            [self setTextColor:white forCell:_taetigkeitsBereichCell];
            break;
        case 4:
            [self setBackgroundColor:orange forCell:_contactCell];
            [self setTextColor:white forCell:_contactCell];
            break;
        case 5:
            [self setBackgroundColor:orange forCell:_karteCell];
            [self setTextColor:white forCell:_karteCell];
            break;
        default:
            break;
    }
    
    _currentSelectedCellIndex = indexPath.row;
    
    return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
  cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *CellIdentifier = [_menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            [self setBackgroundColor:orange forCell:cell];
            [self setTextColor:white forCell:cell];
            _startSeiteCell = cell;
            _currentSelectedCell = 0;
            break;
        case 1:
            _kanzleiCell = cell;
            break;
        case 2:
            _rechtsanwaltBexCell = cell;
            break;
        case 3:
            _taetigkeitsBereichCell = cell;
            break;
        case 4:
            _contactCell = cell;
            break;
        case 5:
            _karteCell = cell;
            break;
        default:
            break;
    }
    
    [self setSelectedBackgroundColor:orange forCell:cell];
    
    return cell;
}

- (UITableViewCell *)setBackgroundColor:(UIColor *) color forCell:(UITableViewCell *) cell{
    
    cell.backgroundColor = color;
    return cell;
}

- (UITableViewCell *)setTextColor:(UIColor *) color forCell:(UITableViewCell *) cell {
 
    ((UILabel *)cell.contentView.subviews[0]).textColor = color;
    return cell;
}

- (UITableViewCell *)setSelectedBackgroundColor:(UIColor *) color forCell:(UITableViewCell *) cell {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    bgView.backgroundColor = color;
    cell.selectedBackgroundView = bgView;
    
    return cell;
}
@end
