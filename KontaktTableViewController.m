//
//  ContactTableViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 20/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "KontaktTableViewController.h"
#import "SWRevealViewController.h"

@interface KontaktTableViewController ()

@end

@implementation KontaktTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRevealViewController];
    
    [self initialiseTableView];
    
}

- (void)initialiseTableView {
    _menuItems = @[@"tableHeader", @"tableFestnetz", @"tableMobil", @"tableFax", @"tableEmail",
                  @"tableAnschrift"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [_menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}


// Returns the Prototype Height for the Cells.
// Header and Anschrift are exceptions and have to be treated
// seperately
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier;
    if (indexPath.row == 0)
        cellIdentifier = @"tableHeader";
    else if (indexPath.row == 5)
        cellIdentifier = @"tableAnschrift";
    else
        cellIdentifier = @"tableFestnetz";
    
    UITableViewCell *cell =
    [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell.bounds.size.height;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
