//
//  ImageViewController.m
//  ShutterBug
//
//  Created by Ujwal Manjunath on 3/2/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "ImageViewController.h"
#import "AttributedStringViewController.h"
#import "Photo.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *titleBarButtonItem;
@property(nonatomic,strong) UIPopoverController *urlPopOver;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *splitViewBarButtonItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;


@end

@implementation ImageViewController

-(void)setsplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    if(_splitViewBarButtonItem) [toolbarItems removeObject:_splitViewBarButtonItem];
    
    if(splitViewBarButtonItem) [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
    self.toolbar.items = toolbarItems;
    _splitViewBarButtonItem = splitViewBarButtonItem;
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"ShowUrl"])
    {
        return (self.imageURL && !self.urlPopOver.popoverVisible)? YES:NO;
    }
    else
    {
        return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowUrl"])
    {
        if([segue.destinationViewController isKindOfClass:[AttributedStringViewController class]])
        {
            AttributedStringViewController *asc = segue.destinationViewController;
            asc.text = [[NSAttributedString alloc]initWithString:[self.imageURL description]];
            if([segue isKindOfClass:[UIStoryboardPopoverSegue class]])
                self.urlPopOver = ((UIStoryboardPopoverSegue *)segue).popoverController;
            
        }
    }
   }

-(void)setTitle:(NSString *)title
{
    super.title = title;
    self.titleBarButtonItem.title = title;
}
-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}



-(UIImageView *)imageView
{
    if(!_imageView) _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    return _imageView;
}
-(void) resetImage
{
    if(self.scrollView){
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image=nil;
        NSURL *imageUrl = self.imageURL;
        [self.spinner startAnimating];
        dispatch_queue_t imageLoaderQ = dispatch_queue_create("image Loader", NULL);
        dispatch_async(imageLoaderQ, ^{
           
            [UIApplication sharedApplication].networkActivityIndicatorVisible =YES; //bad
    
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
            UIImage *image = [[UIImage alloc]initWithData:imageData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO; //bad
            if(self.imageURL == imageUrl)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(image)
                    {
                        self.scrollView.zoomScale=1.0;
                        self.scrollView.contentSize = image.size;
                        self.imageView.image = image;
                        self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                    }
                    [self.spinner stopAnimating];
                });
                
            }
            

        });
            }
    
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    [self resetImage];
    self.titleBarButtonItem.title = self.title;
    [self setsplitViewBarButtonItem:self.splitViewBarButtonItem];
	// Do any additional setup after loading the view.
}



@end
