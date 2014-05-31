//
//  MapaTodosVC.h
//  proyectoFarmaciOS
//
//  Created by Alvaro Herrera on 31/05/14.
//  Copyright (c) 2014 Bruno Cardenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapaTodosVC : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapa;

@end
