//
//  ContactTableViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 20/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "KontaktTableViewController.h"
#import "SWRevealViewController.h"
#import "SidebarTableViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface KontaktTableViewController ()

@end

@implementation KontaktTableViewController

static UIColor *orange;
static UIColor *white;
static UIColor *blue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRevealViewController];
    
    orange = UIColorFromRGB(0xFD9712);
    white  = [UIColor whiteColor];
    blue = UIColorFromRGB(0x73CFF7);
    
    [self initialiseTableView];
}

- (void)initialiseTableView {
    _menuItems = @[@"tableHeader", @"tableFestnetz", @"tableMobil", @"tableFax", @"tableEmail", @"tableInternet", @"tableAnschrift"];
    
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

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 1:
            [self callFestnetz];
            break;
        case 2:
            [self callMobile];
            break;
        case 3:
            break;
        case 4:
            [self openEmail];
            break;
        case 5:
            [self openWebPage];
            break;
        case 6:
            [self openMaps];
            break;
        default:
            break;
    }
}

- (void) callFestnetz{
    
    NSString *number = [NSString stringWithFormat:@"024155910559"];
    [self makeCall:number];
}

- (void) callMobile{
    
    NSString *number = [NSString stringWithFormat:@"01772981966"];
    [self makeCall:number];
}

- (void) openEmail{
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"bex@rechtsanwalt-bex.de"]];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void) openWebPage{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.rechtsanwalt-bex.de"]];
}

- (void) openMaps{

//    self.delegate = (SidebarTableViewController *) self.parentViewController;
    NSObject<KontaktTableViewControllerDelegate> *strongDelegate = self.delegate;
    
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    if ([strongDelegate respondsToSelector:@selector(kontaktTableViewControllerCalledMaps:)]) {
        [strongDelegate kontaktTableViewControllerCalledMaps:self];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //Add an alert in case of failure
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) makeCall:(NSString *) number{
//    NSString *number = [NSString stringWithFormat:@"08003301000"];
    NSURL* callUrl=[NSURL URLWithString:[NSString   stringWithFormat:@"telprompt:%@",number]];
    
    //check  Call Function available only in iphone
    if([[UIApplication sharedApplication] canOpenURL:callUrl])
    {
        [[UIApplication sharedApplication] openURL:callUrl];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Anruf nicht möglich"
                                                                       message:@"Auf diesem Gerät werden leider keine Anrufe unterstützt."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    [self setSelectedBackgroundColor:orange forCell:cell];
    return cell;
}


// Returns the Prototype Height for the Cells.
// Header and Anschrift are exceptions and have to be treated
// seperately
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier;
    if (indexPath.row == 0)
        cellIdentifier = @"tableHeader";
    else if (indexPath.row == 6)
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

- (UITableViewCell *)setSelectedBackgroundColor:(UIColor *) color forCell:(UITableViewCell *) cell {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    bgView.backgroundColor = color;
    
    cell.selectedBackgroundView = bgView;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
