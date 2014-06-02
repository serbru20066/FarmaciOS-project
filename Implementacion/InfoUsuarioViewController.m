//
//  InfoUsuarioViewController.m
//  proyectoFarmaciOS
//
//  Created by bruno on 25/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import "InfoUsuarioViewController.h"
#import "LoguinViewController.h"

@interface InfoUsuarioViewController ()

@end

@implementation InfoUsuarioViewController

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
    
    UIImage *buttonImage = [UIImage imageNamed:@"general_top_button.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0,0.0,buttonImage.size.width,buttonImage.size.height);
    [aButton addTarget:self action:@selector(presentLeftMenuViewController:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    

    
    
    //Cabecera escondida
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    //Boton de FB
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectMake(100, 500,200, 300);
    loginView.delegate=self;
    [self.view addSubview:loginView];
    
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewDidLoad];
    // Obtener datos del NSUSerDefault y mostrarlos
    
    standardDefaults = [NSUserDefaults standardUserDefaults];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //esconder boton Back
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma FB Loguin Delegate






//Programamos en este delegado(de cerrar sesion) porque, cuando estemos en este viewcontroller, siempre sera porque ya estamos logueados
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    LoguinViewController *vc= [[LoguinViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    //resetear variables NSUSerDefault
    NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (NSString *key in [defaultsDictionary allKeys]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

//Este delegado se encarga de mostrar la informacion del usuario
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    
    //Labels con la informacion del usuario
    NSString *fbid = [standardDefaults
                      stringForKey:@"fbid"];
    NSString *fbname = [standardDefaults
                        stringForKey:@"fbname"];
    NSString *fbcorr = [standardDefaults
                        stringForKey:@"fbcorr"];
    
    UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(60, 90, 300, 20)];
    lbltitle.text=@"Informacion Obtenida";
    
    UILabel *lblnom=[[UILabel alloc] initWithFrame:CGRectMake(30, 140, 300, 20)];
    lblnom.text=[NSString stringWithFormat:@"%@ %@",@"Nombre:",fbname];
    
    UILabel *lblid=[[UILabel alloc] initWithFrame:CGRectMake(30, 180, 300, 20)];
    lblid.text=[NSString stringWithFormat:@"%@ %@",@"ID de facebook:",fbid];
    
    UILabel *lblcorr=[[UILabel alloc] initWithFrame:CGRectMake(30, 220, 300, 20)];
    lblcorr.text=[NSString stringWithFormat:@"%@ %@",@"Correo:",fbcorr];
    
    UILabel *lbltitimg=[[UILabel alloc] initWithFrame:CGRectMake(30, 260, 300, 20)];
    lbltitimg.text=@"Imagen de Perfil:";
    
    
    [self.view addSubview:lbltitle];
    [self.view addSubview:lblnom];
    [self.view addSubview:lblid];
    [self.view addSubview:lblcorr];
    [self.view addSubview:lbltitimg];
    
    
    //Imagen de perfil
    _profilePictureView=[[FBProfilePictureView alloc] init];
    _profilePictureView.frame=CGRectMake(170, 265, 100, 100);
    _profilePictureView.profileID = fbid;
    [self.view addSubview:_profilePictureView];
    
}


@end
