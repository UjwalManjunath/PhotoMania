//
//  AttributedStringViewController.m
//  ShutterBug
//
//  Created by Ujwal Manjunath on 3/9/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "AttributedStringViewController.h"

@interface AttributedStringViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AttributedStringViewController

-(void )setText:(NSAttributedString *)text
{
    _text = text;
    self.textView.attributedText=text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.attributedText= self.text;
	// Do any additional setup after loading the view.
}



@end
