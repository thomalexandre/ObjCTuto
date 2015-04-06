//
//  ViewController.m
//  Shooter
//
//  Created by Geppy Parziale on 2/24/12.
//  Copyright (c) 2012 iNVASIVECODE, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic) CALayer *customPreviewLayer;
@property (nonatomic) AVCaptureSession *captureSession;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@end


@implementation ViewController
{
    BOOL _readyForProcessing;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _readyForProcessing = YES;
    [self setupCameraSession];
}

- (IBAction)doneWithCamera:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishViewController:)]) {
        [self.delegate didFinishViewController:self];
    }
}

- (void)setupCameraSession
{
    self.captureSession = [AVCaptureSession new];
    [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];

    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
	if ( [self.captureSession canAddInput:deviceInput] )
		[self.captureSession addInput:deviceInput];
    
    // Preview
    self.customPreviewLayer = [CALayer layer];
    self.customPreviewLayer.bounds = CGRectMake(0, 0, self.backgroundView.frame.size.height, self.backgroundView.frame.size.width);
    self.customPreviewLayer.position = CGPointMake(self.backgroundView.frame.size.width/2., self.backgroundView.frame.size.height/2.);
    self.customPreviewLayer.affineTransform = CGAffineTransformMakeRotation(M_PI/2); 
    [self.backgroundView.layer addSublayer:self.customPreviewLayer];
    
    AVCaptureVideoDataOutput *dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    dataOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
                                                           forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
    [dataOutput setAlwaysDiscardsLateVideoFrames:YES];
        
    if ([self.captureSession canAddOutput:dataOutput]) {
        [self.captureSession addOutput:dataOutput];
    }
    
    [self.captureSession commitConfiguration];

    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue = dispatch_get_main_queue();
    [dataOutput setSampleBufferDelegate:self queue:queue];

    [self.captureSession startRunning];
    [self.spinner startAnimating];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (_readyForProcessing) {

        _readyForProcessing = NO;

        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        CVPixelBufferLockBaseAddress(imageBuffer, 0);

        // For the iOS the luma is contained in full plane (8-bit)
        size_t width = CVPixelBufferGetWidthOfPlane(imageBuffer, 0);
        size_t height = CVPixelBufferGetHeightOfPlane(imageBuffer, 0);
        size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);

        Pixel_8 *lumaBuffer = (Pixel_8 *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);

        const vImage_Buffer inImage = { lumaBuffer, height, width, bytesPerRow };

        Pixel_8 *outBuffer = (Pixel_8 *)calloc(width*height, sizeof(Pixel_8));
        const vImage_Buffer outImage = { outBuffer, height, width, bytesPerRow };

        vImageMin_Planar8(&inImage, &outImage, NULL, 0, 0, 79, 79, kvImageDoNotTile);
        //processingImage(inImage, &outImage, 79, 79);

        CGColorSpaceRef grayColorSpace = CGColorSpaceCreateDeviceGray();
        CGContextRef context = CGBitmapContextCreate(outImage.data, width, height, 8, bytesPerRow, grayColorSpace, kCGBitmapByteOrderDefault);
        CGImageRef dstImageFilter = CGBitmapContextCreateImage(context);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.customPreviewLayer setContents:(__bridge id)dstImageFilter];
        });

        _readyForProcessing = YES;

        CGContextRelease(context);
        CGColorSpaceRelease(grayColorSpace);
        CGImageRelease(dstImageFilter);
        free(outBuffer);
    }
}

void processingImage(const vImage_Buffer src, const vImage_Buffer *dst, vImagePixelCount kernel_height, vImagePixelCount kernel_width)
{
    size_t width = src.width;
    size_t height = src.height;
    Pixel_8 *bitmap = (Pixel_8 *)src.data;
    Pixel_8 *transformedBitmap = (Pixel_8 *)dst->data;

    unsigned long M = (kernel_width-1)/2;
    unsigned long N = (kernel_height-1)/2;

    Pixel_8 sum;
    for (unsigned long i=N; i<height-(N+1); i++) {
        for (unsigned long j=M; j<width-(M+1); j++) {

            sum = 0;
            for (unsigned long x = 0; x < N; x++) {
                for (unsigned long y = 0; y < M; y++) {
                    sum += *(bitmap + (i-x)*width + (j-y));
                }
            }
            transformedBitmap[i*width+j] = sum;
        }
    }
}

@end
