//
//  PhotoByPhotographerCDTVC.h
//  PhotoMania
//
//  Created by Ujwal Manjunath on 5/7/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Photographer.h"
@interface PhotoByPhotographerCDTVC : CoreDataTableViewController

@property (nonatomic,strong) Photographer *photographer;
@end
