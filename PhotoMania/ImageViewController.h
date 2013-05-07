//
//  ImageViewController.h
//  ShutterBug
//
//  Created by Ujwal Manjunath on 3/2/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic,strong) NSURL *imageURL;

@end
