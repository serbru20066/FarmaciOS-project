//
//  LocalesVC.m
//  proyectoFarmaciOS
//
//  Created by TKJ on 5/28/14.
//  Copyright (c) 2014 Alvaro Herrera. All rights reserved.
//

#import "LocalesVC.h"
#import "LocalesCell.h"
#import "AFNetworking.h"
#import "Local.h"
#import "MapVC.h"

@interface LocalesVC ()
{
    NSMutableArray *locales;
}
@end

@implementation LocalesVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Spinner
    activityView = [[OMBActivityView alloc] init];
    [self.view addSubview: activityView];
    [activityView startSpinning];
    
    //configurando table
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *idf = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"idFarmacia"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"idFarmacia":idf};
    
    [manager GET:@"http://farmaciosservices.somee.com/serviciofarmacia.svc/localesporfarmacia" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *arr = responseObject;
        NSLog(@"JSON: %@", responseObject);
        locales = [NSMutableArray array];
        
        for(NSDictionary *dict in arr)
        {
            
            Local *obj = [[Local alloc]init];
            obj.Direccion = [dict objectForKey:@"Direccion"];
            obj.Distrito = [dict objectForKey:@"Distrito"];
            // aqui la latitud y longitud
            
            
            [locales addObject:obj];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)regresar:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark UITableView Datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    MapVC *mvc = [[MapVC alloc]initWithNibName:@"MapVC" bundle:nil];
    [self.navigationController pushViewController:mvc animated:YES];
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return locales.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"LocalesCell";
    LocalesCell *cell = (LocalesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        UINib *cellNib = [UINib nibWithNibName:CellIdentifier bundle:[NSBundle mainBundle]];
        cell = [[cellNib instantiateWithOwner:self options:nil]objectAtIndex:0];
        
    }
    
    cell.direccion.text = ((Local*)[locales objectAtIndex:indexPath.row]).Direccion;
    cell.distrito.text = ((Local*)[locales objectAtIndex:indexPath.row]).Distrito;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     [activityView stopSpinning];
    
    
    return cell;
}
@end
