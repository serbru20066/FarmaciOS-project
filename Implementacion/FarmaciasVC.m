
//  LocalesVC.m
//  proyectoFarmaciOS
//
//  Created by Alvaro Herrera on 25/05/14.
//  Copyright (c) 2014 Alvaro Herrera. All rights reserved.
//

#import "FarmaciasVC.h"
#import "FarmaciasCell.h"
#import "AFNetworking.h"
#import "Farmacia.h"
#import "LocalesVC.h"
#import "MapaTodosVC.h"
#import "DiamondActivityIndicator.h"

@interface FarmaciasVC ()
{
    NSMutableArray *farmacias;

}
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;
@end

@implementation FarmaciasVC

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
    
    //SPinner
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    HUD.labelText=@"Cargando Datos";
	[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

    

    
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidLoad];
    // Obtener datos del NSUSerDefault y mostrarlos
    self.view.backgroundColor=[UIColor whiteColor];
    //esconder boton Back
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    //cache
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4;
    self.imageCache = [[NSCache alloc] init];
    
    
    //configurando tabla
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{};

    [manager GET:@"http://farmaciosservices.somee.com/serviciofarmacia.svc/Farmacias" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *arr = responseObject;
        NSLog(@"JSON: %@", responseObject);
        farmacias = [NSMutableArray array];

        for(NSDictionary *dict in arr)
        {
            
            Farmacia *obj = [[Farmacia alloc]init];
            obj.NomFarmacia = [dict objectForKey:@"NomFarmacia"];
            obj.IdFarmacia = [dict objectForKey:@"IdFarmacia"];
            obj.FechaFundacion = [dict objectForKey:@"FechaFundacion"];
            obj.RutaIMG = [dict objectForKey:@"RutaIMG"];
            

            [farmacias addObject:obj];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSLog(@"Error: %@", error);
    }];
    

}
- (void)myTask {
    sleep(20);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * idf =  ((Farmacia*)[farmacias objectAtIndex:indexPath.row]).IdFarmacia;
    NSLog(@"%@",idf);
    
    LocalesVC *lvc = [[LocalesVC alloc]initWithNibName:@"LocalesVC" bundle:nil];
    [self.navigationController pushViewController:lvc animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:idf forKey:@"idFarmacia"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void) goMap
{
    MapaTodosVC *mp = [[MapaTodosVC alloc]initWithNibName:@"MapaTodosVC" bundle:nil];
    [self.navigationController pushViewController:mp animated:YES];
    
}
#pragma mark UITableView Datasource

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
    return farmacias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    static NSString *CellIdentifier = @"FarmaciasCell";
    FarmaciasCell *cell = (FarmaciasCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        UINib *cellNib = [UINib nibWithNibName:CellIdentifier bundle:[NSBundle mainBundle]];
        cell = [[cellNib instantiateWithOwner:self options:nil]objectAtIndex:0];
        
    }
    
    NSURL *imageURL = [NSURL URLWithString:((Farmacia*)[farmacias objectAtIndex:indexPath.row]).RutaIMG];
    
    UIImage *cachedImage = [self.imageCache objectForKey:imageURL];
    if (cachedImage)
    {
        cell.imagen.image = cachedImage;
        NSLog(@"cacheee");
    }
    else
    {
        cell.imagen.image = nil;

        [self.imageDownloadingQueue addOperationWithBlock:^{
            
            NSURL *imageUrl   = imageURL;
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image    = nil;
            if (imageData)
                image = [UIImage imageWithData:imageData];
            
            if (image)
            {
        
             
               
                
                [self.imageCache setObject:image forKey:imageURL];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{

                    UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        cell.imagen.image = image;
                }];
            }
        }];
  
    }
    
    cell.nombre.text = ((Farmacia*)[farmacias objectAtIndex:indexPath.row]).NomFarmacia;
    cell.fechafundacion.text = ((Farmacia*)[farmacias objectAtIndex:indexPath.row]).FechaFundacion;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.mapa addTarget:self action:@selector(goMap) forControlEvents:UIControlEventTouchUpInside];
    
    
    [HUD removeFromSuperview];
    
    return cell;
}




@end
