//
//  LocalesVC.h
//  proyectoFarmaciOS
//
//  Created by Alvaro Herrera on 25/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiamondActivityIndicator.h"
#import "MBProgressHUD.h"

@interface FarmaciasVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD *HUD;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
