//
//  DemoPhotographerCDTVC.m
//  PhotoMania
//
//  Created by Ujwal Manjunath on 5/7/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "DemoPhotographerCDTVC.h"
#import "FlickrFetcher.h"
#import "Photo+Flickr.h"

@interface DemoPhotographerCDTVC ()

@end

@implementation DemoPhotographerCDTVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!self.managedObjectContext) [self useDemoDocument];
}

-(void)useDemoDocument
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    url = [url URLByAppendingPathComponent:@"Demo Document"];
    UIManagedDocument *document = [[UIManagedDocument alloc]initWithFileURL:url];

    if(![[NSFileManager defaultManager]fileExistsAtPath:[url path]]){
        // create it
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            if(success){
                self.managedObjectContext = document.managedObjectContext;
                [self refresh];
            }
            
        }];
    }else if (document.documentState == UIDocumentStateClosed){
        //open it
        [document openWithCompletionHandler:^(BOOL success){
            if(success){
                self.managedObjectContext = document.managedObjectContext;
            }
        }];
    }
    else{
        //try to use it
         self.managedObjectContext = document.managedObjectContext;
    }
}

-(IBAction)refresh
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetch", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *photos = [FlickrFetcher latestGeoreferencedPhotos  ];
        //put the photos in core data
        [self.managedObjectContext performBlock:^{
            for(NSDictionary *photo in photos){
                [Photo photoWithFlickrInfo:photo inManagedObjectContext:self.managedObjectContext];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
            });

        }];
    });
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

@end
