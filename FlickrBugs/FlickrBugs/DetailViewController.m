//
//  DetailViewController.m
//  FlickrBugs
//
//  Created by Geppy Parziale on 10/21/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Selected Photo";

    UIBarButtonItem *rotateButton = [[UIBarButtonItem alloc] initWithTitle:@"Rotate" style:UIBarButtonItemStylePlain target:self action:@selector(rotateImage)];
    [self.navigationItem setRightBarButtonItem:rotateButton];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    dispatch_queue_t queue = dispatch_queue_create("com.invasivecode.queue", 0);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:self.imageUrl];
        UIImage *image = [UIImage imageWithData:imageData];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });

    });

}


- (void)rotateImage
{
    // This is CORE GRAPHIC, it is not so good
    // the best is to send to the GPU using converting image to CoreImage and its much faster
    
    
    CGImageRef currentCGImage = [self.imageView.image CGImage];

    CGSize originalSize = self.imageView.image.size;
    CGSize rotatedSize = CGSizeMake(originalSize.height, originalSize.width);

    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 rotatedSize.width,
                                                 rotatedSize.height,
                                                 CGImageGetBitsPerComponent(currentCGImage),
                                                 CGImageGetBitsPerPixel(currentCGImage) * rotatedSize.width,
                                                 CGImageGetColorSpace(currentCGImage),
                                                 CGImageGetBitmapInfo(currentCGImage));

    CGContextTranslateCTM(context, rotatedSize.width, 0.0f);
    CGContextRotateCTM(context, M_PI_2);
    CGContextDrawImage(context, (CGRect){.origin = CGPointZero, .size = originalSize}, currentCGImage);

    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
    self.imageView.image = newImage;
    
    
    CGImageRelease(newCGImage);
    CGContextRelease(context);

}



@end
